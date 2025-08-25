
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart' show TextStyles;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SaveButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? horizontalPadding;
  final double? verticalPadding;
  final String title;
  final void Function() onTap;
  final Color? buttoncolor;
  final Color? bordercolor;
  final Color? buttonTextcolor;
  const SaveButton({
    super.key,
    this.width,
    this.height,
    this.horizontalPadding,
    this.verticalPadding,
    required this.title,
    required this.onTap,
     this.buttoncolor,
     this.buttonTextcolor,
     this.bordercolor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 8.w,
          vertical: verticalPadding ?? 8.h,
        ),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttoncolor??ColorsManager.mainColor,
          borderRadius: BorderRadius.circular(AppRadius.r10),
          border: Border.all(color:bordercolor?? Colors.transparent)
        ),
        child: Center(
          child: FittedBox(
            child: AutoSizeText(
              maxLines: 1,
              title,
              style: TextStyles.font16Medium.copyWith(
                color:buttonTextcolor?? ColorsManager.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
