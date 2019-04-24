import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavigationIconView> _navigationViews;

  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
        title: '微信',
        icon: Icon(Icons.settings),
        activeIcon: Icon(Icons.settings_applications),
      ),
      NavigationIconView(
        title: '通讯录',
        icon: Icon(Icons.settings),
        activeIcon: Icon(Icons.settings_applications),
      ),
      NavigationIconView(
        title: '发现',
        icon: Icon(Icons.settings),
        activeIcon: Icon(Icons.settings_applications),
      ),
      NavigationIconView(
        title: '我',
        icon: Icon(Icons.settings),
        activeIcon: Icon(Icons.settings_applications),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view) => view.item).toList(),
      // items: _navigationViews.map((NavigationIconView view){
      //   return view.item;
      // }).toList(),
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        print('点击 $index');
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('微信',),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => print('点击了搜索按钮'),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => print('显示下拉列表'),
          ),
        ],
      ),
      body: Container(
        color: Colors.redAccent,
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}

class NavigationIconView {
  final String _title;
  final Widget _icon;
  final Widget _activeIcon;
  final BottomNavigationBarItem item;

  NavigationIconView({Key key, String title, Widget icon, Widget activeIcon}) :
    _title = title,
    _icon = icon,
    _activeIcon = activeIcon,
    item = BottomNavigationBarItem(
      icon: icon,
      activeIcon: activeIcon,
      title: Text(title),
      backgroundColor: Colors.white,
    );

}