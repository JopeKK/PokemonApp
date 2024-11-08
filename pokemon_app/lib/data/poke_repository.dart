import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pokemon_app/data/model/poke.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Repo {
  Future<List<PokeModel>> getAllNamesApi();
  Future<String> getPokeTypeApi(String name);
  Future<String> getItemsLocal(String name);
  Future<void> saveItemsLocal(PokeModel item);
}

class PokeRepository implements Repo {
  @override
  Future<List<PokeModel>> getAllNamesApi() async {
    List<PokeModel> items = [];

    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1000'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results'];
      items = results.map<PokeModel>((pokemon) {
        final name = pokemon['name'] as String;
        return PokeModel(name: name, type: '');
      }).toList();

      return items;
    } else {
      return [];
    }
  }

  @override
  Future<String> getPokeTypeApi(String name) async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'));

    if (response.statusCode == 200) {
      final types = json.decode(response.body);
      final type = types['types'][0]['type']['name'];
      return type;
    } else {
      return '';
    }
  }

  @override
  Future<String> getItemsLocal(String name) async {
    final SharedPreferences db = await SharedPreferences.getInstance();

    String item = db.getString(name) ?? '';

    return item;
  }

  @override
  Future<void> saveItemsLocal(PokeModel item) async {
    final SharedPreferences db = await SharedPreferences.getInstance();
    db.setString(item.name, item.type);
  }
}
