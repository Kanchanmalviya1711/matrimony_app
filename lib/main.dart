import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/firebaseApi.dart';
import 'package:matrimony_app/localization/app_localization.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/utils/initial_bindings.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    appId: "1:1019741035758:android:238cea16b600e3e7f367ff",
    messagingSenderId: "1019741035758	",
    projectId: "matrimonynotifications",
    apiKey: "AIzaSyB8IcTgDxSVHhcvcn2xlgYujiSxcEZ4130",
  ));
  await SessionManager.init();
  await FirebaseApi().initNotification();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      translations: AppLocalization(),
      locale: Get.deviceLocale, //for setting localization strings
      fallbackLocale: const Locale('en', 'US'),
      title: '',
      initialBinding: InitialBindings(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
      navigatorKey: navigatorKey,
    );
  }
}
// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (_, __) => Scaffold(
//         appBar: AppBar(title: const Text('Home Screen')),
//       ),
//       routes: [
//         GoRoute(
//           path: 'details',
//           builder: (_, __) => Scaffold(
//             appBar: AppBar(title: const Text('Details Screen')),
//           ),
//         ),
//       ],
//     ),
//   ],
// );





