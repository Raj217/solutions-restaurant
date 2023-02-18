import 'package:flutter/material.dart';
import 'widgets/bottom_navbar/bottom_navbar.dart';
import 'rive_constants.dart';
import 'pages/home_page.dart';
import 'pages/map_page.dart';
import 'pages/updates_page.dart';
import 'pages/favorites_page.dart';
import 'pages/user_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          HomePage(),
          MapPage(),
          UpdatesPage(),
          FavoritePage(),
          UserPage()
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
