import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/bookmarks.svg"),
          label: 'Bookmarks',
        ),
        BottomNavigationBarItem( // New "Articles" item
          icon: Icon(Icons.article_outlined), // Choose a suitable icon
          label: 'Articles',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/profile.svg"),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Color(0xff1C170D),
      unselectedItemColor: Color(0xffA1824A),
    );
  }
}
