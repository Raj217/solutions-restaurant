import 'package:flutter/material.dart';
import 'state_handlers/pages/page_handler.dart';
import 'state_handlers/theme/them_handler.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ThemeHandler()),
        ChangeNotifierProvider(create: (BuildContext context) => PageHandler()),
      ],
      child: Consumer<ThemeHandler>(
          builder: (BuildContext context, ThemeHandler themeHandler, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode:
              themeHandler.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (BuildContext context) =>
                const SplashScreen(),
            AuthScreen.routeName: (BuildContext context) => const AuthScreen(),
            NavigableScreens.routeName: (BuildContext context) =>
                const NavigableScreens(),
          },
        );
      }),
    );
  }
}
