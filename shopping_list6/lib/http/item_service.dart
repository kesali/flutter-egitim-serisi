import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_list/model/item.dart';

class ItemService {
  final String _serviceUrl = 'https://kesali-shopping.herokuapp.com/';

  Future<List<Item>> fetchItems() async {
    final response = await http.get(_serviceUrl + "item/");

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);

      return items.map((item)=>Item.fromJson(item)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<void> addToArchive() async {
    final response = await http.post(_serviceUrl + "history/");

    if(response.statusCode != 201) {
      throw Exception("Something went wrong");
    }
  }

  Future<Item> addItem(Item item) async {
    final response = await http.post(_serviceUrl + "item/", headers: {
      'content-type':'application/json'
    }, body: item.toJson());

    if(response.statusCode == 201) {
      Map item = json.decode(response.body);

      return Item.fromJson(item);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<Item> editItem(Item item) async{
    final response = await http.patch('${_serviceUrl}item/${item.id}', headers: {
      'content-type': 'application/json'
    }, body: item.toJson());

    if(response.statusCode == 200) {
      Map item = json.decode(response.body);

      return Item.fromJson(item);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
