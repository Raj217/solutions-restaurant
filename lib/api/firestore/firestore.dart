import 'package:firebase_auth/firebase_auth.dart';
import 'package:solutions/configs/configurations/constants.dart';
import 'package:solutions/model/app_user.dart';
import 'package:solutions/model/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHandler {
  static Future<void> createUpdateUser(AppUser user) async {
    await FirebaseFirestore.instance
        .collection(collectionUsers)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toJson());
  }

  static Future<AppUser?> getUserData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection(collectionUsers)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return AppUser.read(doc.data());
  }

  static Future<bool> doesUserExists() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection(collectionUsers)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return doc.exists;
  }

  static Future<DocumentReference> createRestaurant(
      Restaurant restaurant) async {
    DocumentReference doc = await FirebaseFirestore.instance
        .collection(collectionRestaurants)
        .add(restaurant.toJson());
    return doc;
  }

  static Future updateRestaurantDetails(Restaurant restaurant) async {
    await FirebaseFirestore.instance
        .collection(collectionRestaurants)
        .doc(restaurant.id!)
        .set(restaurant.toJson());
  }
}
