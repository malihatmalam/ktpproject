part of 'index_cubit.dart';

abstract class IndexState extends Equatable {
  const IndexState();
  @override
  List<Object> get props => [];
}

class IndexInitial extends IndexState {}

class IndexStateLoading extends IndexState {}

class IndexStateLoaded extends IndexState {
  final List<Penduduk> penduduk;
  const IndexStateLoaded({required this.penduduk});

  @override
  List<Object> get props => [penduduk];
}

class IndexStateError extends IndexState {
  final String message;
  const IndexStateError({required this.message});
  @override
  List<Object> get props => [message];
}