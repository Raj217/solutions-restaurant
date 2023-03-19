import 'package:geocoding/geocoding.dart';
import 'package:money_converter/Currency.dart';
import 'app_user.dart';
import 'award.dart';

class Event {
  String id;
  String name;
  int amount;
  String currency;
  DateTime startTime;
  DateTime endTime;
  int peopleServed;
  List<AppUser> employees;
  Location location;
  List<Award> awards;
  List<String> images;
  List<String> videos;
  String restaurantID;

  Event({
    required this.id,
    required this.name,
    this.amount = 0,
    this.currency = Currency.INR,
    required this.startTime,
    required this.endTime,
    this.peopleServed = 0,
    this.employees = const [],
    required this.location,
    this.awards = const [],
    this.images = const [],
    this.videos = const [],
    this.restaurantID = '',
  });
}
