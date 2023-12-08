import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class EmptyCutomeWidget extends StatelessWidget {
  const EmptyCutomeWidget(
      {super.key, required this.emptyTitle});

  final String emptyTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset("assets/animations/emptyDoctor.json"),
        const VerticalSpacingWidget(height: 20),
        Text(
          emptyTitle,
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.w600, color: kMainColor),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
