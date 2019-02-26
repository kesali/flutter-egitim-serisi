import 'package:flutter/material.dart';
import 'package:shopping_list/ui/dialog/item_dialog.dart';
import 'package:shopping_list/ui/shopping_list_items_page.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPage createState() => _ShoppingListPage();
}

class _ShoppingListPage extends State<ShoppingListPage> {
  int _selectedIndex = 0;

  PageController _pageController = PageController();

  @override
  void initState() {
    _pageController.addListener(() {
      final int currentIndex = _pageController.page.round();
      if (currentIndex != _selectedIndex) {
        setState(() {
          _selectedIndex = currentIndex;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Container(
            child: Center(
              child: Text(_selectedIndex.toString()),
            ),
          ),
          ShoppingListItemsPage(),
          Container(
            child: Center(
              child: Text(_selectedIndex.toString()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var name = await showDialog(
              context: context,
              builder: (BuildContext context) => ItemDialog());
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Shopping List'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text('History'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _pageController.jumpToPage(index);
      _selectedIndex = index;
    });
  }
}
