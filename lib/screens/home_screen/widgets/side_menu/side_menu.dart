import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final double topSpace;
  const SideMenu({Key? key, this.topSpace = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: topSpace),
            Text(
              'UserName',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
            )
          ],
        ),
      ),
    );
  }
}
