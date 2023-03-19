import 'package:geocoding/geocoding.dart';
import 'package:money_converter/Currency.dart';
import 'app_user.dart';
import 'award.dart';
import 'package:latlong2/latlong.dart';

class Restaurant {
  String? id;
  String name;
  int balance;
  String currency;
  LatLng location;
  List<String> images;
  List<AppUser> employees;
  List<Award> awards;
  String adminID;

  Restaurant(
      {this.id,
      required this.name,
      this.balance = 0,
      this.currency = Currency.INR,
      required this.location,
      this.images = const [],
      this.employees = const [],
      this.awards = const [],
      required this.adminID});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'balance': balance,
      'currency': currency,
      'location': location.toJson(),
      'images': images,
      'employees': employees,
      'awards': awards,
      'adminID': adminID
    };
  }
}
