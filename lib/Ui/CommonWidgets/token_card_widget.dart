import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/AppointmentDoneScreen/appointment_done_screen.dart';

class TokenCardWidget extends StatefulWidget {
  const TokenCardWidget(
      {super.key,
      required this.tokenNumber,
      required this.time,
      required this.date,
      required this.dcotorId,
      required this.clinicId,
      required this.isBooked});

  final String tokenNumber;
  final String time;
  final DateTime date;
  final String dcotorId;
  final String clinicId;
  final String isBooked;

  @override
  State<TokenCardWidget> createState() => _TokenCardWidgetState();
}

class _TokenCardWidgetState extends State<TokenCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.isBooked == '1'
            ? null
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentDoneScreen(
                    bookingDate: widget.date,
                    bookingTime: widget.time,
                    tokenNo: widget.tokenNumber,
                    doctorId: widget.dcotorId,
                    clinicId: widget.clinicId,
                  ),
                ),
              );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: widget.isBooked == '1' ? kScaffoldColor : kCardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kMainColor, width: 0.8.w)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Text(
              widget.tokenNumber,
              style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                  color: widget.isBooked == '1' ? Colors.grey[500] : kTextColor),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                 color: widget.isBooked == '1' ? Colors.grey[500] : kTextColor),
            )
          ],
        ),
      ),
    );
  }
}
