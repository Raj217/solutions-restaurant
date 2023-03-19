import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:solutions/utils/parsers.dart';
import 'widgets/custom_map.dart';
import 'widgets/suggestions_text_field.dart';

class LocationViewer extends StatefulWidget {
  final ValueNotifier<latLng.LatLng?> location;
  final String? Function(String?)? validator;
  const LocationViewer({Key? key, required this.location, this.validator})
      : super(key: key);

  @override
  State<LocationViewer> createState() => _LocationViewerState();
}

class _LocationViewerState extends State<LocationViewer> {
  final MapController mapController = MapController();
  final TextEditingController searchTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isMapInitialised = false;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: ValueListenableBuilder(
        valueListenable: widget.location,
        builder: (BuildContext context, latLng.LatLng? location, _) {
          if (location != null && isMapInitialised) {
            mapController.move(
                latLng.LatLng(location.latitude, location.longitude), 16);
          }
          return Stack(
            children: [
              if (location != null)
                CustomMap(
                    mapController: mapController,
                    onTap: (pos, latLng.LatLng loc) async {
                      widget.location.value = loc;
                      searchTextController.text = Parsers.placeMarkToString(
                          (await placemarkFromCoordinates(
                                  loc.latitude, loc.longitude))
                              .first);
                    },
                    onMapReady: () {
                      setState(() {
                        isMapInitialised = true;
                      });
                    },
                    location: widget.location),
              SuggestionTextField(
                  focusNode: focusNode,
                  validator: widget.validator,
                  searchTextController: searchTextController,
                  location: widget.location),
            ],
          );
        },
      ),
    );
  }
}
