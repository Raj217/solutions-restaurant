import 'package:flutter/material.dart';
import 'package:solutions/widgets/overlay/custom_loading_overlay.dart';

void showCustomDialog(
  BuildContext context, {
  ValueChanged? onValue,
  bool addLoaderOverlayParent = false,
  required Widget child,
  double? height,
  bool isBarrierDismissible = true,
}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: isBarrierDismissible,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      if (addLoaderOverlayParent == true) {
        return CustomLoadingOverlay(
            child: _Page(
                height: height,
                isBarrierDismissible: isBarrierDismissible,
                child: child));
      } else {
        return _Page(
            height: height,
            isBarrierDismissible: isBarrierDismissible,
            child: child);
      }
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;

      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
  ).then((res) {
    if (onValue != null) onValue(res);
  });
}

class _Page extends StatelessWidget {
  final double? height;
  final Widget child;
  final bool isBarrierDismissible;
  const _Page(
      {Key? key,
      required this.height,
      required this.child,
      required this.isBarrierDismissible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height ?? 550,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 30),
              blurRadius: 60,
            ),
            const BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 30),
              blurRadius: 60,
            ),
          ],
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              child,
              Positioned(
                left: 0,
                right: 0,
                bottom: -48,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    if (isBarrierDismissible == true) {
                      Navigator.pop(context);
                    }
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
