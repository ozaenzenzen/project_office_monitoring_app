import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/presentation/page/capture_page/capture_page.dart';
import 'package:project_office_monitoring_app/presentation/page/detail_location_page/detail_location_page.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class MonitorPage extends StatefulWidget {
  final PageController pageController;
  final Function(int indexClicked)? callbackController;

  const MonitorPage({
    super.key,
    required this.pageController,
    this.callbackController,
  });

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            SizedBox(height: 12.h),
            Text(
              "Monitor Location",
              style: GoogleFonts.inter(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 18,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // return const DetailLocationPage();
                          return CapturePage(
                            location: "List Location $index",
                            capturePageActionEnum: CapturePageActionEnum.details,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 12.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.h,
                          color: AppColor.disabled,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "List Location $index",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.h,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.h,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
