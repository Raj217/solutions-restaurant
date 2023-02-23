import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solutions/state_handlers/pages/page_handler.dart';
import 'sections/section_child.dart';
import 'sections/sections_skeleton.dart';
import 'sections/user_info_section.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/utils/helper_structures.dart';

class SideMenu extends StatefulWidget {
  final double topSpace;
  final List<RiveModel> navigableScreenAnimModels;
  final List<BreakPoint> breakPoints;
  const SideMenu(
      {Key? key,
      this.topSpace = 0,
      required this.navigableScreenAnimModels,
      required this.breakPoints})
      : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final List<RiveModel> browseSectionModels = [
    getRiveHome(),
    getRiveMap(),
    getRiveRefresh(),
    getRiveLike(),
    getRiveUser(),
    getRiveSettings(), // TODO: Complete
    getRiveNotifications()
  ];
  final List<RiveModel> developersSectionModels = [
    getRiveContactUs(),
  ];
  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<PageHandler>(
        builder: (BuildContext context, PageHandler pageHandler, _) {
      children = [];
      int i = 0;
      List<SectionChild> tempChildren = [];
      RiveModel riveModel;
      for (BreakPoint breakPoint in widget.breakPoints) {
        tempChildren = [];
        for (; i <= breakPoint.endIndex; i++) {
          riveModel = widget.navigableScreenAnimModels[i];
          tempChildren.add(
            SectionChild(
                title: riveModel.title,
                onTap: (int index) {
                  pageHandler.currentIndex = index;
                },
                riveModel: riveModel,
                index: i,
                isCurrentSelected: pageHandler.currentIndex == i),
          );
        }
        children.add(const SizedBox(height: 10));
        children.add(
          SectionSkeleton(
              sectionHeading: breakPoint.title, children: tempChildren),
        );
      }
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListView(
              children: [
                SizedBox(height: widget.topSpace),
                const UserInfoSection(),
                const SizedBox(height: 20),
                ...children
              ],
            ),
          ),
        ),
      );
    });
  }
}
