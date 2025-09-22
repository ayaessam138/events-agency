import 'package:bookingapp/api/profile/persentation/widgwts/edit_profile_button_widget.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/firebase/profile/data/models/firebase_profile_model.dart';
import 'package:bookingapp/firebase/profile/persentation/cubit/firebase_profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_values.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/app_text_field.dart';

class FirebaseEditProfileTextfieldsWidget extends StatefulWidget {
  const FirebaseEditProfileTextfieldsWidget({
    super.key,
    required this.firebaseProfileModel,
  });

  final FirebaseProfileModel firebaseProfileModel;

  @override
  State<FirebaseEditProfileTextfieldsWidget> createState() =>
      _FirebaseEditProfileTextfieldsWidgetState();
}

class _FirebaseEditProfileTextfieldsWidgetState
    extends State<FirebaseEditProfileTextfieldsWidget> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.firebaseProfileModel.name,
    );
    emailController = TextEditingController(
      text: widget.firebaseProfileModel.email,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppWidth.w16,
            vertical: AppHight.h10,
          ),
          child: Column(
            spacing: AppHight.h12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpace.vertical(AppHight.h25),

              /// Full Name
              AppTextField(
                controller: nameController,
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
                hintText: "Full name",
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: ColorsManager.lightGreyColor,
                ),
                validator: (String? value) {
                  return AppHeleperFunctions.validateFullName(value);
                },
              ),

              /// Email
              AppTextField(
                controller: emailController,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p8,
                    vertical: AppPadding.p12,
                  ),
                  child: Icon(Icons.email, color: ColorsManager.lightGreyColor),
                ),
                hintText: "Email",
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: ColorsManager.lightGreyColor,
                ),
                validator: (String? value) {
                  return AppHeleperFunctions.validateFullName(value);
                },
              ),
              AppSpace.vertical(AppHight.h24),
              BlocConsumer<FirebaseProfileCubit, FirebaseProfileState>(
                listener: (context, state) {
                  if (state is FirebaseUpdateProfileSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("User Updated!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    Navigator.pop(context, true);
            
                  }
                  if (state is FirebaseUpdateProfileFail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                    
                  }
                },
                builder: (context, state) {
                  return state is FirebaseProfileLoading
                      ? Center(child: CircularProgressIndicator())
                      : SaveButton(
                        title: "Save Now",
                        onTap: () async {
                          final updatedProfile = FirebaseProfileModel(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                            name: nameController.text,
                            email: emailController.text,
                          );

                          await FirebaseProfileCubit.of(
                            context,
                          ).updateUserProfile(
                            firebaseProfileModel: updatedProfile,
                            currentUserId:
                                FirebaseAuth.instance.currentUser!.uid,
                          );
                        },
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
