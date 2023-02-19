import 'package:flutter/material.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/screens/home_screen/widgets/side_menu/side_menu.dart';
import 'package:solutions/utils/rive_utils.dart';
import 'widgets/bottom_navbar/bottom_navbar.dart';
import 'rive_constants.dart';
import 'pages/home_page.dart';
import 'pages/map_page.dart';
import 'pages/updates_page.dart';
import 'pages/favorites_page.dart';
import 'pages/user_page.dart';
import 'package:rive/rive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late final AnimationController _animController;
  late final Animation<double> _rotationAnimation, _scaleAnimation;
  bool isMenuOpen = false, isMenuAnimFinished = true;
  final double floatingButtonSize = 45;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: kThemeAnimationDuration)
          ..addListener(() => setState(() {}));
    _rotationAnimation = Tween<double>(begin: 0, end: 0.9).animate(
        CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
        CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SideMenu(topSpace: 100),
          Transform(
            alignment: Alignment.centerRight,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_rotationAnimation.value)
              ..scale(_scaleAnimation.value)
              ..translate(_rotationAnimation.value * 140),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Scaffold(
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
              ),
            ),
          ),
          AnimatedPositioned(
            top: MediaQuery.of(context).size.height * 0.06,
            left: isMenuOpen ? MediaQuery.of(context).size.width * 0.6 : 30,
            duration: kThemeAnimationDuration,
            curve: Curves.fastOutSlowIn,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                height: floatingButtonSize,
                width: floatingButtonSize,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(floatingButtonSize),
                  ),
                  onPressed: () {
                    menu.status.change(!menu.status.value);

                    if (_animController.value == 0) {
                      _animController.forward();
                    } else if (_animController.value == 1) {
                      _animController.reverse();
                    }

                    setState(() {
                      isMenuOpen = !isMenuOpen;
                    });
                  },
                  child: SizedBox(
                    height: floatingButtonSize * 0.8,
                    child: RiveAnimation.asset(
                      menu.src,
                      artboard: menu.artboard,
                      onInit: (artboard) {
                        menu.status = RiveUtils.getRiveInputBool(
                          artboard,
                          stateMachineName: menu.stateMachineName,
                          inputName: menu.inputName,
                        );
                        menu.status.value = false;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
