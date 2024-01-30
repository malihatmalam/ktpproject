import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ktpproject/domain/usecases/penduduk_usecases.dart';

import '../../../data/models/penduduk/penduduk.dart';

class DetailKtpPage extends StatelessWidget {
  String? pendudukId;
  DetailKtpPage(this.pendudukId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Data Penduduk',
          // style: themeData.textTheme.headline1,
        ),
        leading: Container(
          margin: EdgeInsets.all(4),
          child: IconButton(
              onPressed: () {
                context.go('/');
              },
              icon: Icon(Icons.arrow_back)
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(4),
            child: IconButton(
                onPressed: () {
                  context.go('/edit/${pendudukId}');
                },
                icon: Icon(Icons.edit)
            ),
          )
        ],
        centerTitle: true,
      ),body: Padding(
      padding: EdgeInsets.all(15),
      child: FutureBuilder<Penduduk?>(
        future: PendudukUseCases().getDetailPenduduk(pendudukId!),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var penduduk = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text('Nama: ', style: TextStyle(
                          fontWeight: FontWeight.bold
                        )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 2.0
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('${penduduk?.nama}')
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Tempat, Tanggal lahir: ', style: TextStyle(
                          fontWeight: FontWeight.bold
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('${penduduk?.birtInfo}')
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Kota / kabupaten : ', style: TextStyle(
                          fontWeight: FontWeight.bold
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('${penduduk?.city}')
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Provinsi : ', style: TextStyle(
                          fontWeight: FontWeight.bold
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('${penduduk?.province}')
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Pekerjaan : ', style: TextStyle(
                          fontWeight: FontWeight.bold
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('${penduduk?.job}')
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text('Pendidikan : ', style: TextStyle(
                          fontWeight: FontWeight.bold
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('${penduduk?.education}')
                      ),
                    )
                  ],
                ),
              ],

            );
          }else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }else{
            return CircularProgressIndicator();
          }
        }
      ),
    ),
    );
  }
}