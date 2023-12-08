import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

class AppointmentCardWidget extends StatefulWidget {
  const AppointmentCardWidget(
      {super.key,
      required this.docterImage,
      required this.docterFirstname,
      required this.docterSecondName,
      required this.appointmentFor,
      required this.tokenNumber,
      required this.clinicName,
      required this.appointmentDate,
      required this.appointmentTime,
      required this.patientName,
      required this.liveToken,
      required this.estimatedArrivalTime,
      required this.bookingDate,
      required this.bookinTime,
      required this.consultationStartingTime,
      required this.lateTime,
      required this.earlyTime});

  final String docterImage;
  final String docterFirstname;
  final String docterSecondName;
  final String appointmentFor;
  final String tokenNumber;
  final String clinicName;
  final String appointmentDate;
  final String appointmentTime;
  final String patientName;
  final String liveToken;
  final String estimatedArrivalTime;
  final String bookingDate;
  final String bookinTime;
  final String consultationStartingTime;
  final String lateTime;
  final String earlyTime;

  @override
  State<AppointmentCardWidget> createState() => _AppointmentCardWidgetState();
}

class _AppointmentCardWidgetState extends State<AppointmentCardWidget> {
  bool isSecondContainerVisible = false;
  DateTime currentDate = DateTime.now();
  String formatDate() {
    String formattedSelectedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    return formattedSelectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.h, bottom: 8.0.h, left: 8.w, right: 8.w),
              child: Row(
                children: [
                  FadedScaleAnimation(
                    scaleDuration: const Duration(milliseconds: 400),
                    fadeDuration: const Duration(milliseconds: 400),
                    child: Image.network(
                      widget.docterImage,
                      height: 100.h,
                      width: 80.w,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VerticalSpacingWidget(height: 10),
                        Row(
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                "Dr.${widget.docterFirstname} ${widget.docterSecondName}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              height: 35.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF55B79B),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Token",
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.bold,
                                        color: kCardColor),
                                  ),
                                  Text(
                                    widget.tokenNumber,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: kCardColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          widget.clinicName,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: kSubTextColor),
                        ),
                        Row(
                          children: [
                            Text(
                              "Appointment for: ",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kSubTextColor),
                            ),
                            Text(
                              widget.appointmentFor,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kSubTextColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              widget.appointmentDate,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " | ",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.appointmentTime.toString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const HorizontalSpacingWidget(width: 5),
                        Row(
                          children: [
                            Text(
                              "Patient : ",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kSubTextColor),
                            ),
                            Text(
                              widget.patientName,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.appointmentDate == formatDate()
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 35.h,
                          width: 125.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF55B79B),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Live Token",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: kCardColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 28.h,
                                width: 25.w,
                                decoration: BoxDecoration(
                                  color: kCardColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.liveToken,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Estimated Arrival Time : ",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: kSubTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.estimatedArrivalTime,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : Container(),
            const VerticalSpacingWidget(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: OrderTrackerZen(
                tracker_data: [
                  TrackerData(
                    title: "Token Booked",
                    date: "${widget.bookingDate} | ${widget.bookinTime}",
                    tracker_details: [],
                  ),
                  TrackerData(
                    title: "Consultation Starting from",
                    date: widget.consultationStartingTime,
                    tracker_details: [],
                  ),
                  TrackerData(
                    title: "Appointment Time",
                    date: "${widget.appointmentDate}|${widget.appointmentTime}",
                    tracker_details: [],
                  ),
                ],
              ),
            ),
            // const VerticalSpacingWidget(height: 10),
            widget.appointmentDate == formatDate()
                ? isSecondContainerVisible
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isSecondContainerVisible =
                                    !isSecondContainerVisible;
                              });
                            },
                            child: Text(
                              isSecondContainerVisible
                                  ? "See less"
                                  : "See More",
                              style: TextStyle(
                                  fontSize: 15.sp, color: Colors.blue),
                            ),
                          ),
                        ),
                      )
                : Container(),
            const VerticalSpacingWidget(height: 10),
            if (isSecondContainerVisible)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: OrderTrackerZen(
                  tracker_data: [
                    TrackerData(
                      title: "Doctor Late for",
                      date: "${widget.lateTime} Min",
                      tracker_details: [],
                    ),
                    TrackerData(
                      title: "Doctor Early for",
                      date: "${widget.earlyTime} Min",
                      tracker_details: [],
                    ),
                  ],
                ),
              ),
            isSecondContainerVisible
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isSecondContainerVisible =
                                !isSecondContainerVisible;
                          });
                        },
                        child: Text(
                          isSecondContainerVisible ? "See less" : "See More",
                          style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                        ),
                      ),
                    ),
                  )
                : Container(),
            const VerticalSpacingWidget(height: 10),
            Divider(
              height: 4.h,
              thickness: 6.sp,
              color: kCardColor,
            ),
            const VerticalSpacingWidget(height: 10),
          ],
        ),
        PositionedDirectional(
          top: 0,
          end: -5,
          child: PopupMenuButton(
            iconSize: 20.sp,
            icon: Icon(
              Icons.more_vert,
              color: kTextColor,
            ),
            itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
              PopupMenuItem(
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuItem(
                child: Text(
                  "Reshedule",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuItem(
                child: Text(
                  "Feedback",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
