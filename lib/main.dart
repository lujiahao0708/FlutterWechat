import 'package:flutter/material.dart';
import 'package:flutter_wechat/home/home_screen.dart';
import 'package:flutter_wechat/constants.dart';

void main() => runApp(new MaterialApp(
  title: '微信',
  home: new HomeScreen(),
  theme: ThemeData.light().copyWith(
    primaryColor: Color(AppColors.AppBarColor),
    // 修改弹出菜单的背景颜色
    cardColor: Colors.white,
  ),
));
