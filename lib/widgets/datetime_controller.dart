import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_app/utils/calender_theme.dart';
import 'package:intl/intl.dart';

class DateTimePickerController extends GetxController {
  DateTimePickerController();

  // Date Of Birth
  void selectDob(TextEditingController dataTimeController) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return calenderTheme(child, context);
      },
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dataTimeController.text = formattedDate;
    }
  }

  // date Of Marriage

  void selectDob1(TextEditingController dataTimeController) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return calenderTheme(child, context);
      },
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat("yyyy-MM-dd").format(pickedDate);
      dataTimeController.text = formattedDate;
    }
  }

  Future<void> selectTime(TextEditingController timeController) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: Get.context!,
      builder: (context, child) {
        return calenderTheme(child, context);
      },
    );

    if (pickedTime != null) {
      DateTime parsedTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, pickedTime.hour, pickedTime.minute);
      String formattedTime =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedTime);
      timeController.text = formattedTime.toString();
    }

    //    if (pickedTime != null) {
    //   DateTime parsedTime = DateTime(DateTime.now().year, DateTime.now().month,
    //       DateTime.now().day, pickedTime.hour, pickedTime.minute);
    //   String formattedTime =
    //       DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedTime);
    //   timeController.text = formattedTime.toString();
    // }
  }
}
