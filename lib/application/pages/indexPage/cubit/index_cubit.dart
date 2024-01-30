import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ktpproject/domain/usecases/penduduk_usecases.dart';

import '../../../../data/models/penduduk/penduduk.dart';
import '../../../../domain/failures/failures.dart';

part 'index_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, chache failed. Please try again!';

class IndexCubit extends Cubit<IndexState> {

  final PendudukUseCases _pendudukUseCases = PendudukUseCases();
  IndexCubit() : super(IndexInitial()) {
    pendudukGetData();
  }

  void pendudukGetData() async {
    emit(IndexStateLoading());
    final failureOrPenduduk = await _pendudukUseCases.getListPenduduk();
    failureOrPenduduk.fold(
            (failure) => emit(IndexStateError(message: _mapFailureToMessage(failure))),
            (penduduk) => emit(IndexStateLoaded(penduduk: penduduk))
    );
  }

  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
