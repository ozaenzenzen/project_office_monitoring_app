part of 'get_log_location_bloc.dart';

@immutable
sealed class GetLogLocationEvent {}

final class GetLogLocationAction extends GetLogLocationEvent {
  final GetListLogRequestModel req;
  GetLogLocationAction({required this.req});
}
