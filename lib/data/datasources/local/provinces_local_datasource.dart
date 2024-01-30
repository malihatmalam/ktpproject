
import 'package:flutter/services.dart';

class ProvincesLocalDataSourceImpl{

  // Path
  final String path =  'assets/province/provinces.json';

  // Constructor
  ProvincesLocalDataSourceImpl();

  // Get Data Province
  Future<String> getProvincesLocalData() async {
    // Baca data JSON dari file assets
    String jsonString = await rootBundle.loadString(path);
    return jsonString;
  }
}