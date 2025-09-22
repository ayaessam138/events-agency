import 'package:auto_size_text/auto_size_text.dart' show AutoSizeText;
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/edit_profile_button_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showBottomSheetLogout(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.r20)),
    ),
    backgroundColor: ColorsManager.white,

    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(AppPadding.p12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppHight.h10,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p12),
                  child: Icon(Icons.close, color: ColorsManager.greyColor),
                ),
              ),
            ),
            Icon(Icons.logout, size: 50.sp),
            AutoSizeText("SignOut", style: TextStyles.font18Bold),
            AutoSizeText(
              textAlign: TextAlign.center,
              "Are you sure that you want to LogOut From Account",
              style: TextStyles.font16Regular.copyWith(
                color: ColorsManager.greyDarkColor,
              ),
            ),
            Flexible(
              child: SaveButton(
                height: 56.h,
                title: "Keep it",
                onTap: () {},
                bordercolor: ColorsManager.greyColor,
                buttoncolor: ColorsManager.white,
                buttonTextcolor: ColorsManager.black,
              ),
            ),
            Flexible(
              child: SaveButton(
                height: 56.h,
                title: "Confirm LogOut",
                onTap: () {},

                buttoncolor: ColorsManager.darkRed,
                buttonTextcolor: ColorsManager.white,
              ),
            ),
          ],
        ),
      );
    },
  );
}
