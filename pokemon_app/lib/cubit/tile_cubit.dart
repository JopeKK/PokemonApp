import 'package:bloc/bloc.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/data/poke_repository.dart';

part 'tile_state.dart';

class TileCubit extends Cubit<TileState> {
  final Repo repo;
  TileCubit(this.repo) : super(TileInitial());

  Future<void> loadTile(String name) async {
    //https://pokeapi.co/api/v2/pokemon

    String type = '';
    String photo = '';
    if ((type = await repo.getItemsLocal(name)) != '') {
      emit(TileLoaded(name, type));
      return;
    }

    [type, photo] = await repo.getPokeTypeApi(name);

    if (type != '') {
      repo.saveItemsLocal(
          PokeModel(name: name, type: type, lat: 0, lng: 0, photo: photo));
      emit(TileLoaded(name, type));
      return;
    }

    emit(TileError());
  }
}
