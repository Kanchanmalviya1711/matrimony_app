import 'dart:convert';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/ui/profileLists_screen.dart';
import 'package:matrimony_app/presentation/home/homepage/homepage.dart';
import 'package:matrimony_app/presentation/notifications/ui/notifications_screen.dart';
import 'package:matrimony_app/core/app_export.dart';

class HomeController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  final count = 0.obs;
  final pagesList = [
    const HomePage(),
    const ProfileListsScreen(),
    const Notifications(),
  ];
}
