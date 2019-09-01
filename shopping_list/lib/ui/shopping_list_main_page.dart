import 'package:flutter/material.dart';
import 'package:shopping_list/http/item_service.dart';
import 'package:shopping_list/model/overview.dart';

class ShoppingListMainPage extends StatefulWidget {
  @override
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
          title: Text("Overview"),
        ),
        FutureBuilder(
          future: _itemService.overview(),
          builder: (BuildContext context, AsyncSnapshot<Overview> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Expanded(
              child: RefreshIndicator(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    new GridItem(
                      icon: Icons.shopping_basket,
                      title: 'Total Items',
                      total: snapshot.data.total,
                    ),
                    new GridItem(
                      icon: Icons.add_shopping_cart,
                      title: 'Current Items',
                      total: snapshot.data.current,
                    ),
                    new GridItem(
                      icon: Icons.history,
                      title: 'Completed Items',
                      total: snapshot.data.completed,
                    ),
                    new GridItem(
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
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int total;

  const GridItem(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.greenAccent,
              size: 64,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 20),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              total.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
