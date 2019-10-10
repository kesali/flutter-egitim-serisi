import 'package:flutter/cupertino.dart';
import 'package:flutter_ios/pages/add-page.dart';

void main() => runApp(IosExample());

class IosExample extends StatelessWidget {
  const IosExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'IOS Example App',
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add_circled_solid),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bell_solid),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings_solid),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("IOS Example App $index"),
              trailing: Icon(
                CupertinoIcons.heart_solid,
                color: CupertinoColors.destructiveRed,
              ),
            ),
            child: CupertinoTabView(builder: (context) {
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
            }),
          );
        },
      ),
    );
  }
}
