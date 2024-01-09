import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          topSection(),
          headerSection(),
          SizedBox(height: 12.h),
          bodySection(),
          SizedBox(height: 12.h),
          bottomSection(),
        ],
      ),
    );
  }

  Widget topSection() {
    return Container(
      color: AppColor.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          Text(
            "Home Page",
            style: GoogleFonts.inter(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              // fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget headerSection() {
    return Container(
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "https://yogabayuap.com/wp-content/uploads/2023/01/60bb4a2e143f632da3e56aea_Flutter-app-development-2.png",
            fit: BoxFit.cover,
            height: 180.h,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PT Testing",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Robert Robertson, 1234 NW Bobcat Lane, St. Robert, MO 65584-5678.",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bodySection() {
    return Container(
      color: AppColor.white,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 12.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monitoring History",
            style: GoogleFonts.inter(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 200.h,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "https://blog.logrocket.com/wp-content/uploads/2022/02/Best-IDEs-Flutter-2022.png",
                        fit: BoxFit.cover,
                        height: 200.h,
                        width: 140.w,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "10 Jam yang lalu",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 12.w);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSection() {
    return Container(
      color: AppColor.white,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 12.h,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kegiatan",
            style: GoogleFonts.inter(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 12,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "https://blog.logrocket.com/wp-content/uploads/2022/02/Best-IDEs-Flutter-2022.png",
                        fit: BoxFit.cover,
                        height: 140.h,
                        width: 200.w,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title",
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Description",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          "4 Jam Yang Lalu",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 12.h);
              },
            ),
          ),
        ],
      ),
    );
  }
}
