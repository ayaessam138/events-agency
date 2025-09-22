import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/helpers/dependency_injection.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/logout_bottom_sheet_widget.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/rating_filter_dialog.dart';
import 'package:bookingapp/firebase/profile/persentation/cubit/firebase_profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseProfileScreen extends StatelessWidget {
  const FirebaseProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Profile",
            style: TextStyles.font18Regular.copyWith(
              color: ColorsManager.white,
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create:
            (context) =>
                getIt<FirebaseProfileCubit>()
                  ..getUserProfile(FirebaseAuth.instance.currentUser!.uid),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p12),
            child: BlocBuilder<FirebaseProfileCubit, FirebaseProfileState>(
              builder: (context, state) {
                var cubit=  FirebaseProfileCubit.of(
                                  context,
                                );
                if (state is FirebaseProfileSuccess) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await FirebaseProfileCubit.of(context).getUserProfile(
                        FirebaseAuth.instance.currentUser!.uid,
                        isRefresh: true,
                      );
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppHight.h12,
                        children: [
                          Row(
                            spacing: AppWidth.w10,
                            children: [
                              AutoSizeText(
                                "Name :",
                                style: TextStyles.font18Regular,
                                maxLines: 1,
                              ),
                              AutoSizeText(
                                state.profile.name,
                                style: TextStyles.font18Regular,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Row(
                            spacing: AppWidth.w10,
                            children: [
                              AutoSizeText(
                                "Email :",
                                style: TextStyles.font18Regular,
                                maxLines: 1,
                              ),
                              AutoSizeText(
                                state.profile.email,
                                style: TextStyles.font18Regular,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: () async {
                              final updated = await AppNavigator.push(
                                context,
                                AppRoutes.firebaseEditProfileScreen,
                                extra: state.profile,
                              );

                              if (updated == true) {
                                
                                await cubit.getUserProfile(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  isRefresh: true,
                                );
                              }
                            },
                            child: ListTile(
                              leading: Image.asset(
                                AppImages.profile,
                                color: ColorsManager.mainColor,
                              ),
                              title: AutoSizeText(
                                "Edit Profile",
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
                              leading: Image.asset(
                                AppImages.rate,
                                color: ColorsManager.mainColor,
                              ),
                              title: AutoSizeText(
                                "Rate App",
                                style: TextStyles.font18Regular,
                                maxLines: 1,
                              ),
                            ),
                          ),

                          ListTile(
                            leading: Image.asset(
                              AppImages.privacy,
                              color: ColorsManager.mainColor,
                            ),
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
                              leading: Image.asset(
                                AppImages.signOut,
                                color: ColorsManager.mainColor,
                              ),
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
                  );
                } else if (state is FirebaseProfileFail) {
                  return AutoSizeText(
                    state.message,
                    style: TextStyles.font18Regular,
                    maxLines: 1,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
