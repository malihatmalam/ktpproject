import 'package:hive/hive.dart';

part 'penduduk.g.dart';

@HiveType(typeId: 0)
class Penduduk extends HiveObject{

  @HiveField(0)
  String nama;

  @HiveField(1)
  String birtInfo;

  @HiveField(2)
  String city;

  @HiveField(3)
  String province;

  @HiveField(4)
  String job;

  @HiveField(5)
  String education;

  Penduduk(
      this.nama,
      this.birtInfo,
      this.city,
      this.province,
      this.job,
      this.education
      );
}