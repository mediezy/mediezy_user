import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/AppointmentsScreen/FeedBackDoneScreen/feed_back_done_screen.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.specialisation,
      required this.hospitalName});

  final String firstName;
  final String lastName;
  final String imageUrl;
  final String specialisation;
  final String hospitalName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Give Feedback"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        FadedScaleAnimation(
                          scaleDuration: const Duration(milliseconds: 400),
                          fadeDuration: const Duration(milliseconds: 400),
                          //! image
                          child: Image.asset(
                            imageUrl,
                            height: 250.h,
                            width: 150.w,
                          ),
                        ),
                        const HorizontalSpacingWidget(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! name
                            Text(
                              'Dr.\n$firstName\n$lastName\n\n',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor),
                            ),
                            //! specification and hospital
                            Text(
                              '$specialisation at\n$hospitalName',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: kSubTextColor),
                            )
                          ],
                        ),
                      ],
                    ),
                    const VerticalSpacingWidget(height: 10),
                    //! rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overall Experience",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: kSubTextColor),
                        ),
                      ],
                    ),
                    const VerticalSpacingWidget(height: 10),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 40.sp,
                          color: kstarColor,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 20),
                    //! rieview
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Brief your experience",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: kSubTextColor),
                        ),
                      ],
                    ),
                    const VerticalSpacingWidget(height: 20),
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Write your experience",
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //! submit
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonButtonWidget(
                  title: "Submit Feedback",
                  onTapFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedBackDoneScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
