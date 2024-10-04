import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/init_config.dart';
import 'package:project_office_monitoring_app/presentation/page/signin_page/signin_page.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.border,
      appBar: const AppAppBarWidget(
        title: 'Profile Page',
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profilePictureSection(),
            SizedBox(height: 12.h),
            fieldSection(),
            SizedBox(height: 12.h),
            menuSection(),
          ],
        ),
      ),
    );
  }

  Widget profilePictureSection() {
    return Container(
      color: AppColor.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 12.h,
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              "https://bs-uploads.toptal.io/blackfish-uploads/components/seo/content/og_image_file/og_image/1096555/0408-FlutterMessangerDemo-Luke_Social-e8a0e8ddab86b503a125ebcad823c583.png",
            ),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: 10.h),
          Text(
            "Testing Nama",
            style: GoogleFonts.inter(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            "Testing Jabatan",
            style: GoogleFonts.inter(
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldSection() {
    return Container(
      color: AppColor.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 12.h,
      ),
      child: Column(
        children: [
          const AppTextFieldWidget(
            textFieldTitle: "Posisi / Jabatan",
            textFieldHintText: "Posisi / Jabatan",
            readOnly: true,
          ),
          SizedBox(height: 12.h),
          const AppTextFieldWidget(
            textFieldTitle: "No Telepon",
            textFieldHintText: "0808-0808-0808",
            readOnly: true,
          ),
        ],
      ),
    );
  }

  Widget menuSection() {
    return Container(
      color: AppColor.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 12.h,
      ),
      child: Column(
        children: [
          // InkWell(
          //   onTap: () {
          //     //
          //   },
          //   child: SizedBox(
          //     height: 40.h,
          //     child: Row(
          //       children: [
          //         Icon(
          //           Icons.lock,
          //           size: 24.h,
          //         ),
          //         SizedBox(width: 8.w),
          //         Text(
          //           "Ubah Kata Sandi / Password",
          //           style: GoogleFonts.inter(
          //             fontSize: 12.sp,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: 12.h),
          InkWell(
            onTap: () {
              AppInitConfig.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
                  return const SignInPage();
                }),
                (Route<dynamic> route) => false,
              );
            },
            child: SizedBox(
              height: 40.h,
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 24.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Keluar Aplikasi",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget otherSection() {
    return Container(
      color: AppColor.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 12.h,
      ),
    );
  }
}
