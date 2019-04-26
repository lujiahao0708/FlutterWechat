import 'package:flutter/material.dart';
import '../constants.dart' show AppColors, AppStyles, Constants;
import '../modal/conversation.dart' show Conversation, Device, ConversationPageData;

class ConversationPage extends StatefulWidget {

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final ConversationPageData data = ConversationPageData.mock();

  @override
  Widget build(BuildContext context) {
    var mockConversations = data.conversations;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if(data.device != null) {
          return index == 0 ? _DeviceInfoItem(device: data.device,) : _ConversationItem(conversation: mockConversations[index-1],);
        } else {
          return _ConversationItem(conversation: mockConversations[index],);
        }
      },
      itemCount: data.device != null ? mockConversations.length + 1 : mockConversations.length,
    );
  }
}

// 每个列表项的控件
class _ConversationItem extends StatelessWidget {
  const _ConversationItem({Key key, this.conversation})
      : assert(conversation != null),
      super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    // 根据图片获取方式
    if (conversation.isAvatarFromNet()) {
      avatar = Image.network(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    } else {
      avatar = Image.asset(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,);
    }

    Widget avatarContainer;

    if (conversation.unreadMsgCount > 0) {
      // 未读消息角标 控件
      Widget unReadMsgCountText = Container(
        width: Constants.UnReadMsgNotifyDotSize,
        height: Constants.UnReadMsgNotifyDotSize,
        // 布局
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // 圆角
          borderRadius: BorderRadius.circular(Constants.UnReadMsgNotifyDotSize / 2.0),
          color: Color(AppColors.NofityDotBg),
        ),
        child: Text(conversation.unreadMsgCount.toString(), style: AppStyles.UnReadMsgCountDotStyle,),
      );

      // 头像组合控件
      avatarContainer = Stack(
        // 超出Stack控件部分显示效果
        overflow: Overflow.visible,
        children: <Widget>[
          avatar,
          Positioned(
            right: -6.0,
            top: -6.0,
            child: unReadMsgCountText,
          ),
        ],
      );
    } else {
      avatarContainer = avatar;
    }

    // 免打扰图标
    Widget muteIcon = Icon(
      IconData(
        0xe755,
        fontFamily: Constants.IconFontFamily,
      ),
      color: Color(AppColors.ConversationMuteIcon),
      size: Constants.ConversationMuteIconSize,
    );

    // 动态显示免打扰图标
    var _rightArea = <Widget>[
      Text(conversation.updateAt, style: AppStyles.DesStyle,),
      // 增加间隔
      SizedBox(height: 10.0,),
    ];
    if(conversation.isMute) {
      _rightArea.add(muteIcon);
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      // 增加分割线
      decoration: BoxDecoration(
          color: Color(AppColors.ConversationItemBg),
        border: Border(
          bottom: BorderSide(
            color: Color(AppColors.DividerColor),
            width: Constants.DividerWidth,
          ),
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          avatarContainer,

          // 增加间隔 1.使用padding 2.增加一个container
          Container(width: 10.0,),

          // 可扩展控件，先让其他控件占位  然后自己在填充
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  conversation.title,
                  style: AppStyles.TitleStyle,
                ),
                Text(
                  conversation.des,
                  style: AppStyles.DesStyle,
                ),
              ],
            ),
          ),
          Container(width: 10.0,),

          Column(
            children: _rightArea,
          ),
        ],
      ),
    );
  }
}


// 头部设备条目
class _DeviceInfoItem extends StatelessWidget {
  final Device device;

  const _DeviceInfoItem({this.device: Device.MAC}): assert(device != null);

  int get iconName {
    return device == Device.MAC ? 0xe61c : 0xe6b3;
  }

  String get deviceName {
    return device == Device.MAC ? 'Mac' : 'Windows';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24.0, top: 14.0, right: 24.0, bottom: 14.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: Constants.DividerWidth, color: Color(AppColors.DividerColor))
        ),
        color: Color(AppColors.DividerColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(IconData(
            this.iconName,
            fontFamily: Constants.IconFontFamily,
          ),
          size: 24.0, color: Color(AppColors.DeviceInfoItemIcon),),
          SizedBox(width: 24.0,),
          Text('$deviceName 微信已登录，手机通知已关闭。', style: AppStyles.DeviceInfoItemTextStyle,)
        ],
      ),
    );
  }
}
