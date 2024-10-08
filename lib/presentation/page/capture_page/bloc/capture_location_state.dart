part of 'capture_location_bloc.dart';

@immutable
sealed class CaptureLocationState {}

final class CaptureLocationInitial extends CaptureLocationState {}

final class CaptureLocationLoading extends CaptureLocationState {}

final class CaptureLocationSuccess extends CaptureLocationState {
  final CaptureLocationResponseModel? resp;
  CaptureLocationSuccess({this.resp});
}

final class CaptureLocationFailed extends CaptureLocationState {
  final String errorMessage;
  CaptureLocationFailed({required this.errorMessage});
}
