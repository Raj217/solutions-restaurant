import 'package:flutter/material.dart';
import 'sections/section_child.dart';
import 'sections/sections_skeleton.dart';
import 'sections/user_info_section.dart';
import 'package:solutions/configs/configs.dart';

class SideMenu extends StatefulWidget {
  final double topSpace;
  final String currentSelectedModelTitle;
  final void Function(String title) onTap;
  const SideMenu(
      {Key? key,
      this.topSpace = 0,
      required this.currentSelectedModelTitle,
      required this.onTap})
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
  late String selectedModelTitle = widget.currentSelectedModelTitle;
  @override
  Widget build(BuildContext context) {
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
              SectionSkeleton(
                  sectionHeading: 'Browse'.toUpperCase(),
                  children: browseSectionModels
                      .map((RiveModel model) => SectionChild(
                          title: model.title,
                          riveModel: model,
                          onTap: () {
                            setState(() {
                              selectedModelTitle = model.title;
                            });
                            widget.onTap(selectedModelTitle);
                          },
                          isCurrentSelected: selectedModelTitle == model.title))
                      .toList()),
              const SizedBox(height: 20),
              SectionSkeleton(
                  sectionHeading: 'Developers'.toUpperCase(),
                  children: developersSectionModels
                      .map((RiveModel model) => SectionChild(
                          title: model.title,
                          riveModel: model,
                          onTap: () {
                            setState(() {
                              selectedModelTitle = model.title;
                            });
                            widget.onTap(selectedModelTitle);
                          },
                          isCurrentSelected: selectedModelTitle == model.title))
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }
}
