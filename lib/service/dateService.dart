import 'package:shared_preferences/shared_preferences.dart';

class DateStorage {
  static SharedPreferences? _prefs;
  static final String key = 'saved_dates'; // Declare the key as static final

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a list of dates to SharedPreferences
  static Future<void> saveDates(List<DateTime?> dates) async {
    final List<String> dateStrings =
        dates.map((date) => date!.toIso8601String()).toList();
    await _prefs!.setStringList(key, dateStrings);
  }

  // Get a list of dates from SharedPreferences
  static List<DateTime> getDates() {
    final List<String> dateStrings = _prefs!.getStringList(key) ?? [];
    final List<DateTime> dates =
        dateStrings.map((dateString) => DateTime.parse(dateString)).toList();
    return dates;
  }

  // Add a single date to the list and save it to SharedPreferences
  static Future<void> addDate(DateTime date) async {
    final List<DateTime> existingDates = getDates();
    existingDates.add(date);
    await saveDates(existingDates);
  }

  // Remove a single date from the list and save the updated list to SharedPreferences
  static Future<void> removeDate(DateTime date) async {
    final List<DateTime> existingDates = getDates();
    existingDates.remove(date);
    await saveDates(existingDates);
  }

  // Clear the list by removing all dates from SharedPreferences
  static Future<void> clearDates() async {
    await _prefs!.remove(key);
  }
}
