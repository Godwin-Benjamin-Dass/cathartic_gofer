import 'package:cathartic_gofer/user/service/DateHistoryService.dart';
import 'package:cathartic_gofer/user/service/medicineSheduleService.dart';
import 'package:flutter/material.dart';

import '../models/medicineSheduleModel.dart';

class medicineSheduleProvider extends ChangeNotifier {
  List<medicineSheduleModel> _msl = [];
  List<medicineSheduleModel> get msl => _msl;
  final List<medicineSheduleModel> _mor = [];
  List<medicineSheduleModel> get mor => _mor;
  final List<medicineSheduleModel> _aft = [];
  List<medicineSheduleModel> get aft => _aft;
  final List<medicineSheduleModel> _nig = [];
  List<medicineSheduleModel> get nig => _nig;
  final List<medicineSheduleModel> _cus = [];
  List<medicineSheduleModel> get cus => _cus;

  void fetchList() {
    _msl.clear();
    _msl = LocalStorage.getMedicineSchedules();
    reLoadList();
  }

  void addMedicine(medicineSheduleModel msi) {
    _msl.add(msi);
    print(msi);
    LocalStorage.addSchedule(msi);
    reLoadList();
  }

  void reLoadList() {
    _mor.clear();
    _aft.clear();
    _nig.clear();
    _cus.clear();
    for (int i = 0; i < _msl.length; i++) {
      var data = _msl[i].time;
      if ((data == "Morning" || data == "All") && _msl[i].type == "normal") {
        _mor.add(_msl[i]);
      }
      if ((data == "Afternoon" || data == "All") && _msl[i].type == "normal") {
        _aft.add(_msl[i]);
      }
      if ((data == "Evening" || data == "All") && _msl[i].type == "normal") {
        _nig.add(_msl[i]);
      }
      if (_msl[i].type != "normal") {
        _cus.add(_msl[i]);
      }
    }
    notifyListeners();
  }

  void removeMedicine(int id, String time) {
    LocalStorage.removeSchedule(id);
    _msl.removeWhere((element) => element.id == id);
    reLoadList();
  }

  void editMedicine(int id, medicineSheduleModel msi) {
    int idx = _msl.indexWhere((ele) => ele.id == id);
    _msl[idx] = msi;
    LocalStorage.editSchedule(id, msi);
    reLoadList();
  }

  void clearShedule() {
    LocalStorage.removeSchedules();
    DateHistoryService.clearAllHistories();
    reLoadList();
  }
}
