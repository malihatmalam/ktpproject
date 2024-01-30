

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ktpproject/domain/usecases/province_usecases.dart';

import '../../data/repositories/city_repo_impl.dart';
import '../entities/city_entity.dart';

class CityUseCases{
  final cityLocalData = CityRepoImpl();

  Future<List<CityEntity>> loadAllCitiesData() async {
    // Get Data Source
    var jsonData = json.decode(await cityLocalData.getCitiesData()) as List;

    // Membuat list dari objek Option
    List<CityEntity> listCities = jsonData.map((jsonOption) {
      return CityEntity.fromJson(jsonOption);
    }).toList();

    return listCities;
  }

  Future<List<CityEntity>> loadCitiesData(String province_name) async {
    // Function
    Future<List<CityEntity>> getCitiesByProvince(String province_name, List<CityEntity> listCities) async {
      var listProvince = await ProvinceUseCases().loadProvincesData();
      var province = listProvince.where((province) => province.name == province_name).toList();
      var listCitiesFilter = listCities.where((city) => city.provinceId == province.first.id).toList();
      if(listCitiesFilter.length > 0){
        return listCitiesFilter;
      }else{
        return [ CityEntity(id: '', provinceId: '', name: '') ];
      }
    }

    // Get All Data
    Future<List<CityEntity>> listCities = loadAllCitiesData();

    // Filter Data
    var listCitiesFilter = getCitiesByProvince(province_name, await listCities );

    return listCitiesFilter;
  }

}