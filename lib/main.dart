import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'state_handlers/theme/them_handler.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ThemeHandler())
      ],
      child: Consumer<ThemeHandler>(
          builder: (BuildContext context, ThemeHandler themeHandler, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode:
              themeHandler.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AuthScreen.routeName,
          routes: {
            AuthScreen.routeName: (BuildContext context) => const AuthScreen(),
          },
        );
      }),
    );
  }
}
