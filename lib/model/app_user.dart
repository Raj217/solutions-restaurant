import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'event.dart';
import 'award.dart';

enum Role { employee, restaurantAdmin, admin, sponsor }

class AppUser {
  String? id;
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
    if (lastName != null) data["lastName"] = lastName;
    if (phoneNumber != null) data["phoneNumber"] = phoneNumber!.parseNumber();
    if (awards.isNotEmpty) data["awards"] = awards;
    if (emailID != null) data["emailID"] = emailID;
    if (eventsOrganised.isNotEmpty) data["eventsOrganised"] = eventsOrganised;
    if (images.isNotEmpty) data['images'] = images;
    if (restaurantID != null) data['restaurantID'] = restaurantID;
    return data;
  }
}
