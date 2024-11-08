import 'package:bloc/bloc.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/data/poke_repository.dart';

part 'poke_state.dart';

class PokeCubit extends Cubit<PokeState> {
  final Repo repo;
  PokeCubit(this.repo) : super(const PokeInitial());

  Future<void> moveToMainScreen() async {
    //https://pokeapi.co/api/v2/pokemon
    emit(const PokeLoading());

    final List<PokeModel> pokemonList = await repo.getAllNamesApi();
    if (pokemonList == []) {
      emit(const PokeError());
      return;
    }

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
}
