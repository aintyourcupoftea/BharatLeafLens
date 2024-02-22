import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'bookmarks_page.dart';
import 'profile_page.dart';
import 'articles_page.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _widgetList = [
    const HomePage(),
    const BookmarksPage(),
    const ArticlesPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Bharat Leaf Lens';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        body: IndexedStack( // Use IndexedStack for smooth transitions
          index: _selectedIndex,
          children: _widgetList,
        ),
        backgroundColor: const Color(0xffF5F5DC),
        // appBar: AppBar(
        //   backgroundColor: Colors.amber,
        //   title: Center(
        //     child: Text(
        //       "Welcome to\n$appTitle",
        //       textAlign: TextAlign.center,
        //       style: GoogleFonts.playfairDisplay(
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),
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
      ),
    );
  }
}

