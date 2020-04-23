import 'package:flutter/cupertino.dart';

class NavigatorService {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void pop() {
    _navigatorKey.currentState.pop();
  }

  Future<dynamic> pusnNamed(String route, {Object arguments}) {
    return _navigatorKey.currentState.pushNamed(route, arguments: arguments);
  }

  Future<dynamic> replaceNamed(String route, {Object arguments}) {
    return _navigatorKey.currentState
        .pushReplacementNamed(route, arguments: arguments);
  }
}
