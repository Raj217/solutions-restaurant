import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:solutions/model/restaurant.dart';
import 'package:solutions/model/app_user.dart';
import 'package:solutions/api/firestore/firestore.dart';

class UserHandler extends ChangeNotifier {
  late AppUser _user;
  late Restaurant _restaurant;

  AppUser get user => _user;
  Restaurant get restaurant => _restaurant;

  set user(AppUser user) {
    _user = user;
    notifyListeners();
  }

  set restaurant(Restaurant restaurant) {
    _restaurant = restaurant;
    notifyListeners();
  }

  Future<String?> addUserToFirestore(AppUser user) async {
    if (await FirestoreHandler.doesUserExists()) {
      return 'User already exists!';
    } else {
      _user = user;
      try {
        await FirestoreHandler.createUpdateUser(user);
        notifyListeners();
      } catch (e) {
        return e.toString();
      }
    }
    return null;
  }

  Future<String?> addRestaurantToFirestore(Restaurant restaurant) async {
    try {
      _restaurant = restaurant;
      DocumentReference ref =
          await FirestoreHandler.createRestaurant(restaurant);
      _user.restaurantID = ref.id;
      await FirestoreHandler.createUpdateUser(_user);
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
