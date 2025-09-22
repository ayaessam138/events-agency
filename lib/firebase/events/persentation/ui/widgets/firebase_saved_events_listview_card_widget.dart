import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/core/widgets/app_cach_image.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SavedEventsListviewCardWidget extends StatelessWidget {
  final FirebaseEventsModel firebaseEventsModel;
  final void Function() onTap;

  const SavedEventsListviewCardWidget({
    super.key,
    required this.firebaseEventsModel,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        spacing: AppWidth.w16,
        children: [
          AppCacheImage(
            image: firebaseEventsModel.picture,
            isNotCircle: true,
            height: AppHight.fullHight(context) * .15,
            width: AppWidth.fullWidth(context) * .35,
          ),
          Expanded(
            child: Column(
              spacing: AppHight.h6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  AppHeleperFunctions.formatEventDate(firebaseEventsModel.date),
                  style: TextStyles.font14Regular.copyWith(
                    color: ColorsManager.mainColor,
                  ),
                ),
                AutoSizeText(
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  firebaseEventsModel.title,
                  style: TextStyles.font16Regular.copyWith(
                    color: ColorsManager.black,
                  ),
                ),
                Row(
                  spacing: AppWidth.w6,
                  children: [
                    SvgPicture.asset(AppImages.location),
                    Expanded(
                      child: AutoSizeText(
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        firebaseEventsModel.address,
                        style: TextStyles.font14Regular.copyWith(
                          color: ColorsManager.greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
