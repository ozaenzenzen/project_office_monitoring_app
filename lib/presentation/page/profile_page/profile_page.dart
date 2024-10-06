import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/init_config.dart';
import 'package:project_office_monitoring_app/presentation/page/profile_page/bloc/profile_bloc.dart';
import 'package:project_office_monitoring_app/presentation/page/signin_page/signin_page.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_appbar_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/app_textfield_widget.dart';
import 'package:project_office_monitoring_app/support/app_color.dart';
import 'package:skeletons/skeletons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController jabatanController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileLocalAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.border,
      appBar: const AppAppBarWidget(
        title: 'Profile Page',
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProfileBloc>().add(GetProfileRemoteAction());
        },
        child: SingleChildScrollView(
          // physics: const ScrollPhysics(),
          physics: const AlwaysScrollableScrollPhysics(),
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
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                    width: 50.h,
                    height: 50.h,
                  ),
                );
              } else if (state is ProfileSuccess) {
                if (state.userData!.profilePicture != null || state.userData!.profilePicture != "") {
                  return CircleAvatar(
                    radius: 30.0,
                    backgroundImage: MemoryImage(
                      base64Decode(
                        state.userData!.profilePicture!,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                  );
                } else {
                  return const CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      "https://bs-uploads.toptal.io/blackfish-uploads/components/seo/content/og_image_file/og_image/1096555/0408-FlutterMessangerDemo-Luke_Social-e8a0e8ddab86b503a125ebcad823c583.png",
                    ),
                    backgroundColor: Colors.transparent,
                  );
                }
              } else {
                return CircleAvatar(
                  backgroundColor: AppColor.border,
                  radius: 30.h,
                );
              }
            },
          ),
          SizedBox(height: 10.h),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return SizedBox(
                  width: 150.w,
                  child: const SkeletonLine(),
                );
              } else if (state is ProfileSuccess) {
                return Text(
                  "${state.userData?.name}",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                  ),
                );
              } else {
                return Text(
                  "",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                  ),
                );
              }
            },
          ),
          SizedBox(height: 6.h),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return SizedBox(
                  width: 250.w,
                  child: const SkeletonLine(),
                );
              } else if (state is ProfileSuccess) {
                return Text(
                  "${state.userData?.jabatan}",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                  ),
                );
              } else {
                return Text(
                  "",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget fieldSection() {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          jabatanController.text = state.userData?.jabatan ?? "";
          phoneController.text = state.userData?.phone ?? "";
        }
      },
      child: Container(
        color: AppColor.white,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 12.h,
        ),
        child: Column(
          children: [
            AppTextFieldWidget(
              textFieldTitle: "Posisi / Jabatan",
              textFieldHintText: "Posisi / Jabatan",
              readOnly: true,
              controller: jabatanController,
            ),
            SizedBox(height: 12.h),
            AppTextFieldWidget(
              textFieldTitle: "No Telepon",
              textFieldHintText: "0808-0808-0808",
              readOnly: true,
              controller: phoneController,
            ),
          ],
        ),
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
