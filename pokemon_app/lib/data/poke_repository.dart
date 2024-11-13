import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pokemon_app/data/model/poke.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Repo {
  Future<List<PokeModel>> getAllNamesApi();
  Future<List<String>> getPokeTypeApi(String name);
  Future<String> getItemsLocal(String name);
  Future<void> saveItemsLocal(PokeModel item);
  Future<void> saveAllPokeToLocal(List<PokeModel> items);
  Future<List<PokeModel>> loadAllPokeFromLocal();
}

class PokeRepository implements Repo {
  @override
  Future<List<PokeModel>> getAllNamesApi() async {
    List<PokeModel> items = [];

    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=3000'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results'];
      items = results.map<PokeModel>((pokemon) {
        final name = pokemon['name'] as String;
        return PokeModel(name: name, type: '', lat: 0, lng: 0, photo: '');
      }).toList();

      return items;
    } else {
      return [];
    }
  }

  @override
  Future<void> saveAllPokeToLocal(List<PokeModel> items) async {
    final SharedPreferences db = await SharedPreferences.getInstance();

    List<String> readyToSave = items
        .map(
          (item) => jsonEncode(item.toJson()),
        )
        .toList();
        
    db.setStringList('items', readyToSave);
  }

  @override
  Future<List<PokeModel>> loadAllPokeFromLocal() async {
    final SharedPreferences db = await SharedPreferences.getInstance();

    final List<String> savedItems = db.getStringList('items') ?? [];

    final List<PokeModel> items = savedItems
        .map(
          (item) => PokeModel.fromJson(jsonDecode(item)),
        )
        .toList();

    return items;
  }

  @override
  Future<List<String>> getPokeTypeApi(String name) async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'));

    if (response.statusCode == 200) {
      final types = json.decode(response.body);
      final type = types['types'][0]['type']['name'];
      final photo = types['sprites']['front_default'];
      return [type,photo];
    } else {
      return [];
    }
  }

  @override
  Future<String> getItemsLocal(String name) async {
    final List<PokeModel> items;

    final SharedPreferences db = await SharedPreferences.getInstance();

    List<String> itemsJson = db.getStringList('items') ?? [];

    items = itemsJson
        .map(
          (item) => PokeModel.fromJson(json.decode(item)),
        )
        .toList();

    for (var i = 0; i < items.length; i++) {
      if (items[i].name == name) {
        return items[i].type;
      }
    }

    return '';
  }

  @override
  Future<void> saveItemsLocal(PokeModel item) async {
    final List<PokeModel> items;
    final SharedPreferences db = await SharedPreferences.getInstance();

    List<String> itemsJson = db.getStringList('items') ?? [];

    items = itemsJson
        .map(
          (item) => PokeModel.fromJson(json.decode(item)),
        )
        .toList();

    for (var i = 0; i < items.length; i++) {
      if (items[i].name == item.name) {
        items[i] = item;
        break;
      }
    }

    List<String> readyToSave = items
        .map(
          (item) => jsonEncode(item.toJson()),
        )
        .toList();
    db.setStringList('items', readyToSave);
  }
}
