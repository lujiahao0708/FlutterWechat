import 'package:flutter/material.dart';
import './full_width_button.dart';
import '../i18n/strings.dart' show Strings;

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  static const SEPARATE_SIZE = 10.0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
            FullWidthButton(
              iconPath: 'assets/images/ic_social_circle.png',
              title: Strings.FriendsCircle,
              
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_quick_scan.png',
              title: Strings.Scan,
              showDivider: true,
              onPressed: () {
                print('点击了扫一扫');
              },
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_shake_phone.png',
              title: Strings.Shake,
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_feeds.png',
              title: Strings.KnowMore,
              showDivider: true,
              
              onPressed: () {},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_quick_search.png',
              title: Strings.SearchMore,
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_people_nearby.png',
              title: Strings.FriendsNearby,
              showDivider: true,
              onPressed: () {},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_bottle_msg.png',
              title: Strings.FlowMessage,
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_shopping.png',
              title: Strings.Shopping,
              showDivider: true,
              onPressed: () {},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_game_entry.png',
              title: Strings.Games,
              
              onPressed: () {},
            ), 
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_mini_program.png',
              title: Strings.MiniPrograms,
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
          ],
      ),
    );
  }
}