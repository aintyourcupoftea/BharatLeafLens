import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:bharat_leaf_lens/pages/homepage.dart';
import 'package:bharat_leaf_lens/pages/bookmarks_page.dart';
import 'package:bharat_leaf_lens/pages/articles_page.dart';
import 'package:bharat_leaf_lens/pages/profile_page.dart';

class HomeComponents extends StatefulWidget {
  const HomeComponents({super.key});

  @override
  State<HomeComponents> createState() => _HomeComponentsState();
}

class _HomeComponentsState extends State<HomeComponents> {
  int _selectedIndex = 0;
  final List<Widget> _widgetList = [
    const HomePage(),
    const BookmarksPage(),
    const ArticlesPage(),
    const SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack( // Use IndexedStack for smooth transitions
        index: _selectedIndex,
        children: _widgetList,
      ),
      backgroundColor: const Color(0xffF5F5DC),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(16),
            gap: 5,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIndex: _selectedIndex,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.bookmark,
                text: "Bookmarks",
              ),
              GButton(
                icon: Icons.article,
                text: "Articles",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              )
            ],
          ),
        ),
      ),
    );
  }
}
