import 'dart:convert';

import 'package:cathartic_gofer/models/dateHistoryModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateHistoryService {
  static const String _keyPrefix = 'date_history';
  static const String _dateListKey = 'date_history_list';

  static Future<void> saveDateHistory(dateHistoryModel history) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix${history.id}';
    final jsonData = history.toJson();
    await prefs.setString(key, jsonEncode(jsonData));
  }

  static Future<dateHistoryModel?> getDateHistoryById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix$id';
    final jsonData = prefs.getString(key);
    if (jsonData != null) {
      final Map<String, dynamic> data = jsonDecode(jsonData);
      return dateHistoryModel.fromJson(data);
    }
    return null;
  }

  static Future<void> updateDateHistory(dateHistoryModel updatedHistory) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedHistoriesJson = prefs.getString(_dateListKey);
    if (encodedHistoriesJson != null) {
      final List<dynamic> encodedHistories = jsonDecode(encodedHistoriesJson);
      final updatedHistoryJson = updatedHistory.toJson();
      final index = encodedHistories.indexWhere(
          (historyData) => historyData['id'] == updatedHistoryJson['id']);
      if (index != -1) {
        encodedHistories[index] = updatedHistoryJson;
        await prefs.setString(_dateListKey, jsonEncode(encodedHistories));

        final key = '$_keyPrefix${updatedHistoryJson['id']}';
        await prefs.setString(key, jsonEncode(updatedHistoryJson));
        debugPrint("updated");
      }
    }
  }

  static Future<void> deleteDateHistoryById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix$id';
    await prefs.remove(key);
  }

  static Future<List<dateHistoryModel>> getAllDateHistories() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedHistoriesJson = prefs.getString(_dateListKey);
    if (encodedHistoriesJson != null) {
      final encodedHistories =
          jsonDecode(encodedHistoriesJson) as List<dynamic>;
      final histories = encodedHistories.map((historyData) {
        final date = DateTime.tryParse(historyData['date']);
        if (date != null) {
          historyData['date'] = date;
        }
        return dateHistoryModel.fromJson(historyData);
      }).toList();
      return histories;
    } else {
      return [];
    }
  }

  static Future<void> clearAllHistories() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_keyPrefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }

  static Future<List<DateTime?>> getAllDates() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedHistoriesJson = prefs.getString(_dateListKey);
    if (encodedHistoriesJson != null) {
      final encodedHistories =
          jsonDecode(encodedHistoriesJson) as List<dynamic>;
      final dates = encodedHistories.map((historyData) {
        final date = DateTime.tryParse(historyData['date']);
        return date;
      }).toList();
      return dates;
    } else {
      return [];
    }
  }

  static Future<void> saveDateHistories(
      List<dateHistoryModel> histories) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedHistories = histories.map((history) {
      final historyJson = history.toJson();
      historyJson['date'] = history.date!.toIso8601String();
      return historyJson;
    }).toList();
    final encodedHistoriesJson = jsonEncode(encodedHistories);
    await prefs.setString(_dateListKey, encodedHistoriesJson);
  }

  static Future<void> addDateHistory(dateHistoryModel newHistory) async {
    final prefs = await SharedPreferences.getInstance();

    final encodedHistoriesJson = prefs.getString(_dateListKey);
    final List<dynamic> encodedHistories =
        encodedHistoriesJson != null ? jsonDecode(encodedHistoriesJson) : [];

    final newHistoryJson = newHistory.toJson();
    encodedHistories.add(newHistoryJson);

    await prefs.setString(_dateListKey, jsonEncode(encodedHistories));

    final key = '$_keyPrefix${newHistoryJson['id']}';
    await prefs.setString(key, jsonEncode(newHistoryJson));
  }
}
