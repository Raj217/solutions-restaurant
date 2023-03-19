import 'package:flutter/material.dart';
import 'sections/planned_events/planned_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homeScreen/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 90),
              Text('Planned Events',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              PlannedEvents()
            ],
          ),
        ),
      ),
    );
  }
}
