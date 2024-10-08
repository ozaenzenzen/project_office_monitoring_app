part of 'capture_location_bloc.dart';

@immutable
sealed class CaptureLocationEvent {}

final class CaptureAction extends CaptureLocationEvent {
  final CaptureLocationRequestModel req;
  CaptureAction({required this.req});
}
