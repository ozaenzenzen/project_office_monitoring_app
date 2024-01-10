import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/presentation/page/detail_log_page/detail_log_page.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  TabBar get _tabBar => TabBar(
        // unselectedLabelColor: AppColor.disabled,
        controller: tabController,
        tabs: const [
          Tab(
            text: "Hari Ini",
            icon: Icon(Icons.info),
          ),
          Tab(
            text: "Stats",
            icon: Icon(Icons.legend_toggle_sharp),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColor.white,
        child: Column(
          children: [
            Container(
              color: AppColor.primary,
              child: _tabBar,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  listLogView(),
                  statsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statsView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18.h),
          Text(
            "Log Page: Stats View",
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const DetailLocationPage();
                  //     },
                  //   ),
                  // );
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
                        "List Stats $index",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
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
    );
  }

  Widget listLogView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18.h),
          Text(
            "Log Page: Today View",
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
                        return const DetailLogPage();
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
                            Icons.security,
                            size: 16.h,
                          ),
                          SizedBox(width: 10.h),
                          Text(
                            "Staff $index",
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "List Log $index",
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "$index Jam yang lalu",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
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
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10.h,
              );
            },
          ),
        ],
      ),
    );
  }
}
