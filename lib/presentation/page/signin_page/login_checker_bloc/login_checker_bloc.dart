// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';

part 'login_checker_event.dart';
part 'login_checker_state.dart';

class LoginCheckerBloc extends Bloc<LoginCheckerEvent, LoginCheckerState> {
  LoginCheckerBloc(
    AccountLocalRepository accountLocalRepository,
  ) : super(LoginCheckerFalse()) {
    on<LoginCheckerEvent>((event, emit) {
      if (event is CheckIsLoginAction) {
        _checkIsLoginAction(accountLocalRepository);
      }
    });
  }

  Future<void> _checkIsLoginAction(
    AccountLocalRepository accountLocalRepository,
  ) async {
    try {
      bool result = await accountLocalRepository.getIsLogin();
      if (result) {
        emit(LoginCheckerTrue());
      } else {
        emit(LoginCheckerFalse());
      }
    } on Exception catch (e) {
      AppLogger.debugLog("[_checkIsLoginAction][error] $e");
      emit(LoginCheckerFalse());
    }
  }
}
