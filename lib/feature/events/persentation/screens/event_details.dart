import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/routing/app_routes.dart';

import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/core/widgets/app_button.dart';
import 'package:bookingapp/core/widgets/app_cach_image.dart';
import 'package:bookingapp/feature/events/persentation/controller/events_cubit.dart';
import 'package:bookingapp/feature/events/persentation/widgets/event_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class EventDetails extends StatefulWidget {
//   const EventDetails({super.key, required this.id});
//   final String id;

//   @override
//   State<EventDetails> createState() => _EventDetailsState();
// }

// class _EventDetailsState extends State<EventDetails> {
//   @override
//   void initState() {
//     super.initState();
//     EventsCubit.of(context).getEventDeatils(id: widget.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BlocBuilder<EventsCubit, EventsState>(
//         builder: (context, state) {
//           if (state is NoInternet || state is EventsDetailsLoading|| state is EventsDetailsError) {
//             return SizedBox();
//           }
//           return Padding(
//             padding: EdgeInsets.all(AppPadding.p20),
//             child: AppButton(label: "Buy Ticket"),
//           );
//         },
//       ),

//       body: BlocBuilder<EventsCubit, EventsState>(
//         buildWhen:
//             (previous, current) =>
//                 current is EventsDetailsError ||
//                 current is EventsDetailsLoading ||
//                 current is EventsDetailsSuccess ||
//                 current is NoInternet,
//         builder: (context, state) {
//           var cubit = EventsCubit.of(context);
//           var event = cubit.eventDeatilsEntity;

//           return SafeArea(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 await cubit.getEventDeatils(id: widget.id, isRefresh: true);
//               },
//               child:
//                   state is EventsDetailsLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : state is NoInternet
//                       ? Center(
//                         child: AutoSizeText(
//                           "Check your Internet Connection Please",
//                           style: TextStyles.font16Bold,
//                         ),
//                       )
//                       : SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: AppHight.fullHight(context) * .4,
//                               child: Stack(
//                                 children: [
//                                   AppCacheImage(
//                                     boxFit: BoxFit.cover,
//                                     height: AppHight.fullHight(context) * .35,
//                                     width: AppWidth.fullWidth(context),
//                                     image: event.picture ?? "",
//                                     isNotCircle: true,
//                                   ),

//                                   Positioned(
//                                     top: AppHight.fullHight(context) * .04,
//                                     right: AppWidth.fullWidth(context) * .02,
//                                     left: AppWidth.fullWidth(context) * .02,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           spacing: AppWidth.w10,
//                                           children: [
//                                             IconButton(
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               icon: Icon(
//                                                 Icons.arrow_back_sharp,
//                                                 size: 24.sp,
//                                                 color: ColorsManager.white,
//                                               ),
//                                             ),
//                                             ConstrainedBox(
//                                               constraints: BoxConstraints(
//                                                 maxWidth:
//                                                     AppWidth.fullWidth(
//                                                       context,
//                                                     ) *
//                                                     0.5,
//                                               ),
//                                               child: AutoSizeText(
//                                                 "Event Deatils",
//                                                 maxLines: 1,
//                                                 style: TextStyles.font24Medium
//                                                     .copyWith(
//                                                       color:
//                                                           ColorsManager.white,
//                                                     ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Container(
//                                           padding: EdgeInsets.all(
//                                             AppPadding.p8,
//                                           ),
//                                           height:
//                                               AppHight.fullHight(context) * .07,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               12.r,
//                                             ),
//                                             color: ColorsManager.greyButtonColor
//                                                 .withOpacity(0.6),
//                                           ),
//                                           child: Icon(
//                                             Icons.bookmark,
//                                             size: 24.sp,
//                                             color: ColorsManager.white,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: AppHight.fullHight(context) * .32,
//                                     left: 0,
//                                     right: 0,
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Container(
//                                         padding: EdgeInsets.all(AppPadding.p10),
//                                         decoration: BoxDecoration(
//                                           color: ColorsManager.white,
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: ColorsManager.greyColor,
//                                               spreadRadius: 1,
//                                               blurRadius: 25,
//                                               offset: Offset(0, 10),
//                                             ),
//                                           ],
//                                           borderRadius: BorderRadius.circular(
//                                             50.r,
//                                           ),
//                                         ),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             AppNavigator.pushNamed(
//                                               context,
//                                               AppRoutes.organizerScreen,
//                                             );
//                                           },
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             spacing: AppWidth.w10,
//                                             children: [
//                                               CircleAvatar(
//                                                 radius: AppRadius.r14,
//                                                 backgroundImage: NetworkImage(
//                                                   event.organizer?.picture ??
//                                                       '',
//                                                 ),
//                                               ),
//                                               Flexible(
//                                                 child: AutoSizeText(
//                                                   event.numberOfGoing
//                                                       .toString(),

//                                                   maxLines: 1,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: TextStyles.font12Medium
//                                                       .copyWith(
//                                                         color:
//                                                             ColorsManager
//                                                                 .mainColor,
//                                                       ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                   horizontal: AppWidth.w16,
//                                                   vertical: AppHight.h6,
//                                                 ),
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                       ColorsManager.mainColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                         AppRadius.r12,
//                                                       ),
//                                                 ),
//                                                 child: AutoSizeText(
//                                                   "Invite",
//                                                   style: TextStyles
//                                                       .font12Regular
//                                                       .copyWith(
//                                                         color:
//                                                             ColorsManager.white,
//                                                       ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(AppPadding.p16),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 spacing: AppHight.h16,
//                                 children: [
//                                   AutoSizeText(
//                                     event.title ?? '',

//                                     style: TextStyles.font35Regular,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   EventDeatailsWidget(
//                                     eventDeatilsEntity: event,
//                                   ),
//                                   AutoSizeText(
//                                     "AboutEvent",
//                                     style: TextStyles.font18Medium,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   AutoSizeText(
//                                     event.aboutEvent ??
//                                         'Women Leadership Conference 2021',
//                                     style: TextStyles.font16Regular,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
class EventDetails extends StatefulWidget {
  const EventDetails({super.key, required this.id});
  final String id;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  void initState() {
    super.initState();
    EventsCubit.of(context).getEventDeatils(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<EventsCubit, EventsState>(
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

      body: BlocBuilder<EventsCubit, EventsState>(
        buildWhen:
            (previous, current) =>
                current is EventsDetailsError ||
                current is EventsDetailsLoading ||
                current is EventsDetailsSuccess ||
                current is NoInternet,
        builder: (context, state) {
          var cubit = EventsCubit.of(context);
          var event = cubit.eventDeatilsEntity;

          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await cubit.getEventDeatils(id: widget.id, isRefresh: true);
              },
              child:
                  state is EventsDetailsLoading
                      ? Center(child: CircularProgressIndicator())
                      : state is NoInternet
                      ? Center(
                        child: AutoSizeText(
                          "Check your Internet Connection Please",
                          style: TextStyles.font16Bold,
                        ),
                      )
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
                                        image: event.picture ?? "",
                                        isNotCircle: true,
                                      ),

                                      /// Top bar (Back + Title + Bookmark)
                                      Positioned(
                                        top: AppHight.fullHight(context) * .04,
                                        right:
                                            AppWidth.fullWidth(context) * .02,
                                        left: AppWidth.fullWidth(context) * .02,
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
                                                    color: ColorsManager.white,
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
                                                  AppHight.fullHight(context) *
                                                  .07,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
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
                                        top: AppHight.fullHight(context) * .32,
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
                                                  AppRoutes.organizerScreen,
                                                  params: {
                                                    "id":
                                                        event.organizer!.id
                                                            .toString(),
                                                  },
                                                );
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                spacing: AppWidth.w10,
                                                children: [
                                                  CircleAvatar(
                                                    radius: AppRadius.r14,
                                                    backgroundImage:
                                                        NetworkImage(
                                                          event
                                                                  .organizer
                                                                  ?.picture ??
                                                              '',
                                                        ),
                                                  ),
                                                  Flexible(
                                                    child: AutoSizeText(
                                                      event.numberOfGoing
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                          vertical: AppHight.h6,
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
                        body: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(AppPadding.p16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: AppHight.h16,
                              children: [
                                /// Event title
                                AutoSizeText(
                                  event.title ?? '',
                                  style: TextStyles.font35Regular,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                /// Event info widget
                                EventDeatailsWidget(eventDeatilsEntity: event),

                                /// About section
                                AutoSizeText(
                                  "AboutEvent",
                                  style: TextStyles.font18Medium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                AutoSizeText(
                                  event.aboutEvent ??
                                      'Women Leadership Conference 2021',
                                  style: TextStyles.font16Regular,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
            ),
          );
        },
      ),
    );
  }
}
