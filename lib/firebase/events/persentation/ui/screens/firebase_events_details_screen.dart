import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/routing/app_routes.dart';

import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/core/widgets/app_button.dart';
import 'package:bookingapp/core/widgets/app_cach_image.dart';
import 'package:bookingapp/api/events/persentation/controller/events_cubit.dart';
import 'package:bookingapp/firebase/events/persentation/cubit/firebase_events_cubit.dart';
import 'package:bookingapp/firebase/events/persentation/ui/widgets/firebase_event_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirebaseEventsDetailsScreen extends StatefulWidget {
  const FirebaseEventsDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<FirebaseEventsDetailsScreen> createState() =>
      _FirebaseEventsDetailsScreenState();
}

class _FirebaseEventsDetailsScreenState
    extends State<FirebaseEventsDetailsScreen> {
  @override
  void initState() {
    super.initState();
      final cubit = FirebaseEventsCubit.of(context);
  cubit.getEventsDetails(eventId: widget.id); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<FirebaseEventsCubit, FirebaseEventsState>(
            builder: (context, state) {
              if (state is NoInternet ||
                  state is EventsDetailsLoading ||
                  state is EventsDetailsError) {
                return SizedBox();
              }
              return Padding(
                padding: EdgeInsets.all(AppPadding.p20),
                child: AppButton(label: "Buy Ticket"),
              );
            },
          ),

      body: BlocBuilder<FirebaseEventsCubit, FirebaseEventsState>(
        buildWhen:
            (previous, current) =>
                current is FirebaseEventDetailsLoading ||
                current is FirebaseEventDetailsSuccess ||
                current is FirebaseEventsFailure,
        builder: (context, state) {
          var cubit = FirebaseEventsCubit.of(context);
          // var event = cubit.eventDeatilsEntity;
          if (state is FirebaseEventDetailsSuccess) {
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await cubit.getEventsDetails(eventId: widget.id);
                },
                child:
                    state is EventsDetailsLoading
                        ? Center(child: CircularProgressIndicator())
                        : NestedScrollView(
                          headerSliverBuilder: (
                            BuildContext context,
                            bool innerBoxIsScrolled,
                          ) {
                            return [
                              SliverOverlapAbsorber(
                                handle:
                                    NestedScrollView.sliverOverlapAbsorberHandleFor(
                                      context,
                                    ),
                                sliver: SliverAppBar(
                                  pinned: true,
                                  automaticallyImplyLeading: false,
                                  floating: false,
                                  elevation: 0,

                                  // Expanded height of app bar
                                  expandedHeight:
                                      AppHight.fullHight(context) * .4,

                                  // 👇 important: set a solid background color
                                  backgroundColor: Colors.white,

                                  flexibleSpace: FlexibleSpaceBar(
                                    collapseMode: CollapseMode.none,
                                    background: Stack(
                                      children: [
                                        /// Event main image
                                        AppCacheImage(
                                          boxFit: BoxFit.cover,

                                          // 👇 match expandedHeight so no gap appears
                                          height:
                                              AppHight.fullHight(context) * .4,
                                          width: AppWidth.fullWidth(context),
                                          image: state.eventsModel.picture,
                                          isNotCircle: true,
                                        ),

                                        /// Top bar (Back + Title + Bookmark)
                                        Positioned(
                                          top:
                                              AppHight.fullHight(context) * .04,
                                          right:
                                              AppWidth.fullWidth(context) * .02,
                                          left:
                                              AppWidth.fullWidth(context) * .02,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                spacing: AppWidth.w10,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.arrow_back_sharp,
                                                      size: 24.sp,
                                                      color:
                                                          ColorsManager.white,
                                                    ),
                                                  ),
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth:
                                                          AppWidth.fullWidth(
                                                            context,
                                                          ) *
                                                          0.5,
                                                    ),
                                                    child: AutoSizeText(
                                                      "Event Details",
                                                      maxLines: 1,
                                                      style: TextStyles
                                                          .font24Medium
                                                          .copyWith(
                                                            color:
                                                                ColorsManager
                                                                    .white,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(
                                                  AppPadding.p8,
                                                ),
                                                height:
                                                    AppHight.fullHight(
                                                      context,
                                                    ) *
                                                    .07,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        12.r,
                                                      ),
                                                  color: ColorsManager
                                                      .greyButtonColor
                                                      .withOpacity(0.6),
                                                ),
                                                child: Icon(
                                                  Icons.bookmark,
                                                  size: 24.sp,
                                                  color: ColorsManager.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        /// Organizer mini profile
                                        Positioned(
                                          top:
                                              AppHight.fullHight(context) * .32,
                                          left: 0,
                                          right: 0,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                AppPadding.p10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: ColorsManager.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        ColorsManager.greyColor,
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(50.r),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  AppNavigator.pushNamed(
                                                    context,
                                                    AppRoutes.firebaseOrganizerScreen,
                                                    params: {
                                                      "id":
                                                          state
                                                              .eventsModel
                                                              .organizer
                                                              .id
                                                              .toString(),
                                                    },
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  spacing: AppWidth.w10,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: AppRadius.r14,
                                                      backgroundImage:
                                                          NetworkImage(
                                                            state
                                                                .eventsModel
                                                                .organizer
                                                                .picture,
                                                          ),
                                                    ),
                                                    Flexible(
                                                      child: AutoSizeText(
                                                        state
                                                            .eventsModel
                                                            .numberOfGoing
                                                            .toString(),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style: TextStyles
                                                            .font12Medium
                                                            .copyWith(
                                                              color:
                                                                  ColorsManager
                                                                      .mainColor,
                                                            ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal:
                                                                AppWidth.w16,
                                                            vertical:
                                                                AppHight.h6,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            ColorsManager
                                                                .mainColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              AppRadius.r12,
                                                            ),
                                                      ),
                                                      child: AutoSizeText(
                                                        "Invite",
                                                        style: TextStyles
                                                            .font12Regular
                                                            .copyWith(
                                                              color:
                                                                  ColorsManager
                                                                      .white,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ];
                          },
                          body: Builder(
                            builder: (context) {
                              return CustomScrollView(
                                slivers: [
                                  SliverOverlapInjector(
                                    handle:
                                        NestedScrollView.sliverOverlapAbsorberHandleFor(
                                          context,
                                        ),
                                  ),
                                  SliverPadding(
                                    padding: EdgeInsets.all(AppPadding.p16),
                                    sliver: SliverList(
                                      delegate: SliverChildListDelegate([
                                        AutoSizeText(
                                          state.eventsModel.title,
                                          style: TextStyles.font35Regular,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        FirebaseEventDetailsWidget(
                                          firebaseEventsModel:
                                              state.eventsModel,
                                        ),
                                        AutoSizeText(
                                          "AboutEvent",
                                          style: TextStyles.font18Medium,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          state.eventsModel.aboutEvent ??
                                              'Women Leadership Conference 2021',
                                          style: TextStyles.font16Regular,
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
              ),
            );
          } else if (state is FirebaseEventDetailFailure) {
            return AutoSizeText(
              state.message,
              style: TextStyles.font18Regular,
              maxLines: 1,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
