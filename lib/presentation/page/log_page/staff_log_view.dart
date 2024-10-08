// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_request_model.dart';
// import 'package:project_office_monitoring_app/presentation/page/log_page/get_log_staff_bloc/get_log_staff_bloc.dart';
// import 'package:project_office_monitoring_app/presentation/specific_widget/location_item_widget.dart';
// import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';

// class StaffLogView extends StatelessWidget {
//   const StaffLogView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 18.h),
//         Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 12.h,
//           ),
//           child: Text(
//             "Log Page: Staff View",
//             style: GoogleFonts.inter(
//               fontSize: 32.sp,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         SizedBox(height: 12.h),
//         Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 12.h,
//           ),
//           child: AppTextFieldWidget(
//             textFieldTitle: "Checkpoint Date",
//             // textFieldHintText: "12-2-2023",
//             textFieldHintText: formatter.format(DateTime.now()),
//             controller: checkpointDateStaffController,
//             readOnly: true,
//             suffixIcon: const Icon(Icons.date_range_sharp),
//             onTap: () async {
//               DateTimeRange? output = await AppDateTimeHelper().dateRangePicker(
//                 context,
//                 startDate: startDateStaff,
//                 endDate: endDateStaff,
//               );
//               if (output != null) {
//                 startDateStaff = output.start;
//                 endDateStaff = output.end;

//                 // ignore: use_build_context_synchronously
//                 context.read<GetLogStaffBloc>().add(
//                       GetLogStaffAction(
//                         req: GetListLogRequestModel(
//                           typeLog: TypeLog.staff,
//                           typeAction: TypeAction.refresh,
//                           startDate: startDateStaff,
//                           endDate: endDateStaff,
//                           limit: 10,
//                           currentPage: 1,
//                           staffUserStamp: true,
//                         ),
//                       ),
//                     );

//                 setState(() {
//                   checkpointDateStaffController.text = "${formatter.format(output.start)} - ${formatter.format(output.end)}"; //set output date to TextField value.
//                 });
//               } else {
//                 debugPrint("Date is not selected");
//               }
//             },
//           ),
//         ),
//         SizedBox(height: 12.h),
//         Expanded(
//           child: BlocConsumer<GetLogStaffBloc, GetLogStaffState>(
//             listener: (context, state) {
//               if (state is GetLogStaffSuccess) {
//                 if (state.typeAction == TypeAction.refresh) {
//                   refreshControllerStaff.refreshCompleted();
//                 } else {
//                   refreshControllerStaff.loadComplete();
//                 }
//               }
//             },
//             builder: (context, state) {
//               if (state is GetLogStaffLoading) {
//                 return const AppLoadingListViewIndicator();
//               } else if (state is GetLogStaffSuccess) {
//                 return SmartRefresher(
//                   controller: refreshControllerStaff,
//                   enablePullUp: true,
//                   onRefresh: () async {
//                     context.read<GetLogStaffBloc>().add(
//                           GetLogStaffAction(
//                             req: GetListLogRequestModel(
//                               typeLog: TypeLog.staff,
//                               typeAction: TypeAction.refresh,
//                               startDate: startDateStaff,
//                               endDate: endDateStaff,
//                               limit: 10,
//                               currentPage: 1,
//                               staffUserStamp: true,
//                             ),
//                           ),
//                         );
//                   },
//                   onLoading: () {
//                     context.read<GetLogStaffBloc>().add(
//                           GetLogStaffAction(
//                             req: GetListLogRequestModel(
//                               typeLog: TypeLog.staff,
//                               typeAction: TypeAction.loading,
//                               startDate: startDateStaff,
//                               endDate: endDateStaff,
//                               limit: 10,
//                               staffUserStamp: true,
//                             ),
//                           ),
//                         );
//                   },
//                   child: ListView.separated(
//                     // physics: const NeverScrollableScrollPhysics(),
//                     physics: const ScrollPhysics(),
//                     // physics: widget.scrollPhysicsStaff,
//                     // controller: widget.scrollControllerStaff,
//                     // controller: scrollControllerStaff,
//                     // key: const PageStorageKey<String>('todolist'),
//                     padding: EdgeInsets.zero,
//                     itemCount: state.data != null ? state.data!.listData!.length : 0,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       return LocationItemWidget(
//                         index: index,
//                         title: "Staff",
//                         data: state.data!.listData,
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return SizedBox(
//                         height: 10.h,
//                       );
//                     },
//                   ),
//                 );
//               } else {
//                 return const SizedBox();
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
