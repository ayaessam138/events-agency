import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_const.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/localstorage/app_local_storage.dart';
import 'package:bookingapp/core/models/firebase_auth_param.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/core/widgets/app_button.dart';
import 'package:bookingapp/core/widgets/app_text_field.dart';
import 'package:bookingapp/firebase/login/persentation/cubit/firebase_login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class FirebaseLoginTextFields extends StatefulWidget {
  const FirebaseLoginTextFields({super.key});

  @override
  _FirebaseLoginTextFieldsState createState() =>
      _FirebaseLoginTextFieldsState();
}

class _FirebaseLoginTextFieldsState extends State<FirebaseLoginTextFields> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isSwitched = true;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: AppHight.h15,
        children: [
          AppTextField(
            controller: emailController,
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
                child: SvgPicture.asset(AppImages.envleop, fit: BoxFit.fill),
              ),
            ),
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return "Email cannot be empty";
              }
              return null;
            },
          ),

          AppTextField(
            controller: passwordController,
            obscureText: _isObscure,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                size: 16.sp,
              ),
            ),
            suffixIconColor: ColorsManager.greyDarkColor,
            hintText: "Your Password",
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
                child: SvgPicture.asset(AppImages.lock, fit: BoxFit.fill),
              ),
            ),
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return "Password cannot be empty";
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeColor: ColorsManager.white,
                      activeTrackColor: ColorsManager.mainColor,
                      inactiveTrackColor: ColorsManager.greyColor,
                    ),
                    Flexible(
                      child: AutoSizeText(
                        "Remember Me",
                        style: TextStyles.font14Regular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: AutoSizeText(
                  "Forgot Password?",
                  style: TextStyles.font14Regular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Center(
            child: BlocConsumer<FirebaseLoginCubit, FirebaseLoginState>(
              buildWhen:
                  (previous, current) =>
                      current is FirebaseLoginLoading ||
                      current is FirebaseLoginSuccess ||
                      current is FirebaseLoginFailure,
              builder: (context, state) {
                var cubit =FirebaseLoginCubit.get;
                return AppButton(
                  label: 'Sign In',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      FireBaseAuthParam param = FireBaseAuthParam(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      await cubit.login(param: param);
                    }
                  },
                  height: 50.h,
                );
              },
              listener: (BuildContext context, FirebaseLoginState state) {
                if (state is FirebaseLoginSuccess) {
                  AppNavigator.go(
                    context,
                    AppRoutes.firbasebottomNavBarScreen,
                  );
                  AppHiveLocalStorage.saveBool(AppSavedKey.userLOgin, true, Hive.box(AppSavedKey.userLOgin));
                } else if (state is FirebaseLoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
