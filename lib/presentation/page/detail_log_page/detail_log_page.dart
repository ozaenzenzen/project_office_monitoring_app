import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class DetailLogPage extends StatefulWidget {
  const DetailLogPage({super.key});

  @override
  State<DetailLogPage> createState() => _DetailLogPageState();
}

class _DetailLogPageState extends State<DetailLogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.border,
      appBar: const AppAppBarWidget(
        title: 'Detail Log Page',
        elevation: 0,
      ),
    );
  }
}