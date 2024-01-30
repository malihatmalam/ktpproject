import '../datasources/local/provinces_local_datasource.dart';

class ProvinceRepoImpl{
  final ProvincesLocalDataSourceImpl provincesLocalDataSourceImpl =
  ProvincesLocalDataSourceImpl ();

  Future<String> getProvinceData() async {
    final dataLocal = await provincesLocalDataSourceImpl.getProvincesLocalData();
    return dataLocal;
  }
}