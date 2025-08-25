import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/feature/organizer/persenation/controller/organizer_cubit.dart';
import 'package:bookingapp/feature/organizer/persenation/widgets/organizer_about_tab.dart';
import 'package:bookingapp/feature/organizer/persenation/widgets/organizer_action_button.dart';
import 'package:bookingapp/feature/organizer/persenation/widgets/organizer_events_tab.dart';
import 'package:bookingapp/feature/organizer/persenation/widgets/origanizer_review_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizerScreen extends StatefulWidget {

   const OrganizerScreen({super.key, required this.id});
    final String id;

  @override
  State<OrganizerScreen> createState() => _OrganizerScreenState();
}

class _OrganizerScreenState extends State<OrganizerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
      OrganizerCubit.of(context).getOrganizerDeatils(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: BlocBuilder<OrganizerCubit, OrganizerState>(
        buildWhen:
            (previous, current) =>
                current is OrganizerDetailsError ||
                current is OrganizerDetailsLoading ||
                current is OrganizerDetailsSuccess ||
                current is NoInternet,
        builder: (context, state) {
             var cubit = OrganizerCubit.of(context);

          if (state is OrganizerDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NoInternet) {
            return Center(
              child: AutoSizeText(
                "Check your Internet Connection Please",
                style: TextStyles.font16Bold,
              ),
            );
          }

          return NestedScrollView(
            headerSliverBuilder:
                (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    surfaceTintColor: Colors.transparent,
                    pinned: true,
                    floating: false,
                    elevation: 0,
                    expandedHeight: AppHight.fullHight(context)*.45, 
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppWidth.w12 ,vertical: AppHight.h12),
                        child: Column(
                          spacing: AppHight.h10,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          
                            CircleAvatar(
                              radius: AppRadius.r35,
                              
                                 backgroundImage: NetworkImage(
                                  cubit.organizerEntity.picture ?? '',
                                ),
                            ),
                            AutoSizeText(
                                 cubit.organizerEntity.name ?? '',
                          
                              style: TextStyles.font24Regular,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              spacing:  AppWidth.w25,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    AutoSizeText(
                                        '${cubit.organizerEntity.numberOfFollowing ?? ''}',
                                  
                                      style: TextStyles.font16Medium,
                                    ),
                                    AutoSizeText(
                                      "Following",
                                      style: TextStyles.font14Regular.copyWith(
                                        color: ColorsManager.greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                               
                                Column(
                                  children: [
                                    AutoSizeText(
                                        '${cubit.organizerEntity.numberOfFollowers ?? ''}',
                                  
                                      style: TextStyles.font16Medium,
                                    ),
                                    AutoSizeText(
                                      "Followers",
                                      style: TextStyles.font14Regular.copyWith(
                                        color: ColorsManager.greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              spacing: AppWidth.w10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: OrganizerActionButton(
                                    textColor: ColorsManager.white,
                                    buttonColor: ColorsManager.mainColor,
                                    borderColor: Colors.transparent,
                                    buttonLabel: 'Follow',
                                    image: AppImages.follow,
                                  ),
                                ),
                          
                                Expanded(
                                  child: OrganizerActionButton(
                                    textColor: ColorsManager.mainColor,
                                    buttonColor: ColorsManager.white,
                                    borderColor: ColorsManager.mainColor,
                                    buttonLabel: 'Messages',
                                    image: AppImages.message,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
             
                  ),
                ],
            body: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: ColorsManager.mainColor,
                  unselectedLabelColor: ColorsManager.greyColor,
                  indicatorColor: ColorsManager.mainColor,
                  labelStyle: TextStyles.font16Medium,
                  tabs: const [
                    Tab(text: "ABOUT"),
                    Tab(text: "EVENT"),
                    Tab(text: "REVIEW"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children:  [
                 
                        OrganizerboutTab(
                          organizerEntity: cubit.organizerEntity,
                        ),
                        OrganizerEventsTab(
                          organizerEntity: cubit.organizerEntity,
                        ),
                        OriganizerReviewTab(
                          organizerEntity: cubit.organizerEntity,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

  // class OrganizerScreen extends StatefulWidget {
  //   const OrganizerScreen({super.key});
  //    const OrganizerScreen({super.key, required this.id});
  //     final String id;
  //   @override
  //   State<OrganizerScreen> createState() => _OrganizerScreenState();
  // }

  // class _OrganizerScreenState extends State<OrganizerScreen>
  //     with SingleTickerProviderStateMixin {
  //   late TabController _tabController;

  //   @override
  //   void initState() {
  //     super.initState();
  //     _tabController = TabController(length: 3, vsync: this);
  //       OrganizerCubit.of(context).getOrganizerDeatils(id: widget.id);
  //   }

  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         surfaceTintColor: Colors.transparent,
  //         leading: IconButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           icon: Icon(Icons.arrow_back_sharp, size: 24.sp),
  //         ),
  //         actions: [Icon(Icons.more_vert, size: 24.sp)],
  //       ),

  //       body: BlocBuilder<OrganizerCubit, OrganizerState>(
  //         buildWhen:
  //             (previous, current) =>
  //                 current is OrganizerDetailsError ||
  //                 current is OrganizerDetailsLoading ||
  //                 current is OrganizerDetailsSuccess ||
  //                 current is NoInternet,
  //         builder: (context, state) {
  //              var cubit = OrganizerCubit.of(context);
  //           return state is OrganizerDetailsLoading
  //               ? Center(child: CircularProgressIndicator())
  //               : state is NoInternet
  //               ? Center(
  //                 child: AutoSizeText(
  //                   "Check your Internet Connection Please",
  //                   style: TextStyles.font16Bold,
  //                 ),
  //               )
  //               : Center(
  //                 child: RefreshIndicator(
  //                   onRefresh: () async {
  //                       await cubit.getOrganizerDeatils(
  //                         id: widget.id,
  //                         isRefresh: true,
  //                       );
  //                   },
  //                   child: SingleChildScrollView(
  //                     child: SizedBox(
  //                       height: AppHight.fullHight(context),
  //                       child: Column(
  //                         spacing: AppHight.h20,
  //                         children: [
  //                           Padding(
  //                             padding:  EdgeInsets.symmetric(horizontal: AppWidth.w12),
  //                             child: Column(  spacing: AppHight.h20,
  //                               children: [
  //                                 AppSpace.vertical(AppHight.h20),
  //                                 CircleAvatar(
  //                                   radius: AppRadius.r35,
  //                                   backgroundImage: AssetImage(
  //                                     "assets/images/event.png",
  //                                   ),
  //                                      backgroundImage: NetworkImage(
  //                                       cubit.organizerEntity.picture ?? '',
  //                                     ),
  //                                 ),
  //                                 AutoSizeText(
  //                                      cubit.organizerEntity.name ?? '',
  //                                   "ahmed",
  //                                   style: TextStyles.font24Regular,
  //                                   maxLines: 3,
  //                                   overflow: TextOverflow.ellipsis,
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   spacing: AppWidth.w25,
  //                                   children: [
  //                                     Column(
  //                                       children: [
  //                                         ConstrainedBox(
  //                                           constraints: BoxConstraints(
  //                                             maxWidth:
  //                                                 AppWidth.fullWidth(context) *
  //                                                 .5,
  //                                           ),
  //                                           child: AutoSizeText(
  //                                               '${cubit.organizerEntity.numberOfFollowing ?? ''}',
  //                                             "11",
  //                                             style: TextStyles.font16Medium,
  //                                             maxLines: 2,
  //                                           ),
  //                                         ),
  //                                         AutoSizeText(
  //                                           "Following",
  //                                           style: TextStyles.font14Regular
  //                                               .copyWith(
  //                                                 color: ColorsManager.greyColor,
  //                                               ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     Container(
  //                                       color: ColorsManager.greyColor,
  //                                       height: AppHight.h24,
  //                                       width: 1.w,
  //                                     ),
  //                                     Column(
  //                                       children: [
  //                                         ConstrainedBox(
  //                                           constraints: BoxConstraints(
  //                                             maxWidth:
  //                                                 AppWidth.fullWidth(context) *
  //                                                 .5,
  //                                           ),
  //                                           child: AutoSizeText(
  //                                               '${cubit.organizerEntity.numberOfFollowers ?? ''}',
  //                                             "122",
  //                                             style: TextStyles.font16Medium,
  //                                           ),
  //                                         ),
  //                                         AutoSizeText(
  //                                           "Followers",
  //                                           style: TextStyles.font14Regular
  //                                               .copyWith(
  //                                                 color: ColorsManager.greyColor,
  //                                               ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   spacing: AppWidth.w10,
  //                                   children: [
  //                                     Expanded(
  //                                       child: OrganizerActionButton(
  //                                         textColor: ColorsManager.white,
  //                                         buttonColor: ColorsManager.mainColor,
  //                                         borderColor: Colors.transparent,
  //                                         buttonLabel: 'Follow',
  //                                         image: AppImages.follow,
  //                                       ),
  //                                     ),
  //                                     Expanded(
  //                                       child: OrganizerActionButton(
  //                                         textColor: ColorsManager.mainColor,
  //                                         buttonColor: ColorsManager.white,
  //                                         borderColor: ColorsManager.mainColor,
  //                                         buttonLabel: 'Massages',
  //                                         image: AppImages.message,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           TabBar(
  //                             labelColor: ColorsManager.mainColor,
  //                             labelStyle: TextStyles.font16Medium,
  //                             indicatorColor: ColorsManager.mainColor,
  //                             unselectedLabelColor: ColorsManager.greyColor,

  //                               isScrollable: true,
  //                             controller: _tabController,
  //                             tabs: [
  //                               Tab(text: "ABOUT"),
  //                               Tab(text: "EVENT"),
  //                               Tab(text: "REVIEW"),
  //                             ],
  //                           ),
  //                           Expanded(
  //                             child: TabBarView(
  //                               controller: _tabController,
  //                               children: [
  //                                 OrganizerboutTab(),
  //                                 OrganizerEventsTab(),
  //                                 OriganizerReviewTab(),
  //                                   OrganizerboutTab(
  //                                     organizerEntity: cubit.organizerEntity,
  //                                   ),
  //                                   OrganizerEventsTab(
  //                                     organizerEntity: cubit.organizerEntity,
  //                                   ),
  //                                   OriganizerReviewTab(
  //                                     organizerEntity: cubit.organizerEntity,
  //                                   ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               );
  //         },
  //       ),
  //     );
  //   }
  // }
