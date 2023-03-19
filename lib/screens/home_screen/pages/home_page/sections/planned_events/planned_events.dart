import 'package:flutter/material.dart';
import 'widgets/categories.dart';

class PlannedEvents extends StatefulWidget {
  const PlannedEvents({Key? key}) : super(key: key);

  @override
  State<PlannedEvents> createState() => _PlannedEventsState();
}

class _PlannedEventsState extends State<PlannedEvents> {
  final ValueNotifier<int> categorySelected = ValueNotifier(0);
  List<String> categories = ['Past', 'Upcoming', 'Requested'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Categories(
          categories: categories,
          categorySelected: categorySelected,
        ),
        SizedBox(
          height: 100,
          child: PageView(
            children: [],
          ),
        ),
      ],
    );
  }
}
