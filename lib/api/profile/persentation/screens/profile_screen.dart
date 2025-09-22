import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/logout_bottom_sheet_widget.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/rating_filter_dialog.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorsManager.mainColor,
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidth.w6,
            vertical: AppHight.h10,
          ),
          child: AutoSizeText(
  
            "Profile",
            style: TextStyles.font18Regular.copyWith(
              color: ColorsManager.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p12),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppHight.h12,
            children: [
              GestureDetector(
                onTap: () {
                  
                  AppNavigator.push(context, AppRoutes.editProfileScreen);
                },
                child: ListTile(
                  leading: Image.asset(AppImages.profile,color: ColorsManager.mainColor,),
                  title: AutoSizeText(
                    "Profile",
                    style: TextStyles.font18Regular,
                    maxLines: 1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showBottomSheetRating(context);
                },
                child: ListTile(
                  leading: Image.asset(AppImages.rate,color: ColorsManager.mainColor,),
                  title: AutoSizeText(
                    "Rate App",
                    style: TextStyles.font18Regular,
                    maxLines: 1,
                  ),
                ),
              ),
            
              ListTile(
                leading: Image.asset(AppImages.privacy,color: ColorsManager.mainColor,),
                title: AutoSizeText(
                  "Privacy Policy",
                  style: TextStyles.font18Regular,
                  maxLines: 1,
                ),
              ),
              GestureDetector(
                 onTap: () {
                   showBottomSheetLogout(context);
                   
                 }, 
                child: ListTile(
                  leading: Image.asset(AppImages.signOut,color: ColorsManager.mainColor,),
                  title: AutoSizeText(
                    "Sign Out",
                    style: TextStyles.font18Regular,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
