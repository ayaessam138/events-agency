import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/edit_profile_button_widget.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/edit_profile_textfileds_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_values.dart';
import '../../../../core/theming/colors.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: ColorsManager.mainColor,
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidth.w6,
            vertical: AppHight.h10,
          ),
          child: AutoSizeText(
            " Edit Profile",
            style: TextStyles.font18Regular.copyWith(
              color: ColorsManager.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Content Section
            EditProfileTextFieldsWidget(),

            /// Bottom Button
            Column(
              spacing: AppHight.h10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(thickness: 0.2.w, color: ColorsManager.black),
                Padding(
                  padding: EdgeInsets.all(AppPadding.p16),
                  child: SaveButton(title: "Save Now", onTap: () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
