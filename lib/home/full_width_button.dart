import 'package:flutter/material.dart';
import '../constants.dart' show Constants, AppColors, AppStyles;

class FullWidthButton extends StatelessWidget {
  static const HORIZONTAL_PADDING = 20.0;
  static const VERTICAL_PADDING = 16.0;
  static const HEIGHT = Constants.FullWidthIconButtonIconSize + VERTICAL_PADDING * 2;
  static const TAG_IMG_SIZE = 28.0;
  static const TAG_IMG_SIZE_BIG = 32.0;
  static const DOT_RADIUS = 5.0;

  const FullWidthButton({
    @required this.iconPath,
    @required this.title,
    this.showDivider : false,
    this.showRightArrow : true,
    @required this.onPressed,
    this.des,
    this.customWidget
  }) : assert(iconPath != null),
       assert(title != null),
       assert(onPressed != null);

  final String iconPath;
  final String title;
  final bool showDivider;
  final bool showRightArrow;
  final VoidCallback onPressed;
  final String des;
  final Widget customWidget;

  @override
  Widget build(BuildContext context) {
    final pureButton = Row(
      // 交叉轴方向
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          iconPath,
          width: Constants.FullWidthIconButtonIconSize,
          height: Constants.FullWidthIconButtonIconSize,
        ),
        SizedBox(width: HORIZONTAL_PADDING,),
        Text(title),
      ],
    );
    final borderedButton = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: const Color(AppColors.DividerColor), width: Constants.DividerWidth),
        ),
      ),
      padding: const EdgeInsets.only(bottom: VERTICAL_PADDING),
      child: pureButton,
    );
    return FlatButton(
      onPressed: onPressed,
      padding: const EdgeInsets.only(
        left: HORIZONTAL_PADDING, right: HORIZONTAL_PADDING,
        top: VERTICAL_PADDING, bottom: VERTICAL_PADDING,
      ),
      child: this.showDivider ? borderedButton : pureButton,
    );
  }
}