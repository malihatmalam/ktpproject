

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:ktpproject/data/repositories/penduduk_repo_impl.dart';

import '../../data/models/penduduk/penduduk.dart';
import '../failures/failures.dart';

class PendudukUseCases{
  final pendudukLocalRepo = PendudukRepoImpl();

  Future<Either<Failure, List<Penduduk>>> getListPenduduk() async {
    return pendudukLocalRepo.getPenduduk();
    // space for business logic
  }

  List<Penduduk> getAllPenduduk(){
    List<Penduduk> listPenduduk = pendudukLocalRepo.getPendudukData().values.toList();
    return listPenduduk;
  }


  void storePenduduk({
    required nama,
    required birtInfo,
    required city,
    required province,
    required job,
    required education,
  }) {
    Box penduduk = pendudukLocalRepo.getPendudukData();
    penduduk.add(Penduduk(nama, birtInfo, city, province, job, education));
  }

  Future<Penduduk?> getDetailPenduduk(String index) async {
    int _index = int.parse(index);
    Penduduk? penduduk = await pendudukLocalRepo.getPendudukData().get(_index);
    return penduduk;
  }

  void updatePenduduk(
      {
        required nama,
        required birtInfo,
        required city,
        required province,
        required job,
        required education,
        required key,
      }
      ) async {
    Box box = pendudukLocalRepo.getPendudukData();
    Penduduk? penduduk = await getDetailPenduduk(key);
    penduduk?.nama = nama;
    penduduk?.birtInfo = birtInfo;
    penduduk?.city = city;
    penduduk?.province = province;
    penduduk?.job = job;
    penduduk?.education = education;

    await box.put(key, penduduk);
  }

  void deletePenduduk({required key,}) async {
    Box box = pendudukLocalRepo.getPendudukData();
    await box.delete(key);
  }
}