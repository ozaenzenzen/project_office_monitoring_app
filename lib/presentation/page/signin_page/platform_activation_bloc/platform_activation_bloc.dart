// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';

part 'platform_activation_event.dart';
part 'platform_activation_state.dart';

class PlatformActivationBloc extends Bloc<PlatformActivationEvent, PlatformActivationState> {
  PlatformActivationBloc(
    AccountLocalRepository accountLocalRepository,
  ) : super(PlatformActivationShow()) {
    on<PlatformActivationEvent>((event, emit) {
      if (event is CheckIsActivationCodeActiveAction) {
        _checkIsActivationCodeActiveAction(accountLocalRepository);
      }
    });
  }

  Future<void> _checkIsActivationCodeActiveAction(
    AccountLocalRepository accountLocalRepository,
  ) async {
    try {
      bool result = await accountLocalRepository.getIsActivationCodeActive();
      if (result) {
        emit(PlatformActivationHide());
      } else {
        emit(PlatformActivationShow());
      }
    } on Exception catch (e) {
      AppLogger.debugLog("[_checkIsActivationCodeActiveAction][error] $e");
      emit(PlatformActivationHide());
    }
  }
}
