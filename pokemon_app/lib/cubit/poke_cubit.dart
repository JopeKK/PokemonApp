import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/data/poke_repository.dart';

part 'poke_state.dart';

class PokeCubit extends Cubit<PokeState> {
  final Repo repo;
  Timer? intervalTimer;

  PokeCubit(this.repo) : super(const PokeInitial()) {
    moveToMainScreen();
  }

  Future<void> moveToMainScreen() async {
    //https://pokeapi.co/api/v2/pokemon
    emit(const PokeLoading());

    final List<PokeModel> pokemonList = await repo.getAllNamesApi();
    if (pokemonList == []) {
      emit(const PokeError());
      return;
    }

    await repo.saveAllPokeToLocal(pokemonList);

    generateLocation();
    loopLocationGenerator();

    emit(PokeMainScreen(pokemonList, pokemonList));
  }

  Future<void> searchingPokemon(
    String search,
    List<PokeModel> pokemonList,
  ) async {
    List<PokeModel> filterdList = [];

    if (search.isEmpty) {
      emit(PokeMainScreen(pokemonList, pokemonList));
      return;
    }

    filterdList = pokemonList
        .where((pokemon) =>
            pokemon.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    emit(PokeMainScreen(pokemonList, filterdList));
  }

  Future<void> cleanSearch(List<PokeModel> pokemonList) async {
    emit(PokeMainScreen(pokemonList, pokemonList));
  }

  Future<void> loopLocationGenerator() async {
    intervalTimer = Timer.periodic(const Duration(seconds: 10), (tick) {
      generateLocation();
    });
  }

  Future<void> generateLocation() async {
    final List<PokeModel> items = await repo.loadAllPokeFromLocal();

    for (var i = 0; i < items.length; i++) {
      items[i] = PokeModel(
        name: items[i].name,
        type: items[i].type,
        lat: -90 + 180 * (Random().nextDouble()),
        lng: -180 + 360 * (Random().nextDouble()),
        photo: items[i].photo,
      );
    }

    repo.saveAllPokeToLocal(items);
    emit(PokeMainScreen(items, items));
  }

  @override
  Future<void> close() {
    intervalTimer?.cancel();
    return super.close();
  }
}
