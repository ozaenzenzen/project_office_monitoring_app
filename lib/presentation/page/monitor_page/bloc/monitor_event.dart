part of 'monitor_bloc.dart';

@immutable
sealed class MonitorEvent {}

final class GetListLocationAction extends MonitorEvent {}
