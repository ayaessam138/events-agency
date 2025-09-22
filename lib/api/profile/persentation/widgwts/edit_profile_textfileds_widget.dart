import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/firebase/profile/data/models/firebase_profile_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/app_values.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/app_text_field.dart';

class EditProfileTextFieldsWidget extends StatelessWidget {

  final TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidth.w16,
            vertical: AppHight.h10,
          ), // prevent hiding
          child: Column(
            spacing: AppHight.h12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpace.vertical(AppHight.h25),

              /// Form Fields
              AppTextField(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p8,
                    vertical: AppPadding.p12,
                  ),
                  child: Icon(
                    Icons.person,
                    color: ColorsManager.lightGreyColor,
                  ),
                ),
                validator: (val) {},
                hintText: "Full name",
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: ColorsManager.lightGreyColor,
                ),
              ),

              AppTextField(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p8,
                    vertical: AppPadding.p12,
                  ),
                  child: Icon(Icons.email, color: ColorsManager.lightGreyColor),
                ),
                validator: (val) {},
                hintText: "Email",
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: ColorsManager.lightGreyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
