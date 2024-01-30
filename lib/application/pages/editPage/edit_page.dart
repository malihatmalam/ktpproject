import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ktpproject/domain/entities/city_entity.dart';
import 'package:ktpproject/domain/usecases/city_usecases.dart';
import 'package:ktpproject/domain/usecases/education_usecases.dart';
import 'package:ktpproject/domain/usecases/job_usecases.dart';
import 'package:ktpproject/domain/usecases/penduduk_usecases.dart';
import 'package:ktpproject/domain/usecases/province_usecases.dart';
import 'package:provider/provider.dart';

import '../../../data/models/penduduk/penduduk.dart';
import '../../../domain/entities/province_entity.dart';
import '../../core/services/dropdown_service.dart';


class EditKtpPage extends StatelessWidget {
  String? pendudukId;
  EditKtpPage(this.pendudukId);


  // Variable
  GlobalKey<FormState> _updatektpform = GlobalKey<FormState>();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _birthPlaceController = TextEditingController();

  List<String> _jobOption = JobUseCases().getJobList();

  List<String> _educationOption = EducationUseCases().getEducationList();

  // Check String bukan nomor
  bool isNumeric(String str) {
    // Gunakan ekspresi reguler untuk memeriksa apakah string hanya berisi angka
    RegExp regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    // final themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Data Penduduk',
            // style: themeData.textTheme.headline1,
          ),
          leading: Container(
            margin: EdgeInsets.all(4),
            child: IconButton(
                onPressed: () {
                  context.go('/');
                  Provider.of<DropdownService>(context, listen: false).changeProvince(null);
                  Provider.of<DropdownService>(context, listen: false).changeCity(null);
                  Provider.of<DropdownService>(context, listen: false).changeJob(null);
                  Provider.of<DropdownService>(context, listen: false).changeEducation(null);
                  Provider.of<DropdownService>(context, listen: false).setFullname(null);
                  Provider.of<DropdownService>(context, listen: false).setBirtInfo(null);
                },
                icon: Icon(Icons.arrow_back)
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              FutureBuilder<Penduduk?>(
                  future: PendudukUseCases().getDetailPenduduk(pendudukId!),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var penduduk = snapshot.data;
                      Provider.of<DropdownService>(context, listen: false).changeProvince(penduduk?.province);
                      Provider.of<DropdownService>(context, listen: false).changeCity(penduduk?.city);
                      Provider.of<DropdownService>(context, listen: false).changeJob(penduduk?.job);
                      Provider.of<DropdownService>(context, listen: false).changeEducation(penduduk?.education);
                      Provider.of<DropdownService>(context, listen: false).setFullname(penduduk?.nama);
                      Provider.of<DropdownService>(context, listen: false).setBirtInfo(penduduk?.birtInfo);
                      _fullnameController.text = penduduk!.nama;
                      _birthPlaceController.text = penduduk!.birtInfo;
                      return  Form(
                          key: _updatektpform,
                          child: Column(
                            children: [
                              Consumer<DropdownService>(
                                  builder: (BuildContext context, dropdownService, Widget? child) {
                                    print('cek : ${dropdownService.getValueFullname()}');
                                    return TextFormField(
                                      controller: _fullnameController,
                                      decoration: InputDecoration(
                                        labelText: 'Nama anda',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator : (value) {
                                        if(value!.length == 0) {
                                          return 'Nama tidak boleh kosong!';
                                        }
                                        if(isNumeric(value!)) {
                                          return 'Nama tidak boleh angka!';
                                        }
                                        return null;
                                      },

                                    );
                                  }
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Consumer<DropdownService>(
                                  builder: (BuildContext context, dropdownService, Widget? child) {
                                    return TextFormField(
                                      controller: _birthPlaceController,
                                      decoration: InputDecoration(
                                        labelText: 'Tempat, Tanggal lahir',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator : (value) {
                                        if(value!.length == 0) {
                                          return 'Tempat lahir tidak boleh kosong!';
                                        }
                                        if(isNumeric(value!)) {
                                          return 'Tempat lahir tidak boleh angka!';
                                        }
                                        return null;
                                      },
                                    );
                                  }
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Consumer<DropdownService>(
                                  builder: (BuildContext context, dropdownService, Widget? child) {
                                    return FutureBuilder<List<ProvinceEntity>>(
                                      future: ProvinceUseCases().loadProvincesData(),
                                      builder:(context, snapshot) {
                                        if(snapshot.hasData){
                                          var _listProvinces = snapshot.data!;
                                          return DropdownButtonFormField(
                                            value: dropdownService.getSelectedProvince(),
                                            items: _listProvinces.map((option) {
                                              return DropdownMenuItem(
                                                value: option.name,
                                                child: Text(option.name),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              print(value);
                                              Provider.of<DropdownService>(context, listen: false).changeProvince(value!);
                                              Provider.of<DropdownService>(context, listen: false).changeCity(null);
                                            },
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Pilih opsi terlebih dahulu';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Pilih Provinsi'
                                            ) ,
                                          );
                                        }else if (snapshot.hasError){
                                          return Text('${snapshot.error}');
                                        }else{
                                          return Text('');
                                        }
                                      },
                                    );
                                  }
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Consumer<DropdownService>(
                                  builder: (BuildContext context, dropdownService, Widget? child) {
                                    if(dropdownService.getSelectedProvince() == null){
                                      return DropdownButtonFormField(
                                        value: null,
                                        items: [], // Empty list
                                        onChanged: null, // Set onChanged menjadi null untuk men-disable dropdown
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Pilih Kota / Kabupaten',
                                        ),
                                        // Membuat tampilan dropdown menjadi disable
                                        style: TextStyle(
                                          color: Colors.grey, // Atur warna teks menjadi abu-abu untuk menunjukkan status disable
                                        ),
                                      );
                                    }else {
                                      return FutureBuilder<List<CityEntity>>(
                                        future: CityUseCases().loadCitiesData('${dropdownService.getSelectedProvince()}'),
                                        builder:(context, snapshot) {
                                          if(snapshot.hasData){
                                            var _listCities = snapshot.data as List<CityEntity>?;
                                            print(_listCities);

                                            if (_listCities != null && _listCities.isNotEmpty) {
                                              return DropdownButtonFormField(
                                                value: dropdownService.getSelectedCity(),
                                                items: _listCities.map((option) {
                                                  return DropdownMenuItem(
                                                    value: option.name,
                                                    child: Text(option.name),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  Provider.of<DropdownService>(context, listen: false).changeCity(value!);
                                                },
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Pilih opsi terlebih dahulu';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Pilih Kota / Kabupaten',
                                                ),
                                              );
                                            }
                                            else {
                                              // Dropdown yang tidak dapat diubah (disabled) jika data kosong atau null
                                              return DropdownButtonFormField(
                                                value: null,
                                                items: [], // Empty list
                                                onChanged: null, // Set onChanged menjadi null untuk men-disable dropdown
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Pilih Kota / Kabupaten',
                                                ),
                                                // Membuat tampilan dropdown menjadi disable
                                                style: TextStyle(
                                                  color: Colors.grey, // Atur warna teks menjadi abu-abu untuk menunjukkan status disable
                                                ),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Pilih opsi terlebih dahulu';
                                                  }
                                                  return null;
                                                },
                                              );
                                            }
                                          }else if (snapshot.hasError){
                                            return Text('${snapshot.error}');
                                          }else{
                                            return Text('');
                                          }
                                        },
                                      );
                                    }
                                  }
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Consumer<DropdownService>(
                                builder: (BuildContext context, dropdownService, Widget? child) {
                                  return DropdownButtonFormField(
                                    value: dropdownService.getSelectedJob(),
                                    items: _jobOption.map<DropdownMenuItem<String>>(
                                            (String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        )
                                    ).toList() ,
                                    onChanged: (value) {
                                      Provider.of<DropdownService>(context, listen: false).changeJob(value);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Pilih opsi terlebih dahulu';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Pilih Pekerjaan'
                                    ) ,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Consumer<DropdownService>(
                                builder: (BuildContext context, dropdownService, Widget? child) {
                                  return DropdownButtonFormField(
                                    value: dropdownService.getSelectedEducation(),
                                    items: _educationOption.map<DropdownMenuItem<String>>(
                                            (String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        )
                                    ).toList() ,
                                    onChanged: (value) {
                                      Provider.of<DropdownService>(context, listen: false).changeEducation(value);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Pilih opsi terlebih dahulu';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Pendidikan Terakhir'
                                    ) ,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Consumer<DropdownService>(
                                  builder: (BuildContext context, dropdownService, Widget? child) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        if(_updatektpform.currentState!.validate()){
                                          print('nama: ${_fullnameController.text},');
                                          print('birtInfo: ${_birthPlaceController.text},');
                                          print('city: ${dropdownService.getSelectedCity()},');
                                          print('province: ${dropdownService.getSelectedProvince()},');
                                          print('job: ${dropdownService.getSelectedJob()},');
                                          print('education: ${dropdownService.getSelectedEducation()},');

                                          PendudukUseCases().updatePenduduk(
                                              key: pendudukId,
                                              nama: _fullnameController.text,
                                              birtInfo: _birthPlaceController.text,
                                              city: dropdownService.getSelectedCity(),
                                              province: dropdownService.getSelectedProvince(),
                                              job: dropdownService.getSelectedJob(),
                                              education: dropdownService.getSelectedEducation()
                                          );
                                          Provider.of<DropdownService>(context, listen: false).changeProvince(null);
                                          Provider.of<DropdownService>(context, listen: false).changeCity(null);
                                          Provider.of<DropdownService>(context, listen: false).changeJob(null);
                                          Provider.of<DropdownService>(context, listen: false).changeEducation(null);
                                          Provider.of<DropdownService>(context, listen: false).setFullname(null);
                                          Provider.of<DropdownService>(context, listen: false).setBirtInfo(null);

                                          print('city : ${dropdownService.getSelectedCity()}');
                                          print('provinsi : ${dropdownService.getSelectedProvince()}');
                                          context.go('/');

                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Berhasil memperbaharui penduduk')
                                              )
                                          );
                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Ada yang salah bro')
                                              )
                                          );
                                        }
                                      },
                                      child: Text('Edit Data'),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                                    );
                                  }
                              )
                            ],
                          )
                      );
                    }else if(snapshot.hasError){
                      return Text('${snapshot.error}');
                    }else{
                      return CircularProgressIndicator();
                    }
                  }
              ),
            ],
          ),
        ));
  }
}
