import 'package:flutter/material.dart';

import '../modal/me.dart' show me;
import '../constants.dart' show AppColors, AppStyles;
import './full_width_button.dart';

class _Header extends StatelessWidget {
  static const AVATAR_SIZE = 72.0;
  static const SEPARATOR_SIZE = 16.0;
  static const QR_CODE_PREV_SIZE = 20.0;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){},
      color: AppColors.HeaderCardBg,
      padding: const EdgeInsets.only(left: SEPARATOR_SIZE, right: SEPARATOR_SIZE, top: 10.0, bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            me.avatar,
            width: AVATAR_SIZE,
            height: AVATAR_SIZE,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: SEPARATOR_SIZE, bottom: 5.0),
                  child: Text(me.name, style: AppStyles.HeaderCardTitleTextStyle),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: SEPARATOR_SIZE),
                  child: Text(me.account, style: AppStyles.HeaderCardDesTextStyle),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/ic_qrcode_preview_tiny.png',
            width: QR_CODE_PREV_SIZE,
            height: QR_CODE_PREV_SIZE,
          )
        ],
      ),
    );
  }
}

class FunctionsPage extends StatefulWidget {
  @override
  _FunctionsPageState createState() => _FunctionsPageState();
}

class _FunctionsPageState extends State<FunctionsPage> {
  static const SEPARATOR_SIZE = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.BackgroundColor),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: SEPARATOR_SIZE),
            _Header(),
            SizedBox(height: SEPARATOR_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_wallet.png',
              title: '钱包',
              onPressed: () {print('点击的是钱包按钮。');},
            ),
            SizedBox(height: SEPARATOR_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_collections.png',
              title: '收藏',
              showDivider: true,
              onPressed: () {print('点击的是收藏按钮。');},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_album.png',
              title: '相册',
              showDivider: true,
              onPressed: () {print('点击的是相册按钮。');},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_cards_wallet.png',
              title: '卡包',
              showDivider: true,
              onPressed: () {print('打开卡包应用');},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_emotions.png',
              title: '表情',
              onPressed: () {print('打开表情应用');},
            ),
            SizedBox(height: SEPARATOR_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_settings.png',
              title: '设置',
              des: '账号未保护',
              onPressed: () {print('打开设置');},
            ),
          ],
        ),
      ),
    );
  }
}