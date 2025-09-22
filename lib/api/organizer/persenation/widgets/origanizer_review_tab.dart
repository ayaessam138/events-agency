import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/api/organizer/domain/entity/organizer_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OriganizerReviewTab extends StatelessWidget {
 
   const OriganizerReviewTab({super.key, required this.organizerEntity});
     final OrganizerEntity organizerEntity;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(AppPadding.p16),
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppWidth.w10,
          children: [
            CircleAvatar(
              maxRadius: AppRadius.r20,
              backgroundImage: NetworkImage("assets/images/event.png"),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                            organizerEntity.reviews![index].reviewerName ?? '',
                      
                          style: TextStyles.font18Medium,
                        ),
                      ),
                      Flexible(
                        child: AutoSizeText(
                            AppHeleperFunctions.formatEventDate(
                              organizerEntity.reviews![index].reviewDate ?? '',
                              format: 'd MMMM',
                            ),
                    
                          style: TextStyles.font16Regular.copyWith(
                            color: ColorsManager.greyColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  RatingBar.builder(
                    ignoreGestures: true,
                    initialRating:
                          organizerEntity.reviews![index].rate!.toDouble(),
                     
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 4,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder:
                        (context, _) =>
                            Icon(Icons.star, color: ColorsManager.yellow),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  AutoSizeText(
                      organizerEntity.reviews![index].review ?? '',
                 
                    style: TextStyles.font16Regular.copyWith(
                      color: ColorsManager.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return AppSpace.vertical(AppHight.h15);
      },
       itemCount: organizerEntity.reviews?.length ?? 0,

    );
  }
}
