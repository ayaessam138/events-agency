import 'package:bookingapp/core/theming/app_images.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:bookingapp/firebase/bottomNavBar/persentation/cubit/firebase_bottom_navbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirebaseBottomNavbarScreen extends StatelessWidget {
  const FirebaseBottomNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirebaseBottomNavbarCubit, FirebaseBottomNavbarState>(
      buildWhen: (previous, current) => current is FirebaseBottomNavbarChangeIndex,
      builder: (context, state) {
        var cubit = FirebaseBottomNavbarCubit.get;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: cubit.pages[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentIndex,
            unselectedItemColor: ColorsManager.greyColor,
            selectedItemColor: ColorsManager.mainColor,
            backgroundColor: ColorsManager.white,
            selectedLabelStyle: TextStyles.font10Bold,
            unselectedLabelStyle: TextStyles.font10Bold,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_month),
                label: "Events",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.location,
                  color:
                      cubit.currentIndex == 2
                          ? ColorsManager.mainColor
                          : ColorsManager.greyColor,
                ),
                label: "Map",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.email,
                  color:
                      cubit.currentIndex == 3
                          ? ColorsManager.mainColor
                          : ColorsManager.greyColor,
                ),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
