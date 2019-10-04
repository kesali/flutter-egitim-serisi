import 'package:flutter/material.dart';
import 'package:shopping_list/http/item_service.dart';
import 'package:shopping_list/model/overview.dart';

class ShoppingListMainPage extends StatefulWidget {
  ShoppingListMainPage({Key key}) : super(key: key);

  _ShoppingListMainPageState createState() => _ShoppingListMainPageState();
}

class _ShoppingListMainPageState extends State<ShoppingListMainPage> {
  ItemService _itemService;

  @override
  void initState() {
    _itemService = ItemService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text('Overview'),
        ),
        FutureBuilder(
          future: _itemService.overview(),
          builder: (BuildContext context, AsyncSnapshot<Overview> snapshot) {
            if (!snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              );
            }
            return Expanded(
              child: RefreshIndicator(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    GridItem(
                      icon: Icons.shopping_basket,
                      title: 'Total Items',
                      total: snapshot.data.total,
                    ),
                    GridItem(
                      icon: Icons.add_shopping_cart,
                      title: 'Current Items',
                      total: snapshot.data.current,
                    ),
                    GridItem(
                      icon: Icons.history,
                      title: 'Completed Items',
                      total: snapshot.data.completed,
                    ),
                    GridItem(
                      icon: Icons.remove_shopping_cart,
                      title: 'Deleted Items',
                      total: snapshot.data.deleted,
                    ),
                  ],
                ),
                onRefresh: () async {
                  setState(() {});
                },
              ),
            );
          },
        )
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int total;

  const GridItem({
    @required this.icon,
    @required this.title,
    @required this.total,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              size: 64,
              color: Colors.greenAccent,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 16,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Text(
              total.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
