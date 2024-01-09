import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class DetailLocationPage extends StatefulWidget {
  const DetailLocationPage({super.key});

  @override
  State<DetailLocationPage> createState() => _DetailLocationPageState();
}

class _DetailLocationPageState extends State<DetailLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.border,
      appBar: const AppAppBarWidget(
        title: 'Detail Location Page',
        elevation: 0,
      ),
    );
  }
}
