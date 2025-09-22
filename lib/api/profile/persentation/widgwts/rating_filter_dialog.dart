import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/edit_profile_button_widget.dart';
import 'package:bookingapp/api/profile/persentation/widgwts/rating_app_widget.dart';
import 'package:flutter/material.dart';


void showBottomSheetRating(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.r20)),
    ),
    backgroundColor: ColorsManager.white,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.all(AppPadding.p12),
            child: Column(
              spacing: AppHight.h16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        "Rating",
                        style: TextStyles.font18Bold,
                        maxLines: 1,

                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),

                RatingAppWidget(),
                SaveButton(
                  title: "Apply Now",
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
