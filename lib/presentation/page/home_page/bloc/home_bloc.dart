// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/domain/entities/company_data_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(AccountLocalRepository accountLocalRepository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      if (event is GetHomeData) {
        _getHomeData(event, accountLocalRepository);
      }
    });
  }

  Future<void> _getHomeData(
    GetHomeData event,
    AccountLocalRepository accountLocalRepository,
  ) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      CompanyDataEntity? result = await accountLocalRepository.getCompanyData();
      if (result != null) {
        emit(
          HomeSuccess(
            companyData: result,
          ),
        );
      } else {
        emit(
          HomeFailed(
            errorMessage: "Terjadi kesalahan Data Kosong",
          ),
        );
      }
    } catch (e) {
      emit(
        HomeFailed(
          errorMessage: "$e",
        ),
      );
    }
  }
}
