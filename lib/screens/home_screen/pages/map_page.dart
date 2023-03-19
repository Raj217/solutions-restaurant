import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:geocoding/geocoding.dart';
import 'package:solutions/utils/location_helper.dart';
import 'package:solutions/widgets/location_viewer/location_viewer.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  static const String routeName = '/homeScreen/mapPage';

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = MapController();
  bool didCallForPos = false;
  bool isMapInitialised = false;
  late final ValueNotifier<latLng.LatLng> location;

  void test(double lat, double long) async {
    print('temple near [$lat, $long]');
    List<Location> locs =
        await GeocodingPlatform.instance.locationFromAddress('temples');
    print(locs);
    for (Location loc in locs) {
      print(loc);
      print(GeocodingPlatform.instance
          .placemarkFromCoordinates(loc.latitude, loc.longitude));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: !didCallForPos ? LocationHelper.determinePosition() : null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        didCallForPos = true;
        if (snapshot.hasData) {
          if (snapshot.data is String) {
            ScaffoldMessenger.of(context).showSnackBar(snapshot.data);
            return Container();
          } else {
            location = ValueNotifier(snapshot.data);
            return LocationViewer(location: location);
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
