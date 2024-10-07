part of 'get_log_staff_bloc.dart';

@immutable
sealed class GetLogStaffState {}

final class GetLogStaffInitial extends GetLogStaffState {}

final class GetLogStaffLoading extends GetLogStaffState {}

final class GetLogStaffSuccess extends GetLogStaffState {
  final GetListLogDataEntity? data;
  final TypeAction? typeAction;
  GetLogStaffSuccess({
    this.data,
    this.typeAction,
  });
}

final class GetLogStaffFailed extends GetLogStaffState {
  final String errorMessage;
  GetLogStaffFailed({required this.errorMessage});
}
