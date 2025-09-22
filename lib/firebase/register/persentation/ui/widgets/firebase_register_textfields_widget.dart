import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/models/firebase_auth_param.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/widgets/app_button.dart';
import 'package:bookingapp/core/widgets/app_loading.dart';
import 'package:bookingapp/core/widgets/app_text_field.dart';
import 'package:bookingapp/firebase/register/data/models/firebase_register_model.dart';
import 'package:bookingapp/firebase/register/persentation/controller/cubit/firebase_register_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FirebaseRegisterTextfieldsWidget extends StatelessWidget {
  FirebaseRegisterTextfieldsWidget({super.key});
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FirebaseRegisterCubit, FirebaseRegisterState>(
      builder: (context, state) {
        var cubit = FirebaseRegisterCubit.get;
        return LayoutBuilder(
          builder: (context, constraints) {
            return Form(
              key: _formKey,
              child: Column(
                spacing: AppHight.h10,
                children: [
                  AppTextField(
                    controller: name,
                    hintText: "Full Name",
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    unFocusedBorderColor: ColorsManager.greyColor,
                    focusedBorderColor: ColorsManager.greyColor,
                    contentPadding: EdgeInsets.all(AppPadding.p10),
                    isDense: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(AppPadding.p16),
                      child: SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: SvgPicture.asset(
                          AppImages.email,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    validator: (String? val) {
                      return AppHeleperFunctions.validateFullName(val);
                    },
                  ),
                  AppTextField(
                    controller: email,
                    hintText: "abc@email.com",
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    unFocusedBorderColor: ColorsManager.greyColor,
                    focusedBorderColor: ColorsManager.greyColor,
                    contentPadding: EdgeInsets.all(AppPadding.p10),
                    isDense: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(AppPadding.p16),
                      child: SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: SvgPicture.asset(
                          AppImages.envleop,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    validator: (String? val) {
                      return AppHeleperFunctions.validateEmail(val);
                    },
                  ),
                  AppTextField(
                    controller: password,
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 16.sp,
                    ),
                    suffixIconColor: ColorsManager.greyDarkColor,
                    hintText: "Password",
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    unFocusedBorderColor: ColorsManager.greyColor,
                    focusedBorderColor: ColorsManager.greyColor,
                    contentPadding: EdgeInsets.all(AppPadding.p10),
                    isDense: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(AppPadding.p16),
                      child: SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: SvgPicture.asset(
                          AppImages.lock,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    validator: (String? val) {
                      return AppHeleperFunctions.validatePassword(val);
                    },
                  ),
                  AppTextField(
                    controller: confirmPassword,
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 16.sp,
                    ),
                    suffixIconColor: ColorsManager.greyDarkColor,
                    hintText: "Confirm Password",
                    borderRadius: BorderRadius.circular(AppRadius.r10),
                    unFocusedBorderColor: ColorsManager.greyColor,
                    focusedBorderColor: ColorsManager.greyColor,
                    contentPadding: EdgeInsets.all(AppPadding.p10),
                    isDense: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(AppPadding.p16),
                      child: SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: SvgPicture.asset(
                          AppImages.lock,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    validator: (String? val) {
                      return AppHeleperFunctions.validateConfirmPassword(
                        val,
                        confirmPassword.text,
                      );
                    },
                  ),
                  Center(
                    child: AppButton(
                      height: 50.h,
                      label: "SignUp",
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          FireBaseAuthParam fireBaseAuthParam =
                              FireBaseAuthParam(
                                email: email.text,
                                password: password.text,
                              );

                          final userCredential = await cubit.register(
                            param: fireBaseAuthParam,
                          );

                          final uid = userCredential?.user?.uid ?? '';

                          FireBaseRegisterModel fireBaseRegisterModel =
                              FireBaseRegisterModel(
                                uid: uid,
                                name: name.text,
                                email: email.text,
                                createdAt: DateTime.now(),
                              );

                          await cubit.addUser(
                            fireBaseRegisterModel: fireBaseRegisterModel,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      listenWhen:
          (previous, current) =>
              current is FirebaseRegisterLoading ||
              current is FirebaseRegisterFailure ||
              current is FirebaseRegisterSuccess ||
              current is FirebaseAddUserLoading ||
              current is FirebaseAddUserFailure ||
              current is FirebaseAddUserSuccess,
      listener: (context, state) {
        if (state is FirebaseRegisterLoading) {
          FocusManager.instance.primaryFocus?.unfocus();
          AppLoading.loading(context);
        } else if (state is FirebaseRegisterSuccess) {
          Navigator.pop(context);
          name.clear();
          email.clear();
          password.clear();
          confirmPassword.clear();
        } else if (state is FirebaseRegisterFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is FirebaseAddUserSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User Created"),
              backgroundColor: Colors.red,
            ),
          );
          AppNavigator.push(context, AppRoutes.firbaseLoginScreen);
        }
      },
    );
  }
}
