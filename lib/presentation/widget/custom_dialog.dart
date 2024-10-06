import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_office_monitoring_app/presentation/widget/asset_image_widget.dart';
import 'package:project_office_monitoring_app/presentation/widget/button_custom_widget.dart';

enum ButtonDirectionV2 { vertical, horizontal }

class CustomDialogV2 extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? asset;
  final Widget? content;
  final ButtonDirectionV2? buttonDirection;
  final String? primaryButtonText;
  final Color? primaryButtonColor;
  final Color? primaryTextColor;
  final String? secondaryButtonText;
  final Color? secondaryButtonColor;
  final Color? secondaryTextColor;
  final void Function()? onTapPrimary;
  final Function()? onTapSecondary;

  const CustomDialogV2({
    Key? key,
    required this.title,
    this.subTitle,
    this.asset,
    this.content,
    this.onTapPrimary,
    this.onTapSecondary,
    this.primaryButtonText,
    this.primaryButtonColor,
    this.primaryTextColor,
    this.secondaryButtonText,
    this.secondaryButtonColor,
    this.secondaryTextColor,
    this.buttonDirection = ButtonDirectionV2.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Material(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (asset != null && asset != '') ...<Widget>[
                AssetImageWidget(
                  assets: asset!,
                  height: 128,
                  width: 128,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
                // style: AppTheme.textStyle.blackTextStyle.copyWith(
                //   fontSize: AppTheme.textConfig.size.l,
                //   fontWeight: AppTheme.textConfig.weight.semiBold,
                // ),
              ),
              SizedBox(height: 8.h),
              // if (subTitle != null && subTitle != '') ...<Widget>[
              //   SizedBox(
              //     height: 16.h,
              //   ),
              //   Text(
              //     subTitle!,
              //     textAlign: TextAlign.center,
              //     style: AppTheme.textStyle.blackTextStyle.copyWith(
              //       fontSize: AppTheme.textConfig.size.n,
              //     ),
              //   ),
              // ],
              content ?? const SizedBox(),
              SizedBox(
                height: 12.h,
              ),
              if (buttonDirection == ButtonDirectionV2.horizontal) ...<Widget>[
                Row(
                  children: <Widget>[
                    Visibility(
                      visible: primaryButtonText != null && primaryButtonText != '',
                      child: Expanded(
                        child: ButtonCustom(
                          paddingVer: 8.h,
                          borderRadius: 6.r,
                          paddingHor: 12.w,
                          text: primaryButtonText ?? '',
                          // textColor: primaryTextColor ?? AppTheme.colors.neutral500,
                          textColor: primaryTextColor ?? const Color(0xff42526D),
                          buttonColor: primaryButtonColor ?? const Color(0xffF5F6F7),
                          onTap: onTapPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Visibility(
                      visible: secondaryButtonText != null && secondaryButtonText != '',
                      child: Expanded(
                        child: ButtonCustom(
                          paddingVer: 8.h,
                          paddingHor: 12.w,
                          borderRadius: 6.r,
                          text: secondaryButtonText ?? '',
                          // textColor: (onTapSecondary == null) ? Colors.white : secondaryTextColor ?? AppTheme.colors.neutral500,
                          textColor: (onTapSecondary == null) ? Colors.white : secondaryTextColor ?? const Color(0xff42526D),
                          buttonColor: (onTapSecondary == null) ? const Color(0xffC2C7D0) : secondaryButtonColor ?? const Color(0xffFFFF00),
                          onTap: onTapSecondary,
                        ),
                      ),
                    ),
                  ],
                )
              ] else ...<Widget>[
                primaryButtonText != null
                    ? Visibility(
                        visible: primaryButtonText != null && primaryButtonText != '',
                        child: ButtonCustom(
                          paddingVer: 8.h,
                          paddingHor: 12.w,
                          borderRadius: 6.r,
                          text: primaryButtonText ?? '',
                          // textColor: primaryTextColor ?? AppTheme.colors.neutral500,
                          textColor: primaryTextColor ?? const Color(0xff42526D),
                          buttonColor: primaryButtonColor ?? const Color(0xffF5F6F7),
                          onTap: onTapPrimary,
                        ),
                      )
                    : const SizedBox.shrink(),
                Visibility(
                  visible: secondaryButtonText != null && secondaryButtonText != '',
                  child: ButtonCustom(
                    paddingVer: 8.h,
                    paddingHor: 12.w,
                    borderRadius: 6.r,
                    text: secondaryButtonText ?? '',
                    textColor: (onTapSecondary == null) ? Colors.white : secondaryTextColor ?? const Color(0xff42526D),
                    buttonColor: (onTapSecondary == null) ? const Color(0xffC2C7D0) : secondaryButtonColor ?? const Color(0xffFFFF00),
                    onTap: () => onTapSecondary,
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
