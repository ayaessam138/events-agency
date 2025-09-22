import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/edit_profile_button_widget.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/edit_profile_textfileds_widget.dart';
import 'package:bookingapp/firebase/profile/data/models/firebase_profile_model.dart';
import 'package:bookingapp/firebase/profile/persentation/cubit/firebase_profile_cubit.dart';
import 'package:bookingapp/firebase/profile/persentation/ui/widget/firebase_edit_profile_textfields_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/app_values.dart';
import '../../../../../core/theming/colors.dart';

class FirebaseEditProfileScreen extends StatelessWidget {
  const FirebaseEditProfileScreen({
    super.key,
    required this.firebaseProfileModel,
  });
  final FirebaseProfileModel firebaseProfileModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(color: ColorsManager.white),

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
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              /// Content Section
              FirebaseEditProfileTextfieldsWidget(
                firebaseProfileModel: firebaseProfileModel,
              ),

           
            ],
          ),
        ),
      ),
    );
  }
}
