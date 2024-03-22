import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cam_1/reminder/medicine.dart';

Future<List<Medicine>> getMedicinesFromPreferences() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  List<String>? medicineJsonList = sharedPrefs.getStringList('medicines');

  List<Medicine> medicines = [];

  if (medicineJsonList != null) {
    for (String jsonMedicine in medicineJsonList) {
      dynamic userMap = jsonDecode(jsonMedicine);
      Medicine tempMedicine = Medicine.fromJson(userMap);
      medicines.add(tempMedicine);
    }
  }

  return medicines;
}
