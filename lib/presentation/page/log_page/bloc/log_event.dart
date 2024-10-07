part of 'log_bloc.dart';

@immutable
sealed class LogEvent {}

final class GetListLogAction extends LogEvent {
  final GetListLogRequestModel req;
  
  GetListLogAction({
    required this.req,
  });
}
