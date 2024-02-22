import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'homepage.dart';
import 'bookmarks_page.dart';
import 'articles_page.dart';
import 'profile_page.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentPageIndex = 3;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.cyanAccent, //change when debugged
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
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          label: 'Articles',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset("assets/icons/profile.svg"),
          label: 'Profile',
        ),
      ],
      selectedItemColor: const Color(0xff1C170D),
      unselectedItemColor: const Color(0xffA1824A),
      currentIndex: _currentPageIndex,
      onTap: (newIndex) {
        setState(() {
          _currentPageIndex = newIndex;
        });
        _navigateToPage(newIndex);
      },
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarksPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticlesPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
    }
  }
}

