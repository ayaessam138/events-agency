import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookingapp/core/helpers/app_values.dart';
import 'package:bookingapp/core/theming/colors.dart';
import 'package:bookingapp/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class LoginOptions extends StatelessWidget {
   LoginOptions({super.key, required this.image, required this.label, this.height});
  final String image;
  final String label;
  double? height;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: AppHight.h15),
        width: AppWidth.fullWidth(context) * .8,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorsManager.greyButtonColor,
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(AppRadius.r12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppWidth.w10,
          children: [
            SvgPicture.asset(image),
            AutoSizeText(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.font16Regular.copyWith(
                color: ColorsManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
