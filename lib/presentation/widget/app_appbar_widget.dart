import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class AppAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBack;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool? automaticallyImplyLeading;

  const AppAppBarWidget({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
    this.bottom,
    this.automaticallyImplyLeading,
  });

  @override
  State<AppAppBarWidget> createState() => _AppAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppAppBarWidgetState extends State<AppAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColor.primary,
      elevation: 10,
      shadowColor: const Color(0xff101828),
      centerTitle: true,
      automaticallyImplyLeading: widget.automaticallyImplyLeading ?? true,
      leading: widget.onBack != null
          ? InkWell(
              onTap: widget.onBack,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )
          : null,
      title: Text(
        widget.title,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
      actions: widget.actions,
      bottom: widget.bottom,
    );
  }
}
