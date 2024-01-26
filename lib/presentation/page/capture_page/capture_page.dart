import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_main_button_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class CapturePage extends StatefulWidget {
  final String? location;

  const CapturePage({
    super.key,
    this.location,
  });

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  TextEditingController cekpoinController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.location != null) {
      cekpoinController.text = widget.location!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                onTap: () {
                  //
                },
                child: Container(
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
                    Icon(
                      Icons.location_on,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "0,888, 0,999",
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                ),
                child: AppMainButtonWidget(
                  onPressed: () {
                    //
                  },
                  text: "Submit",
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
