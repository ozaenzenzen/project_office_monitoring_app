import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBarWidget(title: 'Main Page'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Test")
          ],
        ),
      ),
    );
  }
}
