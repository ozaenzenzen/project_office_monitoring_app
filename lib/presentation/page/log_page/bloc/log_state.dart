part of 'log_bloc.dart';

@immutable
sealed class LogState {}

final class LogInitial extends LogState {}

final class LogLoading extends LogState {}

final class LogSuccess extends LogState {
  final GetListLogDataEntity? result;

  LogSuccess({
    this.result,
  });
}

final class LogFailed extends LogState {
  final String errorMessage;
  LogFailed({
    required this.errorMessage,
  });
}
