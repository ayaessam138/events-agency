import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_spacing.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/feature/bottom_nav_bar/persentation/controller/bottom_nav_bar_cubit.dart';
import 'package:bookingapp/feature/events/persentation/widgets/events_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      IconButton(
                        onPressed: () {
                          if (BottomNavBarCubit.get.currentIndex == 1) {
                            BottomNavBarCubit.get.changeIndex(0);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          size: 24.sp,
                          color: ColorsManager.black,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth:
                              AppWidth.fullWidth(context) *
                              0.5, // 50% of screen width
                        ),
                        child: AutoSizeText(
                          " Events",
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
              Expanded(child: EventsListview()),
            ],
          ),
        ),
      ),
    );
  }
}
