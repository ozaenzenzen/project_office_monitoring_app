import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/domain/entities/get_list_log_data_entity.dart';
import 'package:project_office_monitoring_app/presentation/page/capture_page/capture_page.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';
import 'package:project_office_monitoring_app/support/app_date_time_helper.dart';

class LocationItemWidget extends StatelessWidget {
  final int index;
  final Function()? onTap;
  final String title;
  // final GetListLogDataEntity? data;
  final List<ListDatumEntity>? data;

  const LocationItemWidget({
    super.key,
    required this.index,
    required this.title,
    this.onTap,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CapturePage(
                    location: "Location $index",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.place,
                  size: 16.h,
                  color: AppColor.red,
                ),
                SizedBox(width: 10.h),
                Text(
                  // "Location $index",
                  "${data?[index].monitorData?.location}",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Image.network(
                  "https://cdn.mos.cms.futurecdn.net/SXtKY6DhYhKeSXL9BhX9s9.jpg",
                  height: 60.h,
                ),
                SizedBox(width: 10.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // "$title $index",
                        "${data?[index].userData?.firstName} ${data?[index].userData?.lastName}",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        // "$index Jam yang lalu",
                        AppDateTimeHelper.formatTimeDifference(
                          data?[index].monitorData?.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
                        ),
                        // "${data?.listData?[index].monitorData?.createdAt}",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20.h,
                ),
                SizedBox(width: 10.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
