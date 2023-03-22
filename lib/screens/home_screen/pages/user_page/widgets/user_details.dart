import 'package:flutter/material.dart';
import 'package:solutions/model/app_user.dart';
import 'package:solutions/widgets/dialog/user_data_update_dialog.dart';

class UserDetails extends StatefulWidget {
  final AppUser? user;
  const UserDetails({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    TextStyle? detailsTheme = Theme.of(context)
        .textTheme
        .labelMedium
        ?.copyWith(color: Colors.black54, fontSize: 11);
    String fullName = "";
    if (widget.user?.firstName == null && widget.user?.lastName == null) {
      fullName = "User name not found";
    } else {
      fullName += widget.user?.firstName ?? "";
      fullName += " ";
      fullName += widget.user?.lastName ?? "";
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            if (widget.user?.phoneNumber != null &&
                widget.user?.phoneNumber?.phoneNumber != null)
              Text(
                '${widget.user?.phoneNumber?.dialCode ?? ''} ${widget.user?.phoneNumber?.parseNumber() ?? ''}',
                style: detailsTheme,
              ),
            if (widget.user?.emailID != null)
              Text(
                widget.user?.emailID ?? '',
                style: detailsTheme,
              ),
          ],
        ),
        GestureDetector(
            onTap: () {
              showUserDataUpdateDialog(context);
            },
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                Icons.edit,
                size: 15,
                color: Theme.of(context).disabledColor,
              ),
            )),
      ],
    );
  }
}
