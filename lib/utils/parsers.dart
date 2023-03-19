import 'package:geocoding/geocoding.dart';

class Parsers {
  static placeMarkToString(Placemark placeMark) {
    String loc = '';
    if (placeMark.subLocality != null && placeMark.subLocality!.isNotEmpty) {
      loc = '$loc${placeMark.subLocality!},';
    }
    if (placeMark.locality != null && placeMark.locality!.isNotEmpty) {
      loc = '$loc${placeMark.locality!},';
    }
    if (placeMark.administrativeArea != null &&
        placeMark.administrativeArea!.isNotEmpty) {
      loc = '$loc${placeMark.administrativeArea!},';
    }
    if (placeMark.country != null && placeMark.country!.isNotEmpty) {
      loc = '$loc${placeMark.country!},';
    }
    return loc.substring(0, loc.length - 1);
  }
}
