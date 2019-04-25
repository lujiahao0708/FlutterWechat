import 'package:flutter/material.dart';

class AppColors {
  static const AppBarColor = 0xff303030;
  static const TabIconActive = 0xff46c11b;
  static const TabIconNormal = 0xff999999;
  static const AppBarPopupMenuColor = 0xffffffff;
  static const TitleTextColor = 0xff353535;
  static const ConversationItemBg = 0xffffffff;
  static const DescTextColor = 0xff9e9e9e;
  static const DividerColor = 0xffd9d9d9;
  static const NofityDotBg = 0xffff3e3e;
  static const NofityDotText = 0xffffffff;
  static const ConversationMuteIcon = 0xffd8d8d8;
}

class AppStyles {
  static const TitleStyle = TextStyle(
    fontSize: 14.0,
    color: Color(AppColors.TitleTextColor),
  );

  static const DesStyle = TextStyle(
    fontSize: 12.0,
    color: Color(AppColors.DescTextColor),
  );

  static const UnReadMsgCountDotStyle = TextStyle(
    fontSize: 12.0,
    color: Color(AppColors.NofityDotText),
  );
}

class Constants {
  static const IconFontFamily = "appIconFont";
  static const ConversationAvatarSize = 48.0;
  static const DividerWidth = 1.0;
  static const UnReadMsgNotifyDotSize = 20.0;
  static const ConversationMuteIconSize = 18.0;
}