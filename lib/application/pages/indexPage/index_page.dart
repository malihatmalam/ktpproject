import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ktpproject/application/pages/indexPage/cubit/index_cubit.dart';
import 'package:ktpproject/domain/usecases/penduduk_usecases.dart';

class IndexPageWrapperProvider extends StatelessWidget {
  const IndexPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IndexCubit(),
      child: const IndexPage(),
    );
  }
}

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var listPenduduk = PendudukUseCases().getAllPenduduk();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Data Penduduk'
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.all(4),
            child: IconButton(
                onPressed: () {
                  context.go('/create');
                },
                icon: Icon(Icons.add)
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(2),
                // height: 400,
                child: BlocBuilder<IndexCubit, IndexState>(
                  builder: (context, state) {
                    if(state is IndexInitial){
                      return Text('Sedang ambil data');
                    } else if (state is IndexStateLoading) {
                      return CircularProgressIndicator();
                    } else if (state is IndexStateLoaded) {
                      var listPenduduk = state.penduduk;
                      return ListView(
                        children: List.generate(listPenduduk.length, (index) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: ListTile(
                              onTap: () {
                                context.go('/detail/${index}');
                              },
                              title: Text('${listPenduduk[index].nama}'),
                              // title: Text('test'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(onPressed: () {
                                    PendudukUseCases().deletePenduduk(key: index);
                                    BlocProvider.of<IndexCubit>(context).pendudukGetData();
                                  }, icon: Icon(Icons.delete)),
                                  SizedBox(width: 4,),
                                  IconButton(onPressed: () {
                                    context.go('/detail/${index}');
                                  }, icon: Icon(Icons.arrow_forward)),
                                ],
                              ),
                              style: ListTileStyle.list,
                            ),
                          );
                        }),
                      );
                    } else if (state is IndexStateError) {
                      return Center(
                        child: Text('Error = ${state.message}'),
                      );
                    } return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
