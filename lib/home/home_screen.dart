import 'package:flutter/material.dart';
import 'package:flutter_wechat/constants.dart' show AppColors, Constants;
import 'package:flutter_wechat/home/discover_page.dart';
import 'contacts_page.dart';
import 'conversation_page.dart';

enum ActionIterms {
  GROUP_CHAT,ADD_FRIEND,QR_SCAN,PAYMENT,HELP
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  PageController _pageController;
  List<Widget> _pages;

  void initState() {
    super.initState();
    _navigationViews = [
      NavigationIconView(
        title: '微信',
        icon: IconData(
          0xe608,
          fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe603,
          fontFamily: Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
        title: '通讯录',
        icon: IconData(
          0xe601,
          fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe656,
          fontFamily: Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
        title: '发现',
        icon: IconData(
          0xe600,
          fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe671,
          fontFamily: Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
        title: '我',
        icon: IconData(
          0xe6c0,
          fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe626,
          fontFamily: Constants.IconFontFamily,
        ),
      ),
    ];
    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      ConversationPage(),
      ContactsPage(),
      DiscoverPage(),
      Container(color: Colors.grey,),
    ];
  }

  /// 抽象方法创建弹出菜单条目
  _buildPopupMenuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Icon(
          IconData(
            iconName,
            fontFamily: Constants.IconFontFamily,
          ),
          color: const Color(AppColors.AppBarPopupMenuColor),
          size: 22.0,
        ),
        Container(
          width: 12.0,
        ),
        Text(title, style: TextStyle(color: const Color(AppColors.AppBarPopupMenuColor)),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      fixedColor: const Color(AppColors.TabIconActive),
      items: _navigationViews.map((NavigationIconView view) => view.item).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '微信',
        ),
        // 层级  就是阴影效果
        elevation: 0.0,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => print('点击了搜索按钮'),
            ),
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<ActionIterms>>[
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe69e, "发起群聊"),
                  value: ActionIterms.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe638, "添加朋友"),
                  value: ActionIterms.ADD_FRIEND,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe61b, "扫一扫"),
                  value: ActionIterms.QR_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe62a, "收付款"),
                  value: ActionIterms.PAYMENT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe63d, "帮助与反馈"),
                  value: ActionIterms.HELP,
                ),
              ];
            },
            icon: Icon(
              IconData(
                0xe60e,
                fontFamily: Constants.IconFontFamily,
              ),
              size: 22.0,
            ),
            onSelected: (ActionIterms selected) => print("点击了 $selected "),
          ),
          Container(
            width: 16.0,
          ),
        ],
      ),
      body: PageView.builder(itemBuilder: (BuildContext context, int index) {
        return _pages[index];
      },
      controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}

class NavigationIconView {
  final String _title;
  final IconData _icon;
  final IconData _activeIcon;
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData icon, IconData activeIcon})
      : _title = title,
        _icon = icon,
        _activeIcon = activeIcon,
        item = BottomNavigationBarItem(
          icon: Icon(icon,),
          activeIcon: Icon(activeIcon,),
          title: Text(title,),
          backgroundColor: Colors.white,
        );
}
