import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/core/widgets/app_cach_image.dart';
import 'package:bookingapp/api/organizer/domain/entity/organizer_entity.dart';
import 'package:flutter/material.dart';

class OrganizerEventsTab extends StatelessWidget {
     const OrganizerEventsTab({super.key, required this.organizerEntity});

    final OrganizerEntity organizerEntity;
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
                width: AppWidth.fullWidth(context)*.47,
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
                            organizerEntity.events![index].date ?? '',
                          ),
                        style: TextStyles.font12Regular.copyWith(
                          color: ColorsManager.mainColor,
                        ),
                      ),
                     AutoSizeText(
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,

                       
                          organizerEntity.events![index].title ?? '',
                        
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
