import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_list/model/item.dart';
import 'package:shopping_list/model/overview.dart';

class ItemService {
  final String _serviceUrl = 'kesali-shopping.herokuapp.com';

  Future<List<Item>> fetchItems() async {
    var uri = Uri.https(_serviceUrl, "item");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);

      return items.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<void> addToArchive() async {
    var uri = Uri.https(_serviceUrl, "history");

    final response = await http.post(uri);

    if (response.statusCode != 201) {
      throw Exception("Something went wrong");
    }
  }

  Future<List<Item>> fetchArchive(int take, int skip) async {
    var parameters = {"take": take.toString(), "skip": skip.toString()};

    var uri = Uri.https(_serviceUrl, "history", parameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);

      return items.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<Item> addItem(Item item) async {
    var uri = Uri.https(_serviceUrl, "item");

    final response = await http.post(uri,
        headers: {'content-type': 'application/json'}, body: item.toJson());

    if (response.statusCode == 201) {
      Map item = json.decode(response.body);

      return Item.fromJson(item);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<Item> editItem(Item item) async {
    var uri = Uri.https(_serviceUrl, "item/${item.id}");

    final response = await http.patch(uri,
        headers: {'content-type': 'application/json'}, body: item.toJson());

    if (response.statusCode == 200) {
      Map item = json.decode(response.body);

      return Item.fromJson(item);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<Overview> overview() async {
    var uri = Uri.https(_serviceUrl, "overview");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map overview = json.decode(response.body);

      return Overview.fromJson(overview);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
