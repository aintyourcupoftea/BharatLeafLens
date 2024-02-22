import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AestheticNavBar extends StatefulWidget {
  const AestheticNavBar({super.key});

  @override
  State<AestheticNavBar> createState() => _AestheticNavBarState();
}

class _AestheticNavBarState extends State<AestheticNavBar> {
  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 5,
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
    );
  }
}
