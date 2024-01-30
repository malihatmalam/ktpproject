
import 'package:flutter/widgets.dart';

class DropdownService extends ChangeNotifier {
  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedJob;
  String? _selectedEducation;
  String? _valueFullname;
  String? _valueBirtInfo;

  void changeProvince(province){
    _selectedProvince = province;
    notifyListeners();
  }

  void changeCity(city){
    _selectedCity = city;
    notifyListeners();
  }

  void changeJob(job){
    _selectedJob = job;
    notifyListeners();
  }

  void changeEducation(education){
    _selectedEducation = education;
    notifyListeners();
  }

  void setFullname(name){
    _valueFullname = name;
    notifyListeners();
  }

  void setBirtInfo(info){
    _valueBirtInfo = info;
    notifyListeners();
  }

  String? getSelectedProvince() => _selectedProvince;

  String? getSelectedCity() => _selectedCity;

  String? getSelectedJob() => _selectedJob;

  String? getSelectedEducation() => _selectedEducation;

  String? getValueFullname() => _valueFullname;

  String? getValueBirtInfo() => _valueBirtInfo;

}