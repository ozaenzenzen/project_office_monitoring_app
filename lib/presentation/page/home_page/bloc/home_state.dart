part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final CompanyDataEntity? companyData;
  HomeSuccess({
    this.companyData,
  });
}

final class HomeFailed extends HomeState {
  final String errorMessage;
  HomeFailed({
    required this.errorMessage,
  });
}
