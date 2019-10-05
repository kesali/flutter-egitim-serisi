import 'package:flutter/material.dart';
import 'package:shopping_list/services/advert-service.dart';
import 'package:shopping_list/ui/shopping_list_history_page.dart';
import 'package:shopping_list/ui/shopping_list_item_page.dart';
import 'package:shopping_list/ui/shopping_list_main.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  int _selectedIndex = 0;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  final AdvertService _advertService = AdvertService();

  @override
  void initState() {
    _pageController.addListener(() {
      int currentIndex = _pageController.page.round();
      if (currentIndex != _selectedIndex) {
        _selectedIndex = currentIndex;

        setState(() {});
      }
    });
    _advertService.showBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text("Shopiing List")),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), title: Text("History")),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          ShoppingListMainPage(),
          ShoppingListItemPage(),
          ShoppingListHistoryPage(),
        ],
      ),
    );
  }

  void _onTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
