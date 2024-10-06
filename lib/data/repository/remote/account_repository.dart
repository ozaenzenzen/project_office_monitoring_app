import 'package:project_office_monitoring_app/data/model/remote/account/signin_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/account/signin_response_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/profile/get_profile_response_model.dart';
import 'package:project_office_monitoring_app/env.dart';
import 'package:project_office_monitoring_app/support/app_api_path.dart';
import 'package:project_office_monitoring_app/support/app_api_service.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';

class AppAccountRepository {
  Future<SignInResponseModel?> signIn(
    SignInRequestModel data,
    String platformKey,
  ) async {
    try {
      final response = await AppApiService(
        EnvironmentConfig.baseUrl(),
      ).call(AppApiPath.signIn, request: data.toJson(), header: {
        "platformkey": platformKey,
      });
      SignInResponseModel output = SignInResponseModel.fromJson(response.data);
      output.userToken = response.headers.value("Token");

      return output;
    } catch (errorMessage) {
      AppLogger.debugLog("[AppAccountReposistory][signin] errorMessage $errorMessage");
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

  Future<GetProfileResponseModel?> getUserData({
    required String platformkey,
    required String token,
  }) async {
    try {
      final response = await AppApiService(
        EnvironmentConfig.baseUrl(),
      ).call(
        AppApiPath.getUserData,
        method: MethodRequest.get,
        header: <String, String>{
          'platformkey': platformkey,
          'token': token,
        },
      );
      return GetProfileResponseModel.fromJson(response.data);
    } catch (errorMessage) {
      AppLogger.debugLog("[AppAccountReposistory][getUserData] errorMessage $errorMessage");
      rethrow;
      // return null;
    }
  }

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
