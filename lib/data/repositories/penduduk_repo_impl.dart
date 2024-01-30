

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:ktpproject/data/datasources/local/penduduk_local_datasource.dart';

import '../../domain/failures/failures.dart';
import '../exceptions/exceptions.dart';
import '../models/penduduk/penduduk.dart';

class PendudukRepoImpl {
  final PendudukLocalDatasource pendudukLocalDatasource =
  PendudukLocalDatasource();

  Box<Penduduk> getPendudukData(){
    return pendudukLocalDatasource.getPendudukSource();
  }

  List<Penduduk> getAllPenduduk(){
    List<Penduduk> listPenduduk = pendudukLocalDatasource.getPendudukSource().values.toList();
    return listPenduduk;
  }

  Future<Either<Failure, List<Penduduk>>> getPenduduk() async {
    try {
      final result = await getAllPenduduk();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }

}