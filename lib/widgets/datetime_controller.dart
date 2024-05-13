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
      firstDate: DateTime(1950),
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

  // Future<void> selectTime(TextEditingController timeController) async {
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     initialTime: TimeOfDay.now(),
  //     context: Get.context!,
  //   );
  //   if (pickedTime != null) {
  //     // Create a DateTime object with the selected time and today's date.
  //     DateTime selectedDateTime = DateTime.now().subtract(Duration(
  //         hours: DateTime.now().hour,
  //         minutes: DateTime.now().minute,
  //         seconds: DateTime.now().second,
  //         milliseconds: DateTime.now().millisecond,
  //         microseconds: DateTime.now().microsecond));
  //     selectedDateTime = selectedDateTime
  //         .add(Duration(hours: pickedTime.hour, minutes: pickedTime.minute));

  //     // Format the selected time as per the "hh:mm" format.
  //     String formattedTime = DateFormat('HH:mm').format(selectedDateTime);

  //     // Update the text in the TextEditingController.
  //     timeController.text = formattedTime;
  //   }
  // }

  Future<void> selectTime(TextEditingController timeController) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: Get.context!,
    );
    if (pickedTime != null) {
      // Create a DateTime object with today's date and the selected time.
      DateTime selectedDateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute);

      // Format the selected time as per the "HH:mm" format.
      String formattedTime = DateFormat('HH:mm').format(selectedDateTime);

      // Update the text in the TextEditingController.
      timeController.text = formattedTime;
    }
  }

  Future<void> selectTime00(TextEditingController timeController) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: Get.context!,
      builder: (context, child) {
        return calenderTheme(child, context);
      },
    );

    if (pickedTime != null) {
      DateTime parsedTime = DateTime(TimeOfDay.now() as int);
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
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
