part of 'get_log_location_bloc.dart';

@immutable
sealed class GetLogLocationState {}

final class GetLogLocationInitial extends GetLogLocationState {}

final class GetLogLocationLoading extends GetLogLocationState {}

final class GetLogLocationSuccess extends GetLogLocationState {
  final GetListLogDataEntity? data;
  final TypeAction? typeAction;
  GetLogLocationSuccess({
    this.data,
    this.typeAction,
  });
}

final class GetLogLocationFailed extends GetLogLocationState {
  final String errorMessage;
  GetLogLocationFailed({required this.errorMessage});
}
