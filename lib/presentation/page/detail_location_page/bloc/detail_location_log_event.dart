part of 'detail_location_log_bloc.dart';

@immutable
sealed class DetailLocationLogEvent {}

final class GetDetailLocationLogAction extends DetailLocationLogEvent {
  final GetListLogRequestModel req;
  GetDetailLocationLogAction({required this.req});
}
