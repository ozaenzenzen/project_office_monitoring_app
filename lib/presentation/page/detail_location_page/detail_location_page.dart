import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_request_model.dart';
import 'package:project_office_monitoring_app/domain/entities/get_list_log_data_entity.dart';
import 'package:project_office_monitoring_app/presentation/page/detail_location_page/bloc/detail_location_log_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/detail_location_page/detail_location_top_handler.dart';
import 'package:project_office_monitoring_app/presentation/specific_widget/location_item_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_overlay_loading2_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailLocationPage extends StatefulWidget {
  const DetailLocationPage({super.key});

  @override
  State<DetailLocationPage> createState() => _DetailLocationPageState();
}

class _DetailLocationPageState extends State<DetailLocationPage> {
  final formatter = DateFormat('dd MMMM yyyy');

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();

  String location = "";

  RefreshController refreshController = RefreshController();

  List<ListDatumEntity> listData = [];

  @override
  void initState() {
    super.initState();
    location = DetailLocationTopHandler().data;

    startDateController.text = formatter.format(startDate);
    endDateController.text = formatter.format(endDate);

    context.read<DetailLocationLogBloc>().add(
          GetDetailLocationLogAction(
            req: GetListLogRequestModel(
              typeLog: TypeLog.staff,
              typeAction: TypeAction.refresh,
              startDate: startDate,
              endDate: endDate,
              currentPage: 1,
              location: location,
            ),
          ),
        );
  }

  bool isLoadingActive = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        listData = [];
        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppAppBarWidget(
              title: 'List Log of $location',
              elevation: 0,
            ),
            body: Column(
              children: [
                dateFilterWidget(context),
                listViewWidget(),
              ],
            ),
          ),
          BlocListener<DetailLocationLogBloc, DetailLocationLogState>(
            listener: (context, state) {
              if (state is DetailLocationLogLoading) {
                isLoadingActive = true;
              } else {
                isLoadingActive = false;
              }
              setState(() {});
            },
            child: (isLoadingActive) ? const AppOverlayLoading2Widget() : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget listViewWidget() {
    return BlocConsumer<DetailLocationLogBloc, DetailLocationLogState>(
      listener: (context, state) {
        if (state is DetailLocationLogSuccess) {
          if (state.typeAction == TypeAction.refresh) {
            refreshController.refreshCompleted();
          } else {
            refreshController.loadComplete();
          }
        }
      },
      builder: (context, state) {
        if (state is DetailLocationLogSuccess) {
          listData = state.data!.listData!;
        }
        return Expanded(
          child: SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            onRefresh: () async {
              startDate = DateTime.now().subtract(const Duration(days: 30));
              endDate = DateTime.now();

              context.read<DetailLocationLogBloc>().add(
                    GetDetailLocationLogAction(
                      req: GetListLogRequestModel(
                        typeLog: TypeLog.location,
                        typeAction: TypeAction.refresh,
                        startDate: startDate,
                        endDate: endDate,
                        location: location,
                      ),
                    ),
                  );

              setState(() {
                startDateController.text = formatter.format(startDate);
                endDateController.text = formatter.format(endDate);
              });
            },
            onLoading: () {
              context.read<DetailLocationLogBloc>().add(
                    GetDetailLocationLogAction(
                      req: GetListLogRequestModel(
                        typeLog: TypeLog.location,
                        typeAction: TypeAction.loading,
                        startDate: startDate,
                        endDate: endDate,
                        location: location,
                      ),
                    ),
                  );
            },
            child: ListView.separated(
              // physics: const NeverScrollableScrollPhysics(),
              physics: const ScrollPhysics(),
              // itemCount: 10,
              itemCount: listData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return LocationItemWidget(
                  index: index,
                  title: "Staff",
                  data: listData,
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 0.1,
                  color: AppColor.border,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget dateFilterWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 12.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: AppTextFieldWidget(
              textFieldTitle: "Start Date",
              // textFieldHintText: "12-2-2023",
              textFieldHintText: formatter.format(startDate),
              controller: startDateController,
              readOnly: true,
              suffixIcon: const Icon(Icons.date_range_sharp),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  AppLogger.debugLog("Picked Date: ${pickedDate.toString()}"); //pickedDate output format => 2021-03-10 00:00:00.000
                  startDate = pickedDate;
                  // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  String formattedDate = formatter.format(pickedDate);
                  AppLogger.debugLog("Formatted Date: $formattedDate"); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    startDateController.text = formattedDate; //set output date to TextField value.
                  });

                  // ignore: use_build_context_synchronously
                  context.read<DetailLocationLogBloc>().add(
                        GetDetailLocationLogAction(
                          req: GetListLogRequestModel(
                            typeLog: TypeLog.staff,
                            typeAction: TypeAction.refresh,
                            startDate: startDate,
                            endDate: endDate,
                            currentPage: 1,
                            location: location,
                          ),
                        ),
                      );
                } else {
                  debugPrint("Date is not selected");
                }
              },
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: AppTextFieldWidget(
              textFieldTitle: "End Date",
              // textFieldHintText: "12-2-2023",
              textFieldHintText: formatter.format(endDate),
              controller: endDateController,
              readOnly: true,
              suffixIcon: const Icon(Icons.date_range_sharp),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: endDate,
                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  endDate = pickedDate;
                  AppLogger.debugLog("Picked Date: ${pickedDate.toString()}"); //pickedDate output format => 2021-03-10 00:00:00.000
                  // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  String formattedDate = formatter.format(pickedDate);
                  AppLogger.debugLog("Formatted Date: $formattedDate"); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    endDateController.text = formattedDate; //set output date to TextField value.
                  });

                  // ignore: use_build_context_synchronously
                  context.read<DetailLocationLogBloc>().add(
                        GetDetailLocationLogAction(
                          req: GetListLogRequestModel(
                            typeLog: TypeLog.staff,
                            typeAction: TypeAction.refresh,
                            startDate: startDate,
                            endDate: endDate,
                            currentPage: 1,
                            location: location,
                          ),
                        ),
                      );
                } else {
                  debugPrint("Date is not selected");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
