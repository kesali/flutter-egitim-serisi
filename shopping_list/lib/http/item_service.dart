import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_list/model/item.dart';

class ItemService {
  String _serviceUrl = 'https://kesali-shopping.herokuapp.com/item/';

  Future<List<Item>> fetchItems() async {
    final response = await http.get(_serviceUrl);

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);
      return items.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<Item> addItem(Item item) async {
    final response = await http.post(_serviceUrl, headers: {
      "content-type" : "application/json"
    }, body: json.encode(item.toMap()));

    if (response.statusCode == 201) {
      Map<String, dynamic> item = json.decode(response.body);
      return Item.fromJson(item);
    } else {
      throw Exception('Failed to add item');
    }
  }
}
