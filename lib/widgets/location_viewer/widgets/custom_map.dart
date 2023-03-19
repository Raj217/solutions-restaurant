import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:solutions/utils/location_helper.dart';
import 'package:geocoding/geocoding.dart';

class CustomMap extends StatefulWidget {
  final MapController mapController;
  final TapCallback onTap;
  final VoidCallback onMapReady;
  final ValueNotifier<latLng.LatLng?> location;
  const CustomMap(
      {Key? key,
      required this.mapController,
      required this.onTap,
      required this.onMapReady,
      required this.location})
      : super(key: key);

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  bool isMapInitialised = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.location,
      builder: (BuildContext context, latLng.LatLng? location, _) {
        return location == null
            ? const SizedBox()
            : FlutterMap(
                mapController: widget.mapController,
                options: MapOptions(
                  keepAlive: true,
                  onTap: widget.onTap,
                  onMapReady: () {
                    setState(() {
                      isMapInitialised = true;
                    });
                  },
                  enableMultiFingerGestureRace: true,
                  center: location,
                  zoom: 17,
                ),
                children: [
                  TileLayer(
                    maxZoom: 19,
                    urlTemplate: LocationHelper.defaultTileSet,
                    userAgentPackageName: "com.google_solutions.solutions",
                  ),
                  MarkerLayer(
                    rotate: true,
                    markers: [
                      Marker(
                          point: location,
                          height:
                              !isMapInitialised ? 0 : widget.mapController.zoom,
                          width:
                              !isMapInitialised ? 0 : widget.mapController.zoom,
                          builder: (context) => const Icon(Icons.location_on)),
                    ],
                  ),
                ],
              );
      },
    );
  }
}
