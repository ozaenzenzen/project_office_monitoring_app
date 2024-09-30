import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_office_monitoring_app/presentation/page/capture_page/capture_page.dart';
import 'package:project_office_monitoring_app/presentation/specific_widget/location_item_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class DetailLocationPage extends StatefulWidget {
  const DetailLocationPage({super.key});

  @override
  State<DetailLocationPage> createState() => _DetailLocationPageState();
}

class _DetailLocationPageState extends State<DetailLocationPage> {
  final formatter = DateFormat('dd MMMM yyyy');
  TextEditingController checkpointDateTodayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const AppAppBarWidget(
        title: 'Detail Location Page',
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 12.h,
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
          Expanded(
            child: ListView.separated(
              // physics: const NeverScrollableScrollPhysics(),
              physics: const ScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return LocationItemWidget(
                  index: index,
                  title: "Staff",
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
        ],
      ),
    );
  }
}
