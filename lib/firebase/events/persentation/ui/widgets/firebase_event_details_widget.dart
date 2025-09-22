import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
class FirebaseEventDetailsWidget extends StatelessWidget {
  const FirebaseEventDetailsWidget({
    super.key,
    required this.firebaseEventsModel,
  });
  final FirebaseEventsModel firebaseEventsModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      spacing: AppHight.h16,
      children: [
        FirebaseEventDetailsItemWidget(
          title: AppHeleperFunctions.formatEventDate(
            firebaseEventsModel.date,
            format: "d MMMM, yyyy",
          ),
          subtitle: AppHeleperFunctions.formatEventDate(
            firebaseEventsModel.date,
            format: "EEEE, h:mma",
          ),
          imageLink: AppImages.eventDate,
        ),
        FirebaseEventDetailsItemWidget(
          title: firebaseEventsModel.address,
          subtitle: firebaseEventsModel.addressTitle ?? '',
          imageLink: AppImages.eventLocation,
        ),
        FirebaseEventDetailsItemWidget(
          title: firebaseEventsModel.organizer.name,
          subtitle: "Organizer",
          imageLink: firebaseEventsModel.organizer.picture,
          isOrganizer: true,
        ),
      ],
    );
  }
}


class FirebaseEventDetailsItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageLink;
  final bool isOrganizer;

  const FirebaseEventDetailsItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageLink,
    this.isOrganizer = false,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppWidth.w14,
      children: [
        Container(
          width: AppWidth.fullWidth(context) * .2,
          height: AppHight.fullHight(context) * .1,
          padding:
              isOrganizer ? EdgeInsets.zero : EdgeInsets.all(AppPadding.p16),
          decoration: BoxDecoration(
            color: ColorsManager.lightPink,
            borderRadius: BorderRadius.circular(AppRadius.r12),
          ),
          child:
              isOrganizer
                  ? SvgPicture.asset("assets/images/person.svg")
                  : SvgPicture.asset(imageLink),
        ),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                title,
                style: TextStyles.font16Regular,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              AutoSizeText(
                subtitle, 
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.font14Regular.copyWith(
                  color: ColorsManager.greyColor,
                ),
              ),
            ],
          ),
        ),
        if (isOrganizer)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppWidth.w12,
              vertical: AppHight.h6,
            ),
            decoration: BoxDecoration(
              color: ColorsManager.lightPink,
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
            child: AutoSizeText(
              "Follow",
              style: TextStyles.font12Regular.copyWith(
                color: ColorsManager.mainColor,
              ),
            ),
          ),
      ],
    );
  }
}
