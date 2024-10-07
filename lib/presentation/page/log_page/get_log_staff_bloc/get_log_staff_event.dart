part of 'get_log_staff_bloc.dart';

@immutable
sealed class GetLogStaffEvent {}

final class GetLogStaffAction extends GetLogStaffEvent {
  final GetListLogRequestModel req;
  GetLogStaffAction({required this.req});
}
