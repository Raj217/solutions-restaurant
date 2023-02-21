import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            child: 'Restaurant img url'.isNotEmpty
                ? const DefaultUserIcon()
                : Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL!,
                    loadingBuilder: (_, __, ___) {
                      return const DefaultUserIcon();
                    },
                  ),
          ),
        )
      ],
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
