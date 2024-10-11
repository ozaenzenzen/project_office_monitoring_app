part of 'get_list_log_local_bloc.dart';

@immutable
sealed class GetListLogLocalState {}

final class GetListLogLocalInitial extends GetListLogLocalState {}

final class GetListLogLocalLoading extends GetListLogLocalState {}

final class GetListLogLocalSuccess extends GetListLogLocalState {
  final GetListLogDataEntity? output;
  GetListLogLocalSuccess({this.output});
}

final class GetListLogLocalFailed extends GetListLogLocalState {
  final String errorMessage;
  GetListLogLocalFailed({required this.errorMessage});
}