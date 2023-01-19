import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/register_form_provider.dart';
import 'package:tesis_karina/router/routes.dart';
import 'package:tesis_karina/services/local_storage.dart';
import 'package:tesis_karina/services/navigation_service.dart';
import 'package:tesis_karina/services/notifications_service.dart';

void main() async {
  await LocalStorage.configurePrefs();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterFormProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      initialRoute: "/",
      routes: routes,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0.5)))),
    );
  }
}
