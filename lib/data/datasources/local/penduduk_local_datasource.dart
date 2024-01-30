
import 'package:hive/hive.dart';
import 'package:ktpproject/data/models/penduduk/penduduk.dart';

class PendudukLocalDatasource{
  PendudukLocalDatasource();

  Box<Penduduk> getPendudukSource(){
    final box = Hive.box<Penduduk>('pendudukBox');
    return box;
  }
}