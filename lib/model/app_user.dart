import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'event.dart';
import 'award.dart';
import 'package:solutions/configs/configs.dart';

class AppUser {
  String? id;
  String? userImg;
  String? firstName;
  String? lastName;
  PhoneNumber? phoneNumber;
  List<Award> awards;
  String? emailID;
  List<Event> eventsOrganised;
  List<String> images;
  // Currently working restaurantID
  String? restaurantID;
  Role role;

  AppUser(
      {this.id,
      this.userImg,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.awards = const [],
      this.emailID,
      this.eventsOrganised = const [],
      this.images = const [],
      this.restaurantID,
      required this.role})
      : assert(phoneNumber != null || emailID != null,
            'Either phone number or email ID must be provided');

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {"role": role.name};
    if (firstName != null) data["firstName"] = firstName;
    if (userImg != null) data["userImg"] = userImg;
    if (lastName != null) data["lastName"] = lastName;
    if (phoneNumber != null) data["phoneNumber"] = phoneNumber!.props;
    if (awards.isNotEmpty) data["awards"] = awards;
    if (emailID != null) data["emailID"] = emailID;
    if (eventsOrganised.isNotEmpty) data["eventsOrganised"] = eventsOrganised;
    if (images.isNotEmpty) data['images'] = images;
    if (restaurantID != null) data['restaurantID'] = restaurantID;
    return data;
  }

  static AppUser? read(dynamic data) {
    if (data == null) return null;
    return AppUser(
      id: FirebaseAuth.instance.currentUser!.uid,
      userImg: data['userImg'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phoneNumber: PhoneNumber(
        phoneNumber: (data['phoneNumber'] ?? {})[0],
        isoCode: (data['phoneNumber'] ?? {})[1],
        dialCode: (data['phoneNumber'] ?? {})[2],
      ),
      awards: data['awards'] ?? [],
      emailID: data['emailID'],
      eventsOrganised: data['eventsOrganised'] ?? [],
      images: data['images'] ?? [],
      restaurantID: data['restaurantID'],
      role: stringToRole[data['role']]!,
    );
  }
}
