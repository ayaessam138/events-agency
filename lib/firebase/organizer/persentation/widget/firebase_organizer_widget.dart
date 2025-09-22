import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/colors.dart' show ColorsManager;
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FireBaseOrganizerboutTab extends StatelessWidget {
  const FireBaseOrganizerboutTab({super.key, required this.organizerEntity});
  final FirebaseOrganizerModel organizerEntity;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p20),
        child: RichText(
          text: TextSpan(
            style: TextStyles.font16Regular.copyWith(
              color: Colors.black,
            ), // Default text style
            children: [
              TextSpan(text: organizerEntity.about),
              TextSpan(
                text: "Read More",
                style: TextStyles.font16Regular.copyWith(
                  color: ColorsManager.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirebaseOrganizerEventsTab extends StatelessWidget {
  const FirebaseOrganizerEventsTab({super.key, required this.organizerEntity});

  final FirebaseOrganizerModel organizerEntity;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(AppPadding.p16),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(AppPadding.p12),
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(AppRadius.r14),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.greyColor,
                spreadRadius: 1,
                blurRadius: 25,
                offset: Offset(0, 10),
              ),
            ],
          ),

          child: Row(
            spacing: AppWidth.w20,
            children: [
              Image.asset(
                "assets/images/event.png",
                fit: BoxFit.cover,
                width: AppWidth.fullWidth(context) * .47,
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppHight.h20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        AppHeleperFunctions.formatEventDate(
                          organizerEntity.events![index].date ,
                        ),
                        style: TextStyles.font12Regular.copyWith(
                          color: ColorsManager.mainColor,
                        ),
                      ),
                      AutoSizeText(
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,

                        organizerEntity.events![index].title,

                        style: TextStyles.font18Regular.copyWith(
                          color: ColorsManager.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return AppSpace.vertical(AppHight.h12);
      },
      itemCount: organizerEntity.events?.length ?? 0,
    );
  }
}

class FirebaseOriganizerReviewTab extends StatelessWidget {
  const FirebaseOriganizerReviewTab({super.key, required this.organizerEntity});
  final FirebaseOrganizerModel organizerEntity;
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
