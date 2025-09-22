import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_const.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/helpers/functions.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/core/widgets/app_cach_image.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:bookingapp/firebase/events/persentation/cubit/firebase_events_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

class FiebaseHomeEventsListWidget extends StatefulWidget {
  const FiebaseHomeEventsListWidget({super.key});

  @override
  State<FiebaseHomeEventsListWidget> createState() =>
      _FiebaseHomeEventsListWidgetState();
}

class _FiebaseHomeEventsListWidgetState
    extends State<FiebaseHomeEventsListWidget> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    FirebaseEventsCubit.of(context).getEvents();
  }

  final Box<FirebaseEventsModel> bookmarkedBox = Hive.box<FirebaseEventsModel>(
    AppSavedKey.firebasesavedEvents,
  );
  Future<void> toggleBookmark(FirebaseEventsModel event) async {
    if (bookmarkedBox.containsKey(event.eventId)) {
      await bookmarkedBox.delete(event.eventId);
    } else {
      //bec it is aleady saved in another box and hive do not allow saving same obj even in two diff boxxe
      final freshEvent = FirebaseEventsModel(
        eventId: event.eventId,
        picture: event.picture,
        date: event.date,
        title: event.title,
        address: event.address,
        numberOfGoing: event.numberOfGoing,
        organizer: FirebaseOrganizerModel(
          id: event.organizer.id,
          name: event.organizer.name,
          picture: event.organizer.picture,
        ),
      );

      await bookmarkedBox.put(event.eventId, freshEvent);
    }

    setState(() {});
  }

  bool isBookmarked(String eventId) {
    return bookmarkedBox.containsKey(eventId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirebaseEventsCubit, FirebaseEventsState>(
      buildWhen:
          (previous, current) =>
              current is FirebaseEventsLoading ||
              current is FirebaseEventsFailure ||
              current is FirebaseEventsSuccess,
      builder: (context, state) {
        if (state is FirebaseEventsSuccess) {
          return SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(state.eventsList.length, (index) {
                return GestureDetector(
                  onLongPress: () {
                    //FirebaseHomeCubit.get.shareEventWithImage(eventsList[index]);
                  },

                  onTap: () {
                    print("eventid ");
                    print(state.eventsList[index].eventId.toString());
                    AppNavigator.pushNamed(
                      context,
                      AppRoutes.firebaseEventDetailsScreen,
                      params: {
                        "id": state.eventsList[index].eventId.toString(),
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: AppPadding.p16),
                    child: Container(
                      margin: EdgeInsets.all(4.sp),
                      padding: EdgeInsets.all(AppPadding.p10),
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(AppRadius.r12),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.greyColor.withOpacity(0.1),
                            spreadRadius: 0.3,
                            blurRadius: 30,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      width: AppWidth.fullWidth(context) * .7,

                      child: Column(
                        spacing: AppHight.h3,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              AppCacheImage(
                                boxFit: BoxFit.cover,
                                width: AppWidth.fullWidth(context),
                                height: AppHight.fullHight(context) * .2,
                                image: state.eventsList[index].picture,
                                isNotCircle: true,
                              ),

                              Padding(
                                padding: EdgeInsets.all(AppPadding.p8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: AppHight.fullHight(context) * .11,
                                      padding: EdgeInsets.all(AppPadding.p8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        color: ColorsManager.lightPink,
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      AppWidth.fullWidth(
                                                        context,
                                                      ) *
                                                      0.25,
                                                ),
                                                child: AutoSizeText(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,

                                                  AppHeleperFunctions.formatEventDate(
                                                    state
                                                        .eventsList[index]
                                                        .date,
                                                    format: 'd MMMM',
                                                  ).split(" ")[0],
                                                  style: TextStyles.font18Bold
                                                      .copyWith(
                                                        color:
                                                            ColorsManager.pink,
                                                      ),
                                                ),
                                              ),
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      AppWidth.fullWidth(
                                                        context,
                                                      ) *
                                                      0.25,
                                                ),
                                                child: AutoSizeText(
                                                  maxLines: 1,

                                                  AppHeleperFunctions.formatEventDate(
                                                    state
                                                        .eventsList[index]
                                                        .date,
                                                    format: 'd MMMM',
                                                  ).split(" ")[1],
                                                  style: TextStyles.font18Bold
                                                      .copyWith(
                                                        color:
                                                            ColorsManager.pink,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await toggleBookmark(
                                          state.eventsList[index],
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(AppPadding.p8),
                                        height:
                                            AppHight.fullHight(context) * .07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          color: ColorsManager.lightPink,
                                        ),
                                        child: Icon(
                                          isBookmarked(
                                                state.eventsList[index].eventId,
                                              )
                                              ? Icons.bookmark
                                              : Icons.bookmark_border,
                                          size: 24.sp,
                                          color: ColorsManager.pink,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          AppSpace.vertical(AppHight.h6),
                          AutoSizeText(
                            state.eventsList[index].title,
                            style: TextStyles.font18Medium.copyWith(
                              color: ColorsManager.black,
                            ),
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            spacing: AppWidth.w10,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // AppNavigator.pushNamed(
                                  //   context,
                                  //   AppRoutes.organizerScreen,
                                  //   params: {
                                  //     "id":
                                  //         eventsList[index].organizer.id
                                  //             .toString(),
                                  //   },
                                  // );
                                },
                                child: CircleAvatar(
                                  radius: AppRadius.r14,
                                  backgroundImage: NetworkImage(
                                    state.eventsList[index].organizer.picture,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  '${state.eventsList[index].numberOfGoing} Going',

                                  style: TextStyles.font12Medium.copyWith(
                                    color: ColorsManager.mainColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: AppWidth.w10,
                            children: [
                              SvgPicture.asset(AppImages.location),
                              Flexible(
                                child: AutoSizeText(
                                  state.eventsList[index].address,

                                  style: TextStyles.font14Regular.copyWith(
                                    color: ColorsManager.greyColor,
                                  ),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }
        if (state is FirebaseEventsFailure) {
          return SizedBox(
            height: AppHight.fullHight(context) * .35,
            child: Center(child: AutoSizeText(state.message)),
          );
        } else {
          return SizedBox(
            height: AppHight.fullHight(context) * .35,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
