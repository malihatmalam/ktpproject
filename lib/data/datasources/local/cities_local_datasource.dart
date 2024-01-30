


import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../domain/entities/city_entity.dart';

class CitiesLocalDatasource{

  // Path
  final String path =  'assets/cities/cities.json';


  // Constructor
  CitiesLocalDatasource();

  // Get All City
  Future<String> getCitiesLocalData() async {

    // Baca data JSON dari file assets
    String jsonString = await rootBundle.loadString(path);
    return jsonString;
  }


}
