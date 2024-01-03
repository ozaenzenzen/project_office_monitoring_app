import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_main_button_widget.dart';

class PopupPage extends Page {
  final String title;
  final String desc;
  final Function() buttonCallback;
  final String buttonTitle;

  const PopupPage({
    required this.title,
    required this.desc,
    required this.buttonCallback,
    required this.buttonTitle,
  }) : super(
          key: const ValueKey("PopupPage"),
        );

  @override
  Route createRoute(BuildContext context) {
    return DialogRoute(
      settings: this,
      barrierDismissible: false,
      // barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    desc,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25.h),
                  AppMainButtonWidget(
                    onPressed: buttonCallback,
                    text: buttonTitle,
                  ),
                ],
              ),
            ),
          ],
        );
      },
      context: context,
    );
  }
}
