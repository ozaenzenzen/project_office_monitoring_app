import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/presentation/page/home_page/bloc/home_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/home_page/get_list_log_local_bloc/get_list_log_local_bloc.dart';
import 'package:project_office_monitoring_app/support/app_assets.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';
import 'package:project_office_monitoring_app/support/app_date_time_helper.dart';
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
            height: 180.h,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppAssets.imgDefaultPicture,
                height: 180.h,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              );
            },
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
          BlocBuilder<GetListLogLocalBloc, GetListLogLocalState>(
            builder: (context, state) {
              // AppLogger.debugLog("state now: $state");
              if (state is GetListLogLocalLoading) {
                return bodySectionLoadingView();
              } else if (state is GetListLogLocalSuccess) {
                return bodySectionSuccessView(state);
              } else {
                return bodySectionFailedView();
              }
            },
          ),
        ],
      ),
    );
  }

  SizedBox bodySectionFailedView() {
    return SizedBox(
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
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppAssets.imgDefaultPicture,
                      height: 140.h,
                      width: 200.w,
                      fit: BoxFit.cover,
                    );
                  },
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
    );
  }

  SizedBox bodySectionSuccessView(GetListLogLocalSuccess state) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state.output != null ? state.output!.listData!.length : 0,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: (state.output != null)
                    ? (state.output!.listData![index].monitorData!.picture != null &&
                            state.output!.listData![index].monitorData!.picture != "" &&
                            state.output!.listData![index].monitorData!.picture!.length > 50)
                        ? Image(
                            image: MemoryImage(
                              base64Decode(state.output!.listData![index].monitorData!.picture!),
                            ),
                            fit: BoxFit.cover,
                            height: 200.h,
                            width: 140.w,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AppAssets.imgDefaultPicture,
                                height: 140.h,
                                width: 200.w,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.network(
                            "https://blog.logrocket.com/wp-content/uploads/2022/02/Best-IDEs-Flutter-2022.png",
                            fit: BoxFit.cover,
                            height: 200.h,
                            width: 140.w,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AppAssets.imgDefaultPicture,
                                height: 140.h,
                                width: 200.w,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                    : Image.network(
                        "https://blog.logrocket.com/wp-content/uploads/2022/02/Best-IDEs-Flutter-2022.png",
                        fit: BoxFit.cover,
                        height: 200.h,
                        width: 140.w,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppAssets.imgDefaultPicture,
                            height: 140.h,
                            width: 200.w,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.black38,
                    child: Text(
                      // "10 Jam yang lalu",
                      AppDateTimeHelper.formatTimeDifference(state.output!.listData![index].monitorData!.createdAt!.toIso8601String()),
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: AppColor.white,
                      ),
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
    );
  }

  SizedBox bodySectionLoadingView() {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) {
          return const SkeletonAvatar();
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 12.w);
        },
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
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppAssets.imgDefaultPicture,
                            height: 140.h,
                            width: 200.w,
                            fit: BoxFit.cover,
                          );
                        },
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
