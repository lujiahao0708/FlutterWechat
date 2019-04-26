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

  // 判断图片是否来自网络
  bool get _isAvatarFromNet {
    return this.avatar.startsWith('http') || this.avatar.startsWith('https');
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
        padding: const EdgeInsets.only(left:16.0, right:16.0,top: 10.0, bottom: 10.0),
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
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
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
    // return Container(
    //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
    //   child: _itemBody,
    // );
  }
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
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

  @override
  void initState() {
    super.initState();
    // 链式调用
    _contacts..addAll(data.contacts)
            ..addAll(data.contacts)
            ..addAll(data.contacts);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if(index < _functionButtons.length) {
          return _functionButtons[index];
        }
        int _contactIndex = index - _functionButtons.length;
        Contact _contact = _contacts[_contactIndex];
        return _ContactItem(
          avatar: _contact.avatar,
          title: _contact.name,
          groupTitle: _contact.nameIndex,
        );
      },
      itemCount: _contacts.length + _functionButtons.length,
    );
  }
}