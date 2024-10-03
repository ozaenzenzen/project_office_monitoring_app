import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/model/remote/account/signin_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/account/signin_response_model.dart';
import 'package:project_office_monitoring_app/env.dart';
import 'package:project_office_monitoring_app/support/app_api_path.dart';
import 'package:project_office_monitoring_app/support/app_api_service.dart';

class AppAccountRepository {
  Future<SignInResponseModel?> signIn(
    SignInRequestModel data,
    String platformKey,
  ) async {
    try {
      final response = await AppApiService(
        EnvironmentConfig.baseUrl(),
      ).call(
        AppApiPath.signin,
        request: data.toJson(),
        header: {
          "platformkey" : platformKey,
        }
      );
      return SignInResponseModel.fromJson(response.data);
    } catch (errorMessage) {
      debugPrint("[AppAccountReposistory][signin] errorMessage $errorMessage");
      rethrow;
      // return null;
    }
  }

  // Future<SignUpResponseModel?> signUp(SignUpRequestModel data) async {
  //   try {
  //     final response = await AppApiService(
  //       EnvironmentConfig.baseUrl(),
  //     ).call(
  //       AppApiPath.signUpAccount,
  //       request: data.toJson(),
  //     );
  //     return SignUpResponseModel.fromJson(response.data);
  //   } catch (errorMessage) {
  //     debugPrint("[AppAccountReposistory][signup] errorMessage $errorMessage");
  //     return null;
  //   }
  // }

  // Future<GetUserDataResponseModel?> getUserdata({required String token}) async {
  //   try {
  //     final response = await AppApiService(
  //       EnvironmentConfig.baseUrl(),
  //     ).call(
  //       AppApiPath.getUserData,
  //       method: MethodRequest.get,
  //       header: <String, String>{
  //         'token': token,
  //       },
  //     );
  //     return GetUserDataResponseModel.fromJson(response.data);
  //   } catch (errorMessage) {
  //     debugPrint("[AppAccountReposistory][getUserdata] errorMessage $errorMessage");
  //     return null;
  //   }
  // }

  // Future<EditProfileResponseModel?> editProfile({
  //   required EditProfileRequestModel data,
  //   required String token,
  // }) async {
  //   try {
  //     final response = await AppApiService(
  //       EnvironmentConfig.baseUrl(),
  //     ).call(
  //       AppApiPath.editProfile,
  //       method: MethodRequest.post,
  //       request: data.toJson(),
  //       header: <String, String>{
  //         'token': token,
  //       },
  //     );
  //     return EditProfileResponseModel.fromJson(response.data);
  //   } catch (errorMessage) {
  //     debugPrint("[AppAccountReposistory][editProfile] errorMessage $errorMessage");
  //     return null;
  //   }
  // }
}
