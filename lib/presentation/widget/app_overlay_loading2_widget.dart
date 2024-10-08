import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_loading_indicator.dart';

class AppOverlayLoading2Widget extends StatelessWidget {
  const AppOverlayLoading2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.black45,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLoadingIndicator(),
            SizedBox(height: 14.h),
            Text(
              "Loading...",
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
