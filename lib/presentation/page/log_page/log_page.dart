import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_request_model.dart';
import 'package:project_office_monitoring_app/presentation/page/log_page/bloc/log_bloc.dart';
import 'package:project_office_monitoring_app/presentation/specific_widget/location_item_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_loading_listview_indicator.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class LogPage extends StatefulWidget {
  final TabController tabController;

  const LogPage({
    super.key,
    required this.tabController,
  });

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  // late TabController tabController;
  // final formatter = DateFormat('dd MMMM yyyy, HH:mm:ss');
  final formatter = DateFormat('dd MMMM yyyy');
  TextEditingController checkpointDateTodayController = TextEditingController();
  TextEditingController checkpointDateLogController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   tabController = TabController(
  //     vsync: this,
  //     length: 2,
  //   );
  // }

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
            "Log Page: Location View",
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
            controller: checkpointDateLogController,
            readOnly: true,
            suffixIcon: const Icon(Icons.date_range_sharp),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                debugPrint(pickedDate.toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                String formattedDate = formatter.format(pickedDate);
                debugPrint(formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                // ignore: use_build_context_synchronously
                context.read<LogBloc>().add(
                      GetListLogAction(
                        req: GetListLogRequestModel(
                          startDate: DateTime(2010),
                          endDate: pickedDate,
                          limit: 10,
                          currentPage: 1,
                        ),
                      ),
                    );

                setState(() {
                  checkpointDateLogController.text = formattedDate; //set output date to TextField value.
                });
              } else {
                debugPrint("Date is not selected");
              }
            },
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: BlocBuilder<LogBloc, LogState>(
            builder: (context, state) {
              if (state is LogLoading) {
                return const AppLoadingListViewIndicator();
              } else if (state is LogSuccess) {
                return ListView.separated(
                  // physics: const NeverScrollableScrollPhysics(),
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: state.result != null ? state.result!.listData!.length : 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return LocationItemWidget(
                      index: index,
                      title: "Staff",
                      data: state.result,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
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
            controller: checkpointDateTodayController,
            readOnly: true,
            suffixIcon: const Icon(Icons.date_range_sharp),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                debugPrint(pickedDate.toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                String formattedDate = formatter.format(pickedDate);
                debugPrint(formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  checkpointDateTodayController.text = formattedDate; //set output date to TextField value.
                });
              } else {
                debugPrint("Date is not selected");
              }
            },
          ),
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: ListView.separated(
            // physics: const NeverScrollableScrollPhysics(),
            physics: const ScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 18,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return LocationItemWidget(
                index: index,
                title: "Staff",
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10.h,
              );
            },
          ),
        ),
      ],
    );
  }
}
