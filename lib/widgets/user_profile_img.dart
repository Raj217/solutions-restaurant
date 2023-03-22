import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solutions/state_handlers/user/user_handler.dart';

class UserProfileImg extends StatelessWidget {
  const UserProfileImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserHandler>(
      builder: (context, UserHandler userHandler, _) {
        String? userImg = userHandler.user?.userImg ??
            FirebaseAuth.instance.currentUser?.photoURL;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                  foregroundImage: userImg != null
                      ? Image.network(
                          userImg,
                          fit: BoxFit.cover,
                          loadingBuilder: (_, child, chunk) {
                            if (chunk == null) return child;
                            return SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                                strokeWidth: 2,
                              ),
                            );
                          },
                        ).image
                      : null,
                  child: userImg == null
                      ? const DefaultUserIcon()
                      : const SizedBox()),
            )
          ],
        );
      },
    );
  }
}

class DefaultUserIcon extends StatelessWidget {
  const DefaultUserIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
