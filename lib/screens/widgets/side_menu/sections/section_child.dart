import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:solutions/utils/rive_utils.dart';
import 'package:solutions/configs/configs.dart';

class SectionChild extends StatelessWidget {
  final String title;
  final RiveModel riveModel;
  final bool isCurrentSelected;
  final int index;
  final void Function(int) onTap;
  const SectionChild(
      {Key? key,
      required this.title,
      required this.riveModel,
      required this.index,
      required this.isCurrentSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
        RiveUtils.changeSMIBoolState(riveModel.status, riveModel.duration);
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            color: Colors.transparent,
            height: 56,
            width: min(MediaQuery.of(context).size.width * 0.6, 200),
          ),
          AnimatedContainer(
            duration: kThemeAnimationDuration,
            curve: Curves.fastOutSlowIn,
            width: isCurrentSelected
                ? min(MediaQuery.of(context).size.width * 0.6, 200)
                : 0,
            height: 56,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [accentColorDark, accentColor]),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: rive.RiveAnimation.asset(
                    riveModel.src,
                    artboard: riveModel.artboard,
                    onInit: (rive.Artboard artboard) {
                      riveModel.status = RiveUtils.getRiveInputBool(artboard,
                          stateMachineName: riveModel.stateMachineName,
                          inputName: riveModel.inputName);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  riveModel.title,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
