part of 'detail_location_log_bloc.dart';

@immutable
sealed class DetailLocationLogState {}

final class DetailLocationLogInitial extends DetailLocationLogState {}

final class DetailLocationLogLoading extends DetailLocationLogState {}

final class DetailLocationLogSuccess extends DetailLocationLogState {
  final GetListLogDataEntity? data;
  final TypeAction? typeAction;
  DetailLocationLogSuccess({
    this.data,
    this.typeAction,
  });
}

final class DetailLocationLogFailed extends DetailLocationLogState {
  final String errorMessage;

  DetailLocationLogFailed({
    required this.errorMessage,
  });
}
