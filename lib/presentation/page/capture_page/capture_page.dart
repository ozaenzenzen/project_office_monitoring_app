import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_office_monitoring_app/data/model/remote/capture/capture_location_request_model.dart';
import 'package:project_office_monitoring_app/presentation/page/capture_page/bloc/capture_location_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/main_page.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_main_button_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_overlay_loading2_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';
import 'package:project_office_monitoring_app/support/app_dialog_action.dart';
import 'package:project_office_monitoring_app/support/app_image_picker.dart';
import 'package:project_office_monitoring_app/support/app_location_service.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';

enum CapturePageActionEnum { capture, details }

class CapturePage extends StatefulWidget {
  final String? location;
  final CapturePageActionEnum capturePageActionEnum;

  const CapturePage({
    super.key,
    this.location,
    required this.capturePageActionEnum,
  });

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  TextEditingController cekpoinController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    if (widget.location != null || widget.capturePageActionEnum == CapturePageActionEnum.details) {
      cekpoinController.text = widget.location!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      currentPosition = await AppLocationService.getCurrentPosition();
      AppLogger.debugLog("$currentPosition");
      setState(() {});
    });
  }

  String? base64Image = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: AppColor.white,
            appBar: const AppAppBarWidget(
              title: 'Capture Page',
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      base64Image = await AppImagePickerService.getImageAsBase64(
                        imageSource: ImageSource.camera,
                      );
                      setState(() {});
                    },
                    child: (base64Image != null && base64Image != "")
                        ? Image.memory(
                            // height: 240.h,
                            base64Decode(base64Image!),
                          )
                        : Container(
                            height: 240.h,
                            color: Colors.black26,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppColor.white,
                                    size: 36.h,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Tekan untuk mengambil gambar / foto",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    color: AppColor.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "${currentPosition?.latitude}, ${currentPosition?.longitude}",
                          // "0,888, 0,999",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.h,
                    ),
                    child: AppTextFieldWidget(
                      textFieldTitle: "Cekpoin / lokasi",
                      textFieldHintText: "Cekpoin / lokasi",
                      controller: cekpoinController,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.h,
                    ),
                    child: AppTextFieldWidget(
                      textFieldTitle: "Berita / Keterangan",
                      textFieldHintText: "Berita / Keterangan",
                      maxLines: 6,
                      controller: keteranganController,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // const Spacer(),
                  widget.capturePageActionEnum == CapturePageActionEnum.capture
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.h,
                          ),
                          child: AppMainButtonWidget(
                            onPressed: () {
                              if (base64Image == null || base64Image == "" || currentPosition == null || cekpoinController.text.isEmpty || keteranganController.text.isEmpty) {
                                AppDialogAction.showFailedPopup(
                                  context: context,
                                  title: "Terjadi kesalahan",
                                  description: "Data belum lengkap",
                                  buttonTitle: "Kembali",
                                );
                              } else {
                                context.read<CaptureLocationBloc>().add(
                                      CaptureAction(
                                        req: CaptureLocationRequestModel(
                                          picture: base64Image,
                                          location: cekpoinController.text,
                                          address: "ada",
                                          information: keteranganController.text,
                                          latitude: "${currentPosition?.latitude}",
                                          longitude: "${currentPosition?.longitude}",
                                        ),
                                      ),
                                    );
                              }
                            },
                            text: "Submit",
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
        BlocConsumer<CaptureLocationBloc, CaptureLocationState>(
          listener: (context, state) {
            if (state is CaptureLocationFailed) {
              AppDialogAction.showFailedPopup(
                context: context,
                title: "Terjadi kesalahan",
                description: state.errorMessage,
                buttonTitle: "Kembali",
              );
            }
            if (state is CaptureLocationSuccess) {
              AppDialogAction.showSuccessPopup(
                context: context,
                title: "Berhasil",
                description: "${state.resp?.message}",
                buttonTitle: "Kembali",
                mainButtonAction: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      return const MainPage();
                    }),
                    (Route<dynamic> route) => false,
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is CaptureLocationLoading) {
              return const AppOverlayLoading2Widget();
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
