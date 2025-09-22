import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_const.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/routing/app_routes.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/firebase/events/data/model/firebase_events_model.dart';
import 'package:bookingapp/firebase/events/persentation/ui/widgets/firebase_saved_events_listview_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class FirebaseSavedEventsScreen extends StatefulWidget {
  const FirebaseSavedEventsScreen({super.key});

  @override
  State<FirebaseSavedEventsScreen> createState() =>
      _FirebaseSavedEventsScreenState();
}

class _FirebaseSavedEventsScreenState extends State<FirebaseSavedEventsScreen> {
  final Box<FirebaseEventsModel> bookmarkedBox = Hive.box<FirebaseEventsModel>(
    AppSavedKey.firebasesavedEvents,
  );

  @override
  Widget build(BuildContext context) {
    var savedEvents = bookmarkedBox.values.toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    spacing: AppWidth.w6,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: AppWidth.fullWidth(context) * 0.5,
                        ),
                        child: AutoSizeText(
                          "Saved Events",
                          style: TextStyles.font24Regular,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          size: 24.sp,
                          color: ColorsManager.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert_sharp,
                          size: 24.sp,
                          color: ColorsManager.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              AppSpace.vertical(AppHight.h12),
              Expanded(
                child:
                    savedEvents.isEmpty
                        ? Center(child: Text("No saved events"))
                        : ListView.separated(
                          shrinkWrap: true,
                          itemCount: savedEvents.length,
                          itemBuilder: (context, index) {
                            final event = savedEvents[index];
                            return SavedEventsListviewCardWidget(
                              firebaseEventsModel: event,
                              onTap: () {
                                AppNavigator.pushNamed(
                                  context,
                                  AppRoutes.eventsDeatilsScreen,

                                  params: {"id": event.eventId.toString()},
                                );
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return AppSpace.vertical(AppHight.h12);
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
