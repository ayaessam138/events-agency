import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/core/widgets/app_cach_image.dart';
import 'package:bookingapp/feature/events/domain/entity/events_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventsListviewCard extends StatelessWidget {
  final EventsEntity eventsEntity;
  final void Function() onTap;

  const EventsListviewCard({
    super.key,
    required this.eventsEntity,
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
            image: eventsEntity.picture,
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
                  AppHeleperFunctions.formatEventDate(eventsEntity.date),
                  style: TextStyles.font14Regular.copyWith(
                    color: ColorsManager.mainColor,
                  ),
                ),
                AutoSizeText(
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  eventsEntity.title,
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
                        eventsEntity.address,
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
