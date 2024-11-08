import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/poke_cubit.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/pages/widgets/list_widget.dart';
import 'package:pokemon_app/pages/widgets/text_field.dart';

class MainScreen extends StatelessWidget {
  final List<PokeModel> pokemonList;
  final List<PokeModel> filtredPokemonList;

  const MainScreen({
    super.key,
    required this.pokemonList,
    required this.filtredPokemonList,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextFieldWidget(
            myHintText: 'bulbasaur',
            onChange: (value) => searchPokemons(context, value, pokemonList),
          ),
          Expanded(child: ListWidget(pokemonList: filtredPokemonList)),
        ],
      ),
    );
  }
}

void searchPokemons(BuildContext context, String value, List<PokeModel> list) {
  final pokeCubit = BlocProvider.of<PokeCubit>(context);
  pokeCubit.searchingPokemon(value, list);
}
