import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/data/model/remote/account/signin_request_model.dart';
import 'package:project_office_monitoring_app/presentation/page/main_page.dart';
import 'package:project_office_monitoring_app/presentation/page/signin_page/bloc/sign_in_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/signup_page/signup_page.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_loading_indicator.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_main_button_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/custom_dialog.dart';
import 'package:project_office_monitoring_app/support/app_dialog_action.dart';
import 'package:project_office_monitoring_app/support/app_info.dart';
import 'package:project_office_monitoring_app/support/app_theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailTextFieldController = TextEditingController(text: "");
  TextEditingController passwordTextFieldController = TextEditingController(text: "");

  bool keepLogin = false;

  bool isHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16.h),
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FutureBuilder(
                      future: AppInfo.showAppVersion(),
                      builder: (context, snapshot) {
                        return Text(
                          // "Vehicle Log Apps Version 1.0.0+1",
                          // "Vehicle Log Apps Version ${AppInfo.appVersion}",
                          "Office Monitor App Version ${snapshot.data}",
                          style: AppTheme.theme.textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "Office Monitor App",
                    style: AppTheme.theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  // SizedBox(height: 100.h),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     "Masuk",
                  //     style: AppTheme.theme.textTheme.displayMedium?.copyWith(
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 100.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Masuk",
                      style: AppTheme.theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AppTextFieldWidget(
                    textFieldTitle: "Email",
                    textFieldHintText: "journalist@email.com",
                    controller: emailTextFieldController,
                  ),
                  SizedBox(height: 10.h),
                  AppTextFieldWidget(
                    textFieldTitle: "Password",
                    textFieldHintText: "*****",
                    controller: passwordTextFieldController,
                    obscureText: isHidePassword,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isHidePassword = !isHidePassword;
                        });
                      },
                      child: Icon(
                        isHidePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.to(() => const ForgotPasswordScreen());
                          dialogActivation();
                        },
                        child: Text(
                          "Input Code Activation",
                          style: AppTheme.theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 14.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  BlocConsumer<SignInBloc, SignInState>(
                    listener: (context, state) {
                      if (state is SignInFailed) {
                        AppDialogAction.showFailedPopup(
                          title: 'Terjadi kesalahan',
                          description: state.errorMessage,
                          buttonTitle: 'Kembali',
                          context: context,
                        );
                      } else if (state is SignInSuccess) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        // Get.offAll(
                        //   () => const MainPage(),
                        // );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MainPage();
                            },
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is SignInLoading) {
                        return const AppLoadingIndicator();
                      } else {
                        return Column(
                          children: [
                            AppMainButtonWidget(
                              onPressed: () {
                                context.read<SignInBloc>().add(
                                      SignInAction(
                                        signInRequestModel: SignInRequestModel(
                                          email: emailTextFieldController.text,
                                          password: passwordTextFieldController.text,
                                        ),
                                        platformkey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MzA1MzE4NTUsInBsYXRmb3JtX25hbWUiOiJzbjBaNVRuMmNxc0NCWnVpbDlkWWZBQ1YiLCJ1c2VyX3N0YW1wIjoiUFQgQ29tcGFueSAxMjM1ZTBhYzNhYi0yMGFlLTRkZTgtOWJmNy0yZTRkODA0Y2MzNDMifQ.0pacSPG_Oll_vVOFxN3n65ogW8VyxwfXLJdD9viYQ48",
                                        // appVehicleReposistory: AppVehicleReposistory(),
                                        // vehicleLocalRepository: VehicleLocalRepository(),
                                      ),
                                    );
                                // Get.offAll(
                                //   () => const MainPage(),
                                // );
                              },
                              text: "Masuk",
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Belum Ada Akun?",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            AppMainButtonWidget(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const SignUpPage();
                                    },
                                  ),
                                );
                                // Get.to(
                                //   () => const SignUpPage(),
                                // );
                              },
                              text: "Daftar",
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      }
                    },
                  ),
                  // Column(
                  //   children: [
                  //     AppMainButtonWidget(
                  //       onPressed: () {
                  //         Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) {
                  //               return const MainPage();
                  //             },
                  //           ),
                  //         );
                  //         // context.read<SigninBloc>().add(
                  //         //       SigninAction(
                  //         //         signInRequestModel: SignInRequestModel(
                  //         //           email: emailTextFieldController.text,
                  //         //           password: passwordTextFieldController.text,
                  //         //         ),
                  //         //         appVehicleReposistory: AppVehicleReposistory(),
                  //         //         vehicleLocalRepository: VehicleLocalRepository(),
                  //         //       ),
                  //         //     );
                  //       },
                  //       text: "Masuk",
                  //     ),
                  //     SizedBox(height: 20.h),
                  //     Text(
                  //       "Belum Ada Akun?",
                  //       style: GoogleFonts.inter(
                  //         color: Colors.black,
                  //         fontSize: 14.sp,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //     SizedBox(height: 20.h),
                  //     AppMainButtonWidget(
                  //       onPressed: () {
                  //         // Get.to(
                  //         //   () => const SignUpPage(),
                  //         // );
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) {
                  //               return const SignUpPage();
                  //             },
                  //           ),
                  //         );
                  //       },
                  //       text: "Daftar",
                  //     ),
                  //     SizedBox(height: 20.h),
                  //   ],
                  // ),
                  // BlocConsumer<SigninBloc, SigninState>(
                  //   listener: (context, state) {
                  //     if (state is SigninFailed) {
                  //       AppDialogAction.showFailedPopup(
                  //         title: 'Terjadi kesalahan',
                  //         description: state.errorMessage,
                  //         buttonTitle: 'Kembali',
                  //         context: context,
                  //       );
                  //     } else if (state is SigninSuccess) {
                  //       FocusManager.instance.primaryFocus?.unfocus();
                  //       Get.offAll(
                  //         () => const MainPage(),
                  //       );
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     if (state is SigninLoading) {
                  //       return const AppLoadingIndicator();
                  //     } else {
                  //       return Column(
                  //         children: [
                  //           AppMainButtonWidget(
                  //             onPressed: () {
                  //               // context.read<SigninBloc>().add(
                  //               //       SigninAction(
                  //               //         signInRequestModel: SignInRequestModel(
                  //               //           email: emailTextFieldController.text,
                  //               //           password: passwordTextFieldController.text,
                  //               //         ),
                  //               //         appVehicleReposistory: AppVehicleReposistory(),
                  //               //         vehicleLocalRepository: VehicleLocalRepository(),
                  //               //       ),
                  //               //     );
                  //             },
                  //             text: "Masuk",
                  //           ),
                  //           SizedBox(height: 20.h),
                  //           Text(
                  //             "Belum Ada Akun?",
                  //             style: GoogleFonts.inter(
                  //               color: Colors.black,
                  //               fontSize: 14.sp,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //           SizedBox(height: 20.h),
                  //           AppMainButtonWidget(
                  //             onPressed: () {
                  //               // Get.to(
                  //               //   () => const SignUpPage(),
                  //               // );
                  //             },
                  //             text: "Daftar",
                  //           ),
                  //           SizedBox(height: 20.h),
                  //         ],
                  //       );
                  //     }
                  //   },
                  // ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogActivation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, Function setState) {
            return CustomDialogV2(
              title: 'Syarat Ketentuan Pengiriman Barang',
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: Checkbox(
                      checkColor: const Color(0xff42526D),
                      activeColor: const Color(0xffFFFF00),
                      value: true,
                      onChanged: (bool? value) {
                        // if (syaratKetentuanCheckBox == false) {
                        //   setState(() {
                        //     syaratKetentuanCheckBox = true;
                        //   });
                        // } else {
                        //   setState(() {
                        //     syaratKetentuanCheckBox = false;
                        //   });
                        // }
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Jika berat atau dimensi berbeda dengan yang diinput maka akan ada penambahan biaya, dan jika tidak disetujui makan akan dikenakan biaya pemotongan antar jemput barang.',
                          style: GoogleFonts.mukta(
                            color: const Color(0xff121419),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        InkWell(
                          onTap: () async {
                            // 
                          },
                          child: Text(
                            'Baca Ketentuan Pengiriman',
                            style: GoogleFonts.mukta(
                              color: const Color(0xff1EA9F8),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              primaryButtonText: 'Tidak Setuju',
              onTapPrimary: () {
                // Get.back();
                Navigator.pop(context);
              },
              secondaryTextColor: const Color(0xff42526D),
              secondaryButtonText: 'Lanjut',
              onTapSecondary: (true)
                  ? () async {
                      // 
                    }
                  : null,
              buttonDirection: ButtonDirectionV2.HORIZONTAL,
            );
          },
        );
      },
    );
  }
}
