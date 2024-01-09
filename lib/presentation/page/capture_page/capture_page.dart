import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_main_button_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.border,
      appBar: const AppAppBarWidget(
        title: 'Capture Page',
        elevation: 0,
      ),
      body: Column(
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
            ),
          ),
          const Spacer(),
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
    );
  }
}