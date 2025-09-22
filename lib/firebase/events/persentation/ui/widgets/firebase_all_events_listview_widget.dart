import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:bookingapp/firebase/events/persentation/cubit/firebase_events_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/widgets/app_cach_image.dart';
import 'package:flutter_svg/svg.dart';

class FirebaseAllEventsListviewWidget extends StatefulWidget {
  const FirebaseAllEventsListviewWidget({super.key});

  @override
  State<FirebaseAllEventsListviewWidget> createState() => _FirebaseAllEventsListviewWidgetState();
}

class _FirebaseAllEventsListviewWidgetState extends State<FirebaseAllEventsListviewWidget> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    FirebaseEventsCubit.of(context).getEvents();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = FirebaseEventsCubit.of(context);
    return BlocBuilder<FirebaseEventsCubit, FirebaseEventsState>(
      buildWhen:
          (previous, current) =>
              current is FirebaseEventsFailure ||
              current is FirebaseEventsSuccess ||
              current is FirebaseEventsLoading,

      builder: (context, state) {
        if (state is FirebaseEventsFailure) {
          return Center(child: AutoSizeText(state.message));
        } else if (state is FirebaseEventsSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              await cubit.getEvents(isRefresh: true);
            },
            child: ListView.separated(
              shrinkWrap: true,
              controller: scrollController,
              itemBuilder: (context, index) {
                return FirebaseAllEventsListviewCardWidget(
                  firebaseEventsModel: state.eventsList[index],
                  onTap: () {
                    AppNavigator.pushNamed(
                      context,
                      AppRoutes.firebaseEventDetailsScreen,
                      params: {
                        "id": state.eventsList[index].eventId.toString(),
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return AppSpace.vertical(AppHight.h10);
              },
              itemCount: state.eventsList.length,
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class FirebaseAllEventsListviewCardWidget extends StatelessWidget {
  final FirebaseEventsModel firebaseEventsModel;
  final void Function() onTap;

  const FirebaseAllEventsListviewCardWidget({
    super.key,

    required this.onTap,
    required this.firebaseEventsModel,
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
