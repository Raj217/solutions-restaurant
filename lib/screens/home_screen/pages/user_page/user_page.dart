import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solutions/state_handlers/user/user_handler.dart';
import 'package:solutions/widgets/user_profile_img.dart';
import 'widgets/user_details.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);
  static const String routeName = '/homeScreen/userPage';

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserHandler>(
        builder: (BuildContext context, UserHandler userHandler, _) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 100),
                Row(
                  children: [
                    const UserProfileImg(),
                    const SizedBox(width: 20),
                    Expanded(child: UserDetails(user: userHandler.user)),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
