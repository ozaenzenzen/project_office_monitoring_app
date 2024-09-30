import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_office_monitoring_app/presentation/page/capture_page/capture_page.dart';
import 'package:project_office_monitoring_app/presentation/page/detail_log_page/detail_log_page.dart';
import 'package:project_office_monitoring_app/presentation/specific_widget/location_item_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> with TickerProviderStateMixin {
  late TabController tabController;
  // final formatter = DateFormat('dd MMMM yyyy, HH:mm:ss');
  final formatter = DateFormat('dd MMMM yyyy');
  TextEditingController checkpointDateTodayController = TextEditingController();
  TextEditingController checkpointDateLogController = TextEditingController();

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
            text: "Staff",
            icon: Icon(Icons.info),
          ),
          Tab(
            text: "Location",
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
          child: ListView.separated(
            // physics: const NeverScrollableScrollPhysics(),
            physics: const ScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 18,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return LocationItemWidget(
                index: index,
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
