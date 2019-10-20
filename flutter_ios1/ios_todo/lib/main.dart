import 'package:flutter/cupertino.dart';
import 'package:ios_todo/pages/add-page.dart';

void main() => runApp(IosTodo());

class IosTodo extends StatelessWidget {
  const IosTodo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Ios Todo App',
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.add_circled_solid)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell_solid)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings_solid))
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Ios Todo Example ' + index.toString()),
              trailing: Icon(
                CupertinoIcons.heart_solid,
                color: CupertinoColors.destructiveRed,
              ),
            ),
            child: CupertinoTabView(
              builder: (context) {
                switch (index) {
                  case 0:
                    return AddPage();
                    break;
                  case 1:
                    return Container(
                      child: Center(
                        child: Text(index.toString()),
                      ),
                    );
                    break;
                  case 2:
                    return Container(
                      child: Center(
                        child: Text(index.toString()),
                      ),
                    );
                    break;
                  default:
                    return Container();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
