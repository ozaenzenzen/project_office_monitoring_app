import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/presentation/page/capture_page/capture_page.dart';
import 'package:project_office_monitoring_app/presentation/page/detail_location_page/detail_location_page.dart';
import 'package:project_office_monitoring_app/presentation/page/detail_log_page/detail_log_page.dart';
import 'package:project_office_monitoring_app/presentation/page/home_page/bloc/home_bloc.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_loading_indicator.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';
import 'package:skeletons/skeletons.dart';

class HomePage extends StatefulWidget {
  final PageController pageController;
  final Function(int indexClicked)? callbackController;

  const HomePage({
    super.key,
    required this.pageController,
    this.callbackController,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // context.read<HomeBloc>().add(GetHomeData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12.h),
          topSection(),
          headerSection(),
          Container(
            height: 12.h,
            color: AppColor.border,
          ),
          bodySection(),
          Container(
            height: 12.h,
            color: AppColor.border,
          ),
          bottomSection(),
        ],
      ),
    );
  }

  Widget topSection() {
    return Container(
      color: AppColor.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
      ),
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
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return SizedBox(
                        width: 200.w,
                        child: const SkeletonLine(),
                      );
                    } else if (state is HomeSuccess) {
                      return Text(
                        "${state.companyData?.companyName}",
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                        ),
                      );
                    } else {
                      return Text(
                        "",
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 8.h),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return SizedBox(
                        width: 200.w,
                        child: const SkeletonLine(),
                      );
                    } else if (state is HomeSuccess) {
                      return Text(
                        "${state.companyData?.address}",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                        ),
                      );
                    } else {
                      return Text(
                        "",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                        ),
                      );
                    }
                  },
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Monitoring History",
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                ),
              ),
              InkWell(
                onTap: () {
                  widget.pageController.jumpToPage(1);
                  // widget.callbackController?.call(1);
                },
                child: Text(
                  "See All",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: AppColor.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 200.h,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const DetailLogPage();
                        },
                      ),
                    );
                  },
                  child: Stack(
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
                  ),
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
              padding: EdgeInsets.zero,
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
