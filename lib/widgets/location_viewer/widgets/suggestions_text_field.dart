import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:solutions/utils/parsers.dart';
import 'package:solutions/utils/location_helper.dart';
import 'package:latlong2/latlong.dart' as latLng;

class SuggestionTextField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController searchTextController;
  final ValueNotifier<latLng.LatLng?> location;
  final String? Function(String?)? validator;
  const SuggestionTextField(
      {Key? key,
      required this.focusNode,
      required this.searchTextController,
      required this.location,
      this.validator})
      : super(key: key);

  @override
  State<SuggestionTextField> createState() => _SuggestionTextFieldState();
}

class _SuggestionTextFieldState extends State<SuggestionTextField> {
  List<Location> locations = [];
  bool isQuerying = false;
  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<Place>(
      focusNode: widget.focusNode,
      textEditingController: widget.searchTextController,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text == '' || locations.isEmpty) {
          return const Iterable<Place>.empty();
        } else {
          List<Place> suggestions = [];
          for (int i = 0; i < locations.length; i++) {
            Location l = locations[i];
            List<Placemark> placeMarks =
                await placemarkFromCoordinates(l.latitude, l.longitude);
            for (Placemark placeMark in placeMarks) {
              if (placeMark.name != null && placeMark.name!.isNotEmpty) {
                suggestions.add(Place(
                    location: l,
                    address: Parsers.placeMarkToString(placeMark)));
              }
            }
          }
          setState(() {
            suggestions;
          });
          return suggestions;
        }
      },
      onSelected: (Place selection) async {
        Location loc = selection.location;
        widget.location.value = latLng.LatLng(loc.latitude, loc.longitude);
        FocusManager.instance.primaryFocus?.unfocus();
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return Container(
          height: 60,
          margin: const EdgeInsets.all(8),
          color: Theme.of(context).primaryColor,
          child: TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              errorStyle: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.red),
              suffixIcon: isQuerying
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : null,
            ),
            controller: textEditingController,
            focusNode: focusNode,
            style: Theme.of(context).textTheme.labelMedium,
            onChanged: (String query) async {
              if (!isQuerying) {
                setState(() {
                  locations.clear();
                  isQuerying = true;
                });
                try {
                  locations = await LocationHelper.getLocFromQuery(query);
                } catch (e) {}
                setState(() {
                  locations;
                  isQuerying = false;
                });
              }
            },
            validator: widget.validator,
            onFieldSubmitted: (String query) async {
              context.loaderOverlay.show();
              try {
                locations = await LocationHelper.getLocFromQuery(query);
                widget.location.value = latLng.LatLng(
                    locations.first.latitude, locations.first.longitude);
              } catch (e) {}
              if (mounted) context.loaderOverlay.hide();
            },
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          void Function(Place) onSelected, Iterable<Place> options) {
        return Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: Container(
                height: 150,
                child: ListView.builder(
                  itemCount: options.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Place opt = options.toList()[index];
                    return InkWell(
                        onTap: () {
                          onSelected(opt);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 20, left: 10),
                          child: Text(
                            opt.address,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ));
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Place {
  Location location;
  String address;
  Place({required this.location, required this.address});
  @override
  String toString() {
    return address;
  }
}
