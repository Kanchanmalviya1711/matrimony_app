import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CustomCalenderController extends GetxController{
  Rx<DateTime> selectedDate = DateTime(2019, 3).obs;
  void selectDay({int? year, int? month}) {
    if (year != null && month != null) {
      selectedDate.value = DateTime(year, month);
    }
  }
}