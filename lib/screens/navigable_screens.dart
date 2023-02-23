import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:solutions/configs/configurations/rive_models.dart';
import 'package:solutions/state_handlers/pages/page_handler.dart';
import 'package:solutions/utils/rive_utils.dart';
import 'widgets/side_menu/side_menu.dart';
import 'screens.dart';
import 'widgets/bottom_nav_bar/bottom_navbar.dart';
import 'package:solutions/utils/helper_structures.dart';

class NavigableScreens extends StatefulWidget {
  const NavigableScreens({Key? key}) : super(key: key);
  static const String routeName = '/navigableScreens';

  @override
  State<NavigableScreens> createState() => _NavigableScreensState();
}

class _NavigableScreensState extends State<NavigableScreens>
    with TickerProviderStateMixin {
  bool isMenuOpen = false, isMenuAnimFinished = true;
  final double floatingButtonSize = 45;
  final RiveModel riveMenu = getRiveMenu();

  final PageController _pageController = PageController();

  late final AnimationController _animController;
  late final Animation<double> _rotationAnimation, _scaleAnimation;

  final ValueNotifier<int> currentlySelectedScreen = ValueNotifier<int>(0);

  final List<BreakPoint> breakpoints = [
    BreakPoint(title: 'BROWSE', endIndex: 4),
    BreakPoint(title: 'USER', endIndex: 6),
    BreakPoint(title: 'DEVELOPERS', endIndex: 7)
  ];

  final List<RiveModel> navigableScreenAnimModels = [
    getRiveHome(),
    getRiveMap(),
    getRiveRefresh(),
    getRiveLike(),
    getRiveUser(),
    getRiveSettings(),
    getRiveNotifications(),
    getRiveContactUs(),
  ];

  final List<Widget> pages = const [
    HomePage(),
    MapPage(),
    UpdatesPage(),
    FavoritePage(),
    UserPage(),
    SettingsScreen(),
    NotificationScreen(),
    ContactUsScreen()
  ];

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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SideMenu(
            topSpace: 70,
            navigableScreenAnimModels: navigableScreenAnimModels,
            breakPoints: breakpoints,
          ),
          Transform(
            alignment: Alignment.centerRight,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_rotationAnimation.value)
              ..scale(_scaleAnimation.value)
              ..translate(_rotationAnimation.value * 140),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Consumer<PageHandler>(
                builder: (BuildContext context, PageHandler pageHandler, _) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _pageController.jumpToPage(pageHandler.currentIndex);
                  });
                  return Scaffold(
                    body: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: pages,
                    ),
                    bottomNavigationBar:
                        pageHandler.currentIndex <= breakpoints.first.endIndex
                            ? BottomNavbar(
                                bottomNavbarMenuItems: navigableScreenAnimModels
                                    .sublist(0, breakpoints[0].endIndex + 1),
                              )
                            : null,
                  );
                },
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
                    riveMenu.status.change(!riveMenu.status.value);
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
                      riveMenu.src,
                      artboard: riveMenu.artboard,
                      onInit: (artboard) {
                        riveMenu.status = RiveUtils.getRiveInputBool(
                          artboard,
                          stateMachineName: riveMenu.stateMachineName,
                          inputName: riveMenu.inputName,
                        );
                        riveMenu.status.value = false;
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
