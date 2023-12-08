// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_user/Model/GetTokens/get_token_model.dart';
import 'package:mediezy_user/Repository/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/empty_custome_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/token_card_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';

class BookAppoinmentScreen extends StatefulWidget {
  const BookAppoinmentScreen({
    super.key,
    required this.doctorId,
    required this.firstName,
    required this.lastName,
    required this.doctorImage,
    required this.specialisation,
    required this.mainHospitalName,
    required this.clinicId,
  });

  final String doctorId;
  final String firstName;
  final String lastName;
  final String doctorImage;
  final String specialisation;
  final String mainHospitalName;
  final String clinicId;

  @override
  State<BookAppoinmentScreen> createState() => _BookAppoinmentScreenState();
}

class _BookAppoinmentScreenState extends State<BookAppoinmentScreen> {
  DateTime selectedDate = DateTime.now();
  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return formattedSelectedDate;
  }

  late GetTokenModel getTokenModel;

  @override
  void initState() {
    BlocProvider.of<GetTokenBloc>(context).add(FetchTokenEvent(
        doctorId: widget.doctorId,
        clinicId: widget.clinicId,
        date: formatDate()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Date & Time"),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FadedScaleAnimation(
                        scaleDuration: const Duration(milliseconds: 400),
                        fadeDuration: const Duration(milliseconds: 400),
                        //! image
                        child: Image(
                          image: NetworkImage(widget.doctorImage),
                          width: 150.w,
                          height: 160.h,
                        )),
                    const HorizontalSpacingWidget(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! name
                        Text(
                          'Dr.\n${widget.firstName}\n${widget.lastName}',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: kTextColor),
                        ),
                        const VerticalSpacingWidget(height: 25),
                        //! specification and hospital
                        Text(
                          '${widget.specialisation} at',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: kSubTextColor),
                        ),
                        const VerticalSpacingWidget(height: 5),
                        SizedBox(
                          width: 175.w,
                          child: Text(
                            widget.mainHospitalName,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const VerticalSpacingWidget(height: 20),
                Text(
                  "Select Date",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: kSubTextColor),
                ),
                //! select date
                EasyDateTimeLine(
                  initialDate: selectedDate,
                  disabledDates: _getDisabledDates(),
                  onDateChange: (date) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(date);
                    setState(() {
                      selectedDate = date;
                    });
                    BlocProvider.of<GetTokenBloc>(context).add(FetchTokenEvent(
                        doctorId: widget.doctorId,
                        clinicId: widget.clinicId,
                        date: formattedDate));
                  },
                  activeColor: kMainColor,
                  dayProps: EasyDayProps(
                      height: 80.h,
                      width: 65.w,
                      activeDayNumStyle: TextStyle(
                          color: kCardColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                      activeDayStrStyle: TextStyle(
                          color: kCardColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                      activeMothStrStyle: TextStyle(
                          color: kCardColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                      todayHighlightStyle: TodayHighlightStyle.withBackground,
                      todayHighlightColor: const Color(0xffE1ECC8),
                      borderColor: kMainColor),
                ),
                BlocBuilder<GetTokenBloc, GetTokenState>(
                  builder: (context, state) {
                    if (state is GetTokenLoadingState) {
                      return SizedBox(
                        width: double.infinity,
                        height: 250.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        ),
                      );
                    }
                    if (state is GetTokenErrorState) {
                      return const Center(
                        child: Text("Something Went Wrong"),
                      );
                    }
                    if (state is GetTokenLoadedState) {
                      getTokenModel =
                          BlocProvider.of<GetTokenBloc>(context).getTokenModel;
                      return Column(
                        children: [
                          const VerticalSpacingWidget(height: 10),
                          //! select time
                          getTokenModel.tokenData == null
                              ? const EmptyCutomeWidget(
                                  emptyTitle:
                                      "No Token available\non this date")
                              : GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shrinkWrap: true,
                                  itemCount:
                                      getTokenModel.tokenData!.tokens!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    crossAxisCount: 5,
                                    mainAxisExtent: 76,
                                  ),
                                  itemBuilder: (context, index) {
                                    return TokenCardWidget(
                                      isBooked: getTokenModel
                                          .tokenData!.tokens![index].isBooked
                                          .toString(),
                                      dcotorId: widget.doctorId,
                                      date: selectedDate,
                                      clinicId: widget.clinicId,
                                      tokenNumber: getTokenModel
                                          .tokenData!.tokens![index].number
                                          .toString(),
                                      time: getTokenModel
                                          .tokenData!.tokens![index].time
                                          .toString(),
                                    );
                                  },
                                ),
                          const VerticalSpacingWidget(height: 10),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DateTime> _getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];
    for (int month = 1; month <= currentDate.month; month++) {
      int lastDay = month < currentDate.month ? 31 : currentDate.day;

      for (int day = 1; day < lastDay; day++) {
        disabledDates.add(DateTime(currentDate.year, month, day));
      }
    }
    return disabledDates;
  }
}
