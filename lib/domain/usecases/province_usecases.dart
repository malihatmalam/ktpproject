


import 'dart:convert';

import '../../data/repositories/province_repo_impl.dart';
import '../entities/province_entity.dart';

class ProvinceUseCases{
  final provinceLocalData = ProvinceRepoImpl();

  Future<List<ProvinceEntity>> loadProvincesData() async {
    // Get Data Source
    var jsonData = json.decode(await provinceLocalData.getProvinceData()) as List;

    // Membuat list dari objek Option
    List<ProvinceEntity> listProvince = jsonData.map((jsonOption) {
      return ProvinceEntity.fromJson(jsonOption);
    }).toList();

    return listProvince;
  }
}