import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/medicineSheduleModel.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String key = 'medicine_schedules';
  // Save a list of medicineSheduleModel objects as JSON in SharedPreferences
  static Future<bool> setMedicineSchedules(
      List<medicineSheduleModel> schedules) {
    final List<String> jsonList =
        schedules.map((schedule) => jsonEncode(schedule.toJson())).toList();
    return _prefs!.setStringList(key, jsonList);
  }

  // Get a list of medicineSheduleModel objects from SharedPreferences
  static List<medicineSheduleModel> getMedicineSchedules() {
    final List<String> jsonList = _prefs!.getStringList(key) ?? [];
    final List<medicineSheduleModel> schedules = jsonList.map((jsonString) {
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return medicineSheduleModel.fromJson(jsonData);
    }).toList();
    return schedules;
  }

  // Add a schedule to the list and save it to SharedPreferences
  static Future<void> addSchedule(medicineSheduleModel schedule) async {
    final List<medicineSheduleModel> existingSchedules = getMedicineSchedules();
    existingSchedules.add(schedule);
    await setMedicineSchedules(existingSchedules);
  }

  // Remove a schedule by ID and update IDs to be consecutive
  static Future<void> removeSchedule(int scheduleIdToRemove) async {
    List<medicineSheduleModel> schedules = getMedicineSchedules();
    schedules.removeWhere((schedule) => schedule.id == scheduleIdToRemove);

    // Reassign consecutive IDs to the remaining schedules
    for (int i = 0; i < schedules.length; i++) {
      schedules[i].id = i;
    }

    // Save the updated list of schedules back to SharedPreferences
    await setMedicineSchedules(schedules);
  }

  static Future<void> removeSchedules() async {
    await setMedicineSchedules([]);
  }

  // Edit a schedule by ID
  static Future<void> editSchedule(
      int scheduleId, medicineSheduleModel editedSchedule) async {
    final List<medicineSheduleModel> existingSchedules = getMedicineSchedules();
    final int index =
        existingSchedules.indexWhere((schedule) => schedule.id == scheduleId);

    if (index != -1) {
      // Replace the existing schedule with the edited one
      existingSchedules[index] = editedSchedule;
      await setMedicineSchedules(existingSchedules);
    }
  }
}
