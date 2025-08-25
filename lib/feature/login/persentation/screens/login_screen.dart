import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/feature/login/persentation/widgets/login_options.dart';
import 'package:bookingapp/feature/login/persentation/widgets/login_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppHight.h20,
                    children: [
                      AppSpace.vertical(AppHight.h20),
                      AutoSizeText(
                        "Sign In",
                        maxLines: 1,
                        style: TextStyles.font24Medium,
                        textAlign: TextAlign.start,
                      ),
                      LoginTextFields(),
                      LoginOptions(
                        height: 50.h,
                        image: AppImages.google,
                        label: "Login With Google",
                      ),
                      LoginOptions(
                        height: 50.h,
                        image: AppImages.facebook,
                        label: "Login With FaceBook",
                      ),
                
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: AppWidth.w2,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                              maxLines: 1,
                              "Don’t have an account?",
                              style: TextStyles.font16Regular.copyWith(
                                color: ColorsManager.black,
                              ),
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                AppNavigator.push(
                                  context,
                                  AppRoutes.registerScreen,
                                );
                              },
                              child: AutoSizeText(
                                maxLines: 1,
                                " Sign up",
                                style: TextStyles.font16Regular.copyWith(
                                  color: ColorsManager.mainColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
