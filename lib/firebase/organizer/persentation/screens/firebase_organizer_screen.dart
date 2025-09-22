import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/api/organizer/persenation/widgets/organizer_action_button.dart';
import 'package:bookingapp/firebase/organizer/persentation/cubit/firebase_organizer_cubit.dart';
import 'package:bookingapp/firebase/organizer/persentation/widget/firebase_organizer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseOrganizerScreen extends StatefulWidget {
  const FirebaseOrganizerScreen({super.key, required this.id});
  final String id;

  @override
  State<FirebaseOrganizerScreen> createState() =>
      _FirebaseOrganizerScreenState();
}

class _FirebaseOrganizerScreenState extends State<FirebaseOrganizerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    FirebaseOrganizerCubit.of(context).getOrganizer(organizerId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FirebaseOrganizerCubit, FirebaseOrganizerState>(
        buildWhen:
            (previous, current) =>
                current is FirebaseOrganizerlLoading ||
                current is FirebaseOrganizerFail ||
                current is FirebaseOrganizerSuccess,
        builder: (context, state) {

          if (state is FirebaseOrganizerFail) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FirebaseOrganizerSuccess) {
            return NestedScrollView(
              headerSliverBuilder:
                  (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      surfaceTintColor: Colors.transparent,
                      pinned: true,
                      floating: false,
                      elevation: 0,
                      expandedHeight: AppHight.fullHight(context) * .45,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppWidth.w12,
                            vertical: AppHight.h12,
                          ),
                          child: Column(
                            spacing: AppHight.h10,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: AppRadius.r35,

                                backgroundImage: NetworkImage(
                                  state.firebaseOrganizerModel.picture,
                                ),
                              ),
                              AutoSizeText(
                                state.firebaseOrganizerModel.name,

                                style: TextStyles.font24Regular,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                spacing: AppWidth.w25,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      AutoSizeText(
                                        '${state.firebaseOrganizerModel.numberOfFollowing ?? ''}',

                                        style: TextStyles.font16Medium,
                                      ),
                                      AutoSizeText(
                                        "Following",
                                        style: TextStyles.font14Regular
                                            .copyWith(
                                              color: ColorsManager.greyColor,
                                            ),
                                      ),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      AutoSizeText(
                                        '${state.firebaseOrganizerModel.numberOfFollowers ?? ''}',

                                        style: TextStyles.font16Medium,
                                      ),
                                      AutoSizeText(
                                        "Followers",
                                        style: TextStyles.font14Regular
                                            .copyWith(
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
                      children: [
                        FireBaseOrganizerboutTab(
                          organizerEntity: state.firebaseOrganizerModel,
                        ),
                        FirebaseOrganizerEventsTab(
                          organizerEntity: state.firebaseOrganizerModel,
                        ),
                        FirebaseOriganizerReviewTab(
                          organizerEntity: state.firebaseOrganizerModel,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
