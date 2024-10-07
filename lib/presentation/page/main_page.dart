import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_request_model.dart';
import 'package:project_office_monitoring_app/presentation/page/capture_page/capture_page.dart';
import 'package:project_office_monitoring_app/presentation/page/home_page/bloc/home_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/home_page/home_page.dart';
import 'package:project_office_monitoring_app/presentation/page/log_page/get_log_location_bloc/get_log_location_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/log_page/get_log_staff_bloc/get_log_staff_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/log_page/log_page.dart';
import 'package:project_office_monitoring_app/presentation/page/monitor_page/bloc/monitor_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/monitor_page/monitor_page.dart';
import 'package:project_office_monitoring_app/presentation/page/profile_page/profile_page.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_custom_appbar.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
// class _MainPageState extends State<MainPage> {
  int indexClicked = 0;

  PageController pageController = PageController(
    initialPage: 0,
  );

  late TabController tabController;

  ScrollPhysics scrollPhysicsStaff = const ScrollPhysics();
  ScrollPhysics scrollPhysicsLocation = const ScrollPhysics();

  ScrollController scrollControllerStaff = ScrollController();
  ScrollController scrollControllerLocation = ScrollController();

  // ScrollPhysics? scrollPhysics;
  // ScrollController? scrollController;

  void _selectedTab(int index) {
    // debugPrint("index masuk $index");
    if (index == 0) {
      indexClicked = 0;
      pageController.jumpToPage(
        0,
        // duration: const Duration(milliseconds: 300),
        // curve: Curves.ease,
      );
    } else if (index == 1) {
      indexClicked = 1;
      pageController.jumpToPage(
        1,
        // duration: const Duration(milliseconds: 300),
        // curve: Curves.ease,
      );
    } else if (index == 2) {
      indexClicked = 2;
      pageController.jumpToPage(
        2,
        // duration: const Duration(milliseconds: 300),
        // curve: Curves.ease,
      );
    } else {
      // Get.to(() => const ProfilePage());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const ProfilePage();
        }),
      );
    }
  }

  @override
  void initState() {
    context.read<HomeBloc>().add(GetHomeData());
    context.read<MonitorBloc>().add(GetListLocationAction());
    context.read<GetLogLocationBloc>().add(
          GetLogLocationAction(
            req: GetListLogRequestModel(
              startDate: DateTime(2010),
              endDate: DateTime.now(),
              limit: 10,
              currentPage: 1,
            ),
          ),
        );
    context.read<GetLogStaffBloc>().add(
          GetLogStaffAction(
            req: GetListLogRequestModel(
              startDate: DateTime(2010),
              endDate: DateTime.now(),
              limit: 10,
              currentPage: 1,
              staffUserStamp: true,
            ),
          ),
        );
    tabController = TabController(
      vsync: this,
      length: 2,
    );
    super.initState();
  }

  // final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.border,
      // appBar: AppAppBarWidget(
      //   // title: 'Main Page',
      //   title: '',
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) {
      //               return const ProfilePage();
      //             },
      //           ),
      //         );
      //       },
      //       icon: const Icon(
      //         Icons.person,
      //       ),
      //     )
      //   ],
      // ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (currentPage) {
          // debugPrint("page now: $currentPage");
          setState(() {
            indexClicked = currentPage;
          });
          // setState(() {
          //   _selectedTab(currentPage);
          // });
        },
        children: [
          HomePage(
            pageController: pageController,
            callbackController: (index) {
              setState(() {
                indexClicked = index;
              });
            },
          ),
          MonitorPage(
            pageController: pageController,
          ),
          LogPage(
            // bucket: _bucket,
            tabController: tabController,
            scrollPhysicsStaff: scrollPhysicsStaff,
            scrollPhysicsLocation: scrollPhysicsLocation,
            scrollControllerStaff: scrollControllerStaff,
            scrollControllerLocation: scrollControllerLocation,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        elevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const CapturePage(
                  capturePageActionEnum: CapturePageActionEnum.capture,
                );
              },
            ),
          );
        },
        child: Icon(
          Icons.camera_alt,
          color: AppColor.white,
          size: 28.h,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppCustomAppBar(
        centerItemText: 'Capture',
        color: AppColor.white,
        selectedColor: AppColor.white,
        notchedShape: const CircularNotchedRectangle(),
        onTabSelected: (index) {
          _selectedTab(index);
        },
        backgroundColor: AppColor.primary,
        iconSize: 25.h,
        fontSize: 12.sp,
        height: 80.h,
        currentIndex: indexClicked,
        items: [
          AppCustomAppBarItem(
            iconData: Icons.home,
            text: "Home",
          ),
          AppCustomAppBarItem(
            iconData: Icons.monitor_heart,
            text: "Monitor",
          ),
          AppCustomAppBarItem(
            iconData: Icons.wifi_protected_setup_rounded,
            text: "Log",
          ),
          AppCustomAppBarItem(
            iconData: Icons.person,
            text: "Profile",
          ),
        ],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: AppColor.primary,
      //   height: 60.h,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       InkWell(
      //         onTap: () {
      //           _selectedTab(0);
      //         },
      //         child: SizedBox(
      //           width: 100.w,
      //           height: 50.h,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Icon(
      //                 Icons.home,
      //                 size: 24.h,
      //                 color: AppColor.white,
      //               ),
      //               SizedBox(height: 2.h),
      //               Text(
      //                 "Home",
      //                 style: GoogleFonts.inter(
      //                   fontSize: 12.sp,
      //                   color: AppColor.white,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       InkWell(
      //         onTap: () {
      //           _selectedTab(1);
      //         },
      //         child: SizedBox(
      //           width: 100.w,
      //           height: 50.h,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Icon(
      //                 Icons.home,
      //                 size: 24.h,
      //                 color: AppColor.white,
      //               ),
      //               SizedBox(height: 2.h),
      //               Text(
      //                 "Monitor",
      //                 style: GoogleFonts.inter(
      //                   fontSize: 12.sp,
      //                   color: AppColor.white,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       InkWell(
      //         onTap: () {
      //           _selectedTab(2);
      //         },
      //         child: SizedBox(
      //           width: 100.w,
      //           height: 50.h,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Icon(
      //                 Icons.home,
      //                 size: 24.h,
      //                 color: AppColor.white,
      //               ),
      //               SizedBox(height: 2.h),
      //               Text(
      //                 "Log",
      //                 style: GoogleFonts.inter(
      //                   fontSize: 12.sp,
      //                   color: AppColor.white,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       InkWell(
      //         onTap: () {
      //           _selectedTab(3);
      //         },
      //         child: SizedBox(
      //           width: 100.w,
      //           height: 50.h,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Icon(
      //                 Icons.home,
      //                 size: 24.h,
      //                 color: AppColor.white,
      //               ),
      //               SizedBox(height: 2.h),
      //               Text(
      //                 "Other",
      //                 style: GoogleFonts.inter(
      //                   fontSize: 12.sp,
      //                   color: AppColor.white,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      // ),
      // ),
    );
  }
}
