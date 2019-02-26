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
}
