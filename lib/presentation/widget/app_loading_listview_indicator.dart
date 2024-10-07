import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class AppLoadingListViewIndicator extends StatelessWidget {
  const AppLoadingListViewIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 18,
      itemBuilder: (context, index) {
        return SkeletonLine(
          style: SkeletonLineStyle(height: 50.h),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 15.h);
      },
    );
  }
}
