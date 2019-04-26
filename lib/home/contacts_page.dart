import 'package:flutter/material.dart';
import '../modal/contacts.dart' show Contact, ContactsPageData;
import '../constants.dart' show AppColors, AppStyles, Constants;

class _ContactItem extends StatelessWidget {
  _ContactItem({
    @required this.avatar,
    @required this.title,
    this.groupTitle,
    this.onPressed,
  });

  final String avatar;
  final String title;
  final String groupTitle;
  final VoidCallback onPressed;

  static const double MARGIN_VERTICAL = 10.0;
  //final double BUTTON_HEIGHT = 48.0;
  static const double GROUP_TITLE_HEIGHT = 24.0;

  // 判断图片是否来自网络
  bool get _isAvatarFromNet {
    return this.avatar.startsWith('http') || this.avatar.startsWith('https');
  }

  // 计算控件高度
  static double _height(bool hasGroupTitle) {
    final _buttonHeigit = MARGIN_VERTICAL * 2 + Constants.ContactAvatarSize + Constants.DividerWidth;
    if (hasGroupTitle) {
      return _buttonHeigit + GROUP_TITLE_HEIGHT;
    } else {
      return _buttonHeigit;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 左边图标
    Widget _avatarIcon;
    if(_isAvatarFromNet) {
      _avatarIcon = Image.network(
              avatar,
              width: Constants.ContactAvatarSize,
              height: Constants.ContactAvatarSize,);
    } else {
      _avatarIcon = Image.asset(
              avatar,
              width: Constants.ContactAvatarSize,
              height: Constants.ContactAvatarSize,);
    }

    // 列表项主体
    Widget _button = Container(
      // symmetric 对称的操作
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: MARGIN_VERTICAL),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: Constants.DividerWidth, 
            color: Color(AppColors.DividerColor)
            ),
        )
      ),
      child: Row(
        children: <Widget>[
          _avatarIcon,
          SizedBox(width: 10.0,),
          Text(title),
        ],
      ),
    );

    // 分组标签
    Widget _itemBody;
    if (this.groupTitle != null) {
      _itemBody = Column(
        children: <Widget>[
          Container(
            height: GROUP_TITLE_HEIGHT,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0,),
            color: const Color(AppColors.ContactGroupTitleBg),
            alignment: Alignment.centerLeft,
            child: Text(
              this.groupTitle,
              style: AppStyles.GroupTitleItemTextStyle,
            ),
          ),
          _button,
        ],
      );
    } else {
      _itemBody = _button;
    }

    return _itemBody;
  }
}

const INDEX_BAR_WORDS = [
  "↑", "☆",
  "A", "B", "C", "D", "E", "F", "G",
  "H", "I", "J", "K", "L", "M", "N",
  "O", "P", "Q", "R", "S", "T", "U",
  "V", "W", "X", "Y", "Z"
];

class ContactsPage extends StatefulWidget {
  Color _indexBarBg = Colors.transparent;
  String _currentLetter = '';
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  // listview提供的用于控制滚动的控件
  ScrollController _scrollController;
  final ContactsPageData data = ContactsPageData.mock();
  final List<Contact> _contacts = [];
  // 功能性列表
  final List<_ContactItem> _functionButtons = [
    _ContactItem(
      avatar: 'assets/images/ic_new_friend.png',
      title: '新的朋友',
      onPressed: () {print('添加新朋友');},
    ),
    _ContactItem(
      avatar: 'assets/images/ic_group_chat.png',
      title: '群聊',
      onPressed: () {print('群聊');},
    ),
    _ContactItem(
      avatar: 'assets/images/ic_tag.png',
      title: '标签',
      onPressed: () {print('标签');},
    ),
    _ContactItem(
      avatar: 'assets/images/ic_public_account.png',
      title: '公众号',
      onPressed: () {print('公众号');},
    ),
  ];
  // 位置map  默认是第一个
  final Map _letterPosMap = {INDEX_BAR_WORDS[0]: 0.0};
  @override
  void initState() {
    super.initState();
    // 链式调用
    _contacts..addAll(data.contacts)
            ..addAll(data.contacts)
            ..addAll(data.contacts);
    // 排序
    _contacts.sort((Contact a, Contact b) => a.nameIndex.compareTo(b.nameIndex));
    _scrollController = new ScrollController();
    // 计算用于indexbar进行经纬的关键通讯录列表项的位置
    var _totalPos = _functionButtons.length * _ContactItem._height(false);
    for (var i = 1; i < _contacts.length; i++) {
      bool _hasGroupTitle = true;
      if(i > 0 && _contacts[i].nameIndex.compareTo(_contacts[i -1].nameIndex) == 0) {
        _hasGroupTitle = false;
      }
      if(_hasGroupTitle) {
        _letterPosMap[_contacts[i].nameIndex] = _totalPos;
      }
      _totalPos += _ContactItem._height(_hasGroupTitle);
    }
  }

  @override
  void dispose() {
    // 销毁控件
    _scrollController.dispose();
    super.dispose();
  }

  String getLetter(BuildContext context, double tileHeight, Offset globalPos) {
    RenderBox _box = context.findRenderObject();
    var local = _box.globalToLocal(globalPos);
    // clamp 范围界定
    int index = (local.dy ~/ tileHeight).clamp(0, INDEX_BAR_WORDS.length - 1);
    return INDEX_BAR_WORDS[index];
  }

  // 跳转到对应的位置
  void _jumpToIndex(String letter) {
    if(_letterPosMap.isNotEmpty) {
      final _pos = _letterPosMap[letter];
      if(_pos != null) {
        _scrollController.animateTo(_pos, curve: Curves.easeIn, duration: Duration(milliseconds: 200));
      }
    }
  }

  // 构建indexbar
  Widget _buildIndexBar(BuildContext context, BoxConstraints constraints) {
    final List<Widget> _letters = INDEX_BAR_WORDS.map((String word) {
      // Expanded自动填充控件
      return Expanded(
        child: Text(word),
      );
    }).toList();

    final _totalHeight = constraints.biggest.height;
    // 每个空间的高度    ~ 取整
    final double _tileHeight = _totalHeight / _letters.length;
    return GestureDetector(
        // 按下
        onVerticalDragDown: (DragDownDetails details) {
          setState(() {
            widget._indexBarBg = Colors.black26;
            widget._currentLetter = getLetter(context, _tileHeight, details.globalPosition);
            _jumpToIndex(widget._currentLetter);
          });
        },
        // 按下滑动松开
        onVerticalDragEnd: (DragEndDetails details) {
          setState(() {
            widget._indexBarBg = Colors.transparent;
            widget._currentLetter = null;
          });
        },
        // 按下不滑动直接松开
        onVerticalDragCancel: () {
          setState(() {
            widget._indexBarBg = Colors.transparent;
            widget._currentLetter = null;
          });
        },
        // 拖动
        onVerticalDragUpdate: (DragUpdateDetails details) {
          setState(() {
            widget._indexBarBg = Colors.black26;
            widget._currentLetter = getLetter(context, _tileHeight, details.globalPosition);
            _jumpToIndex(widget._currentLetter);
          });
        },
        child: Column(
          children: _letters,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _body = [
    ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if(index < _functionButtons.length) {
            return _functionButtons[index];
          }
          int _contactIndex = index - _functionButtons.length;
          Contact _contact = _contacts[_contactIndex];
          bool _isGroupTitle = true;
          if(_contactIndex >= 1 && _contact.nameIndex == _contacts[_contactIndex -1].nameIndex) {
              _isGroupTitle = false;
          }
          return _ContactItem(
            avatar: _contact.avatar,
            title: _contact.name,
            groupTitle: _isGroupTitle ? _contact.nameIndex : null,
          );
        },
        itemCount: _contacts.length + _functionButtons.length,
        controller: _scrollController,
      ),
      // 联系人字母索引列表
      Positioned(
        width: Constants.IndexBarWidth,
        right: 0.0,
        top: 0.0,
        bottom: 0.0,
        child: Container(
          color: widget._indexBarBg,
          child: LayoutBuilder(
            builder: _buildIndexBar,
          ),
        ),
      ),
    ];

    if(widget._currentLetter != null && widget._currentLetter.isNotEmpty) {
      _body.add(
        Center(
          child: Container(
            alignment: Alignment.center,
            width: Constants.IndexLetterBoxSize,
            height: Constants.IndexLetterBoxSize,
            decoration: BoxDecoration(
              color: AppColors.IndexLetterBoxBg,
              borderRadius: BorderRadius.all(Radius.circular(Constants.IndexLetterBoxRadius)),
            ),
            child: Text(widget._currentLetter, style: AppStyles.IndexLetterBoxTextStyle),
          ),
        ),
      );
    }
    // 层级布局
    return Stack(
      children: _body,
    );
  }
}