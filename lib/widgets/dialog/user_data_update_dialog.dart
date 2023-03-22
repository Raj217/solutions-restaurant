import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:solutions/configs/configs.dart';
import 'package:solutions/model/app_user.dart';
import 'package:solutions/state_handlers/user/user_handler.dart';
import 'package:solutions/widgets/buttons/custom_elevated_icon_button.dart';
import 'package:solutions/widgets/dialog/custom_dialog.dart';
import 'package:solutions/widgets/fields/custom_text_field.dart';
import 'package:solutions/utils/validators.dart';

showUserDataUpdateDialog(BuildContext context,
    {void Function(dynamic)? onValue}) async {
  showCustomDialog(
    context,
    addLoaderOverlayParent: true,
    onValue: onValue ?? (_) {},
    child: const _UserDataUpdateDialog(),
    isBarrierDismissible:
        Provider.of<UserHandler>(context, listen: false).user?.firstName !=
            null,
  );
}

class _UserDataUpdateDialog extends StatefulWidget {
  const _UserDataUpdateDialog({Key? key}) : super(key: key);

  @override
  State<_UserDataUpdateDialog> createState() => _UserDataUpdateDialogState();
}

class _UserDataUpdateDialogState extends State<_UserDataUpdateDialog> {
  final TextEditingController _firstNameController = TextEditingController(),
      _lastNameController = TextEditingController();
  PhoneNumber? phone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserHandler>(
      builder: (BuildContext context, UserHandler userHandler, _) {
        _firstNameController.text = userHandler.user?.firstName ?? '';
        _lastNameController.text = userHandler.user?.lastName ?? '';
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Details',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              if (userHandler.user?.firstName == null)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'May we know you?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              CustomTextField(
                label: 'First name',
                icon: Icons.person,
                validator: Validators.isEmpty,
                controller: _firstNameController,
              ),
              CustomTextField(
                label: 'Last name',
                icon: Icons.person,
                validator: Validators.isEmpty,
                controller: _lastNameController,
              ),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber value) {
                  phone = value;
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                initialValue: (userHandler.user?.phoneNumber == null ||
                        userHandler.user?.phoneNumber?.phoneNumber == null)
                    ? PhoneNumber(isoCode: 'IN')
                    : userHandler.user?.phoneNumber,
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
              ),
              CustomTextField(
                label: 'Email',
                initValue: userHandler.user?.emailID,
                icon: Icons.email,
                readOnlyMode: true,
              ),
              CustomElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      context.loaderOverlay.show();
                      await InternetAddress.lookup(firestoreUrlPath);
                      AppUser user = userHandler.user!;
                      user.firstName = _firstNameController.text;
                      user.lastName = _lastNameController.text;
                      user.phoneNumber = phone;
                      await FirebaseFirestore.instance
                          .collection(collectionUsers)
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(user.toJson());
                      userHandler.user = user;
                      if (mounted) context.loaderOverlay.hide();
                      if (mounted) Navigator.pop(context);
                    } on SocketException catch (e) {
                      Fluttertoast.showToast(
                          msg: "Couldn't connect to the internet");
                    }
                  }
                },
                label: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
