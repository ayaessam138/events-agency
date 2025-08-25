import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/feature/login/persentation/widgets/login_options.dart';
import 'package:bookingapp/feature/register/persentation/widgets/register_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppHight.h10,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back_sharp, size: 24.sp),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      AutoSizeText("SignUp", style: TextStyles.font24Medium),
                      RegisterTextfields(),
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
                          AutoSizeText(
                            maxLines: 1,
                            "Already have an account?",
                            style: TextStyles.font16Regular.copyWith(
                              color: ColorsManager.black,
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                AppNavigator.push(
                                  context,
                                  AppRoutes.loginScreen,
                                );
                              },
                              child: AutoSizeText(
                                maxLines: 1,
                                " Sign in",
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
