
import 'package:ktpproject/data/datasources/local/cities_local_datasource.dart';

class CityRepoImpl{
  final CitiesLocalDatasource citiesLocalDatasource =
  CitiesLocalDatasource();

  Future<String> getCitiesData() async {
    final dataLocal = await citiesLocalDatasource.getCitiesLocalData();
    return dataLocal;
  }
}