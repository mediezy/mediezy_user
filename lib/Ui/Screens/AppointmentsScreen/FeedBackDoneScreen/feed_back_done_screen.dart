import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class FeedBackDoneScreen extends StatelessWidget {
  const FeedBackDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                FadedScaleAnimation(
                  scaleDuration: const Duration(milliseconds: 400),
                  fadeDuration: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Lottie.asset("assets/animations/feedBackDone.json"),
                  ),
                ),
                const Spacer(flex: 2),
                Text(
                  "Thank you for your\nFeedback",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: kMainColor,
                      height: 1.5.h),
                ),
                const Spacer(flex: 3),
                CommonButtonWidget(
                  title: "Go to Home",
                  onTapFunction: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BottomNavigationControlWidget(),
                      ),
                    );
                  },
                ),
                const VerticalSpacingWidget(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
