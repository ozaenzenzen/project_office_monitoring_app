part of 'monitor_bloc.dart';

@immutable
sealed class MonitorState {}

final class MonitorInitial extends MonitorState {}

final class MonitorLoading extends MonitorState {}

final class MonitorSuccess extends MonitorState {
  final List<GetListLocationDataEntity?>? result;

  MonitorSuccess({
    this.result,
  });
}

final class MonitorFailed extends MonitorState {
  final String errorMessage;
  MonitorFailed({
    required this.errorMessage,
  });
}
