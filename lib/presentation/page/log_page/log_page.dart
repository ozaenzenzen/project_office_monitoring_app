import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_request_model.dart';
import 'package:project_office_monitoring_app/domain/entities/get_list_log_data_entity.dart';
import 'package:project_office_monitoring_app/presentation/page/log_page/get_log_location_bloc/get_log_location_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/log_page/get_log_staff_bloc/get_log_staff_bloc.dart';
import 'package:project_office_monitoring_app/presentation/specific_widget/location_item_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_loading_indicator.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';
import 'package:project_office_monitoring_app/support/app_date_time_helper.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LogPage extends StatefulWidget {
  // final PageStorageBucket bucket;
  final TabController tabController;
  final ScrollPhysics scrollPhysicsStaff;
  final ScrollPhysics scrollPhysicsLocation;

  final ScrollController scrollControllerStaff;
  final ScrollController scrollControllerLocation;

  const LogPage({
    super.key,
    // required this.bucket,
    required this.tabController,
    required this.scrollPhysicsStaff,
    required this.scrollControllerStaff,
    required this.scrollPhysicsLocation,
    required this.scrollControllerLocation,
  });

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> with AutomaticKeepAliveClientMixin {
  // late TabController tabController;
  // final formatter = DateFormat('dd MMMM yyyy, HH:mm:ss');
  final formatter = DateFormat('dd MMMM yyyy');
  TextEditingController checkpointDateStaffController = TextEditingController();
  TextEditingController checkpointDateLocationController = TextEditingController();

  DateTime? startDateStaff;
  DateTime? endDateStaff;

  DateTime? startDateLocation;
  DateTime? endDateLocation;

  // int currentPageStaff = 1;
  // int totalPagesStaff = 0;
  RefreshController refreshControllerStaff = RefreshController(initialRefresh: false);

  // int currentPageLocation = 1;
  // int totalPagesLocation = 0;
  RefreshController refreshControllerLocation = RefreshController(initialRefresh: false);

  // GetListLogDataEntity? listDataStaff;
  // GetListLogDataEntity? listDataLocation;

  ScrollController scrollControllerStaff = ScrollController();
  ScrollController scrollControllerLocation = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    AppLogger.debugLog("Test");
    startDateStaff = DateTime.now().subtract(const Duration(days: 365));
    endDateStaff = DateTime.now();
    checkpointDateStaffController.text = "${formatter.format(startDateStaff!)} - ${formatter.format(endDateStaff!)}"; //set output date to TextField value.

    startDateLocation = DateTime.now().subtract(const Duration(days: 365));
    endDateLocation = DateTime.now();
    checkpointDateLocationController.text = "${formatter.format(startDateLocation!)} - ${formatter.format(endDateLocation!)}"; //set output date to TextField value.
  }

  TabBar get _tabBar => TabBar(
        // unselectedLabelColor: AppColor.disabled,
        indicatorColor: AppColor.white,
        controller: widget.tabController,
        tabs: [
          Tab(
            // text: "Staff",
            icon: Icon(
              Icons.info,
              color: AppColor.white,
              size: 24.h,
            ),
            child: Text(
              "Staff",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: AppColor.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Tab(
            // text: "Location",
            icon: Icon(
              Icons.legend_toggle_sharp,
              color: AppColor.white,
              size: 24.h,
            ),
            child: Text(
              "Location",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: AppColor.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );

  List<ListDatumEntity> listDataStaff = [];
  List<ListDatumEntity> listDataLocation = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                controller: widget.tabController,
                children: [
                  staffView(),
                  locationView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget modalProgressLoading() {
    return Container(
      color: Colors.black54,
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
    );
  }

  Widget locationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18.h),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
          ),
          child: Text(
            "Log Page: All View",
            style: GoogleFonts.inter(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
          ),
          child: AppTextFieldWidget(
            textFieldTitle: "Checkpoint Date",
            // textFieldHintText: "12-2-2023",
            textFieldHintText: formatter.format(DateTime.now()),
            controller: checkpointDateLocationController,
            readOnly: true,
            suffixIcon: const Icon(Icons.date_range_sharp),
            onTap: () async {
              DateTimeRange? output = await AppDateTimeHelper().dateRangePicker(
                context,
                startDate: startDateLocation,
                endDate: endDateLocation,
              );
              if (output != null) {
                startDateLocation = output.start;
                endDateLocation = output.end;

                // ignore: use_build_context_synchronously
                context.read<GetLogLocationBloc>().add(
                      GetLogLocationAction(
                        req: GetListLogRequestModel(
                          typeLog: TypeLog.location,
                          typeAction: TypeAction.refresh,
                          startDate: output.start,
                          endDate: output.end,
                          currentPage: 1,
                          staffUserStamp: false,
                        ),
                      ),
                    );

                setState(() {
                  checkpointDateLocationController.text = "${formatter.format(output.start)} - ${formatter.format(output.end)}"; //set output date to TextField value.
                });
              } else {
                debugPrint("Date is not selected");
              }
            },
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: BlocConsumer<GetLogLocationBloc, GetLogLocationState>(
            listener: (context, state) {
              if (state is GetLogLocationSuccess) {
                if (state.typeAction == TypeAction.refresh) {
                  refreshControllerLocation.refreshCompleted();
                } else {
                  refreshControllerLocation.loadComplete();
                }
              }
            },
            builder: (context, state) {
              if (state is GetLogLocationSuccess) {
                listDataLocation = state.data!.listData!;
              }
              return SmartRefresher(
                controller: refreshControllerLocation,
                enablePullUp: true,
                onRefresh: () async {
                  context.read<GetLogLocationBloc>().add(
                        GetLogLocationAction(
                          req: GetListLogRequestModel(
                            typeLog: TypeLog.location,
                            typeAction: TypeAction.refresh,
                            startDate: startDateLocation,
                            endDate: endDateLocation,
                            staffUserStamp: false,
                          ),
                        ),
                      );
                },
                onLoading: () {
                  context.read<GetLogLocationBloc>().add(
                        GetLogLocationAction(
                          req: GetListLogRequestModel(
                            typeLog: TypeLog.location,
                            typeAction: TypeAction.loading,
                            startDate: startDateLocation,
                            endDate: endDateLocation,
                            staffUserStamp: false,
                          ),
                        ),
                      );
                },
                child: ListView.separated(
                  // addAutomaticKeepAlives: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  // physics: widget.scrollPhysicsLocation,
                  // controller: widget.scrollControllerLocation,
                  physics: const ScrollPhysics(),
                  controller: scrollControllerLocation,
                  key: const PageStorageKey<String>('location'),
                  padding: EdgeInsets.zero,
                  // itemCount: state.data != null ? state.data!.listData!.length : 0,
                  itemCount: listDataLocation.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return LocationItemWidget(
                      index: index,
                      title: "Staff",
                      // data: state.data!.listData,
                      data: listDataLocation,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget staffView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18.h),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
          ),
          child: Text(
            "Log Page: Staff View",
            style: GoogleFonts.inter(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
          ),
          child: AppTextFieldWidget(
            textFieldTitle: "Checkpoint Date",
            // textFieldHintText: "12-2-2023",
            textFieldHintText: formatter.format(DateTime.now()),
            controller: checkpointDateStaffController,
            readOnly: true,
            suffixIcon: const Icon(Icons.date_range_sharp),
            onTap: () async {
              DateTimeRange? output = await AppDateTimeHelper().dateRangePicker(
                context,
                startDate: startDateStaff,
                endDate: endDateStaff,
              );
              if (output != null) {
                startDateStaff = output.start;
                endDateStaff = output.end;

                // ignore: use_build_context_synchronously
                context.read<GetLogStaffBloc>().add(
                      GetLogStaffAction(
                        req: GetListLogRequestModel(
                          typeLog: TypeLog.staff,
                          typeAction: TypeAction.refresh,
                          startDate: startDateStaff,
                          endDate: endDateStaff,
                          currentPage: 1,
                          staffUserStamp: true,
                        ),
                      ),
                    );

                setState(() {
                  checkpointDateStaffController.text = "${formatter.format(output.start)} - ${formatter.format(output.end)}"; //set output date to TextField value.
                });
              } else {
                debugPrint("Date is not selected");
              }
            },
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: BlocConsumer<GetLogStaffBloc, GetLogStaffState>(
            listener: (context, state) {
              if (state is GetLogStaffSuccess) {
                AppLogger.debugLog("state now : $state");
                if (state.typeAction == TypeAction.refresh) {
                  refreshControllerStaff.refreshCompleted();
                } else {
                  refreshControllerStaff.loadComplete();
                }
              }
            },
            builder: (context, state) {
              if (state is GetLogStaffSuccess) {
                listDataStaff = state.data!.listData!;
              }
              return SmartRefresher(
                controller: refreshControllerStaff,
                enablePullUp: true,
                onRefresh: () async {
                  context.read<GetLogStaffBloc>().add(
                        GetLogStaffAction(
                          req: GetListLogRequestModel(
                            typeLog: TypeLog.staff,
                            typeAction: TypeAction.refresh,
                            startDate: startDateStaff,
                            endDate: endDateStaff,
                            currentPage: 1,
                            staffUserStamp: true,
                          ),
                        ),
                      );
                },
                onLoading: () {
                  context.read<GetLogStaffBloc>().add(
                        GetLogStaffAction(
                          req: GetListLogRequestModel(
                            typeLog: TypeLog.staff,
                            typeAction: TypeAction.loading,
                            startDate: startDateStaff,
                            endDate: endDateStaff,
                            staffUserStamp: true,
                          ),
                        ),
                      );
                },
                child: ListView.separated(
                  // physics: const NeverScrollableScrollPhysics(),
                  // physics: widget.scrollPhysicsStaff,
                  // controller: widget.scrollControllerStaff,
                  physics: const ScrollPhysics(),
                  controller: scrollControllerStaff,
                  key: const PageStorageKey<String>('staff'),
                  padding: EdgeInsets.zero,
                  // itemCount: state.data != null ? state.data!.listData!.length : 0,
                  itemCount: listDataStaff.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return LocationItemWidget(
                      index: index,
                      title: "Staff",
                      // data: state.data!.listData,
                      data: listDataStaff,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
