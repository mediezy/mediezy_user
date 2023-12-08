import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mediezy_user/Model/GetSymptoms/get_symptoms_model.dart';
import 'package:mediezy_user/Repository/Bloc/BookAppointment/book_appointment_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetSymptoms/get_symptoms_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/AppointmentsScreen/appointments_screen.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';

class AppointmentDoneScreen extends StatefulWidget {
  const AppointmentDoneScreen({
    super.key,
    required this.bookingTime,
    required this.bookingDate,
    required this.tokenNo,
    required this.doctorId,
    required this.clinicId,
  });

  final String bookingTime;
  final DateTime bookingDate;
  final String tokenNo;
  final String doctorId;
  final String clinicId;

  @override
  State<AppointmentDoneScreen> createState() => _AppointmentDoneScreenState();
}

class _AppointmentDoneScreenState extends State<AppointmentDoneScreen> {
  List<String> deceaseStartingTime = [
    'Today',
    'Yesterday',
    '5 Days Before',
    'Other'
  ];

  List<String> deceaseRepeats = ['Continues', 'Frequently', 'Sometimes'];
  // CheckPatient? _checkPatient = CheckPatient.Self;
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController patientAgeController = TextEditingController();
  final TextEditingController patientContactNumberController =
      TextEditingController();
  final TextEditingController appointmentForController =
      TextEditingController();
  String dropdownValue = 'Male';
  String regularMedicine = "No";
  String bookingFor = "self";
  int selectedStart = -1;
  int selectedCome = -1;
  int selectedSymptomsID = -1;
  late GetSymptomsModel getSymptomsModel;
  List<int> selectedSymptoms = [];
  String selectedBookingFor="";

  String formatDate() {
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(widget.bookingDate);
    return formattedSelectedDate;
  }

  @override
  void initState() {
    BlocProvider.of<GetSymptomsBloc>(context)
        .add(FetchSymptoms(doctorId: widget.doctorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appoinment Booked"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppointmentsScreen(),
                ),
              );
            },
            icon: const Icon(IconlyLight.calendar),
          )
        ],
      ),
      body: BlocListener<BookAppointmentBloc, BookAppointmentState>(
        listener: (context, state) {
          if (state is BookAppointmentLoaded) {
            GeneralServices.instance
                .showToastMessage("Token Book Successfully");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const BottomNavigationControlWidget()),
                (route) => false);
          }
          if (state is BookAppointmentError) {
            GeneralServices.instance.showToastMessage("Something Went Wrong");
          }
        },
        child: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacingWidget(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Patient Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: kSubTextColor),
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Age",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: kSubTextColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 45.h,
                          child: TextFormField(
                            cursorColor: kMainColor,
                            controller: patientNameController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 14.sp, color: kSubTextColor),
                              hintText: "Enter Patient Name",
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 45.h,
                          child: TextFormField(
                            cursorColor: kMainColor,
                            controller: patientAgeController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 14.sp, color: kSubTextColor),
                              hintText: "25 age",
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Contact Number",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kSubTextColor),
                  ),
                  const VerticalSpacingWidget(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 45.h,
                          child: TextFormField(
                            cursorColor: kMainColor,
                            controller: patientContactNumberController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 14.sp, color: kSubTextColor),
                              hintText: "Enter patient Phone number",
                              filled: true,
                              fillColor: kCardColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 10),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 45.h,
                          color: kCardColor,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Male', 'Female', 'Other']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 10),
                  Text(
                    "Appointment for",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kSubTextColor),
                  ),
                  const VerticalSpacingWidget(height: 10),
                  SizedBox(
                    height: 45.h,
                    child: TextFormField(
                      cursorColor: kMainColor,
                      controller: appointmentForController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(fontSize: 14.sp, color: kSubTextColor),
                        hintText: "eg. Chest pain, Body ache, etc.",
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpacingWidget(height: 10),
                  BlocBuilder<GetSymptomsBloc, GetSymptomsState>(
                    builder: (context, state) {
                      if (state is GetSymptomsLoaded) {
                        getSymptomsModel =
                            BlocProvider.of<GetSymptomsBloc>(context)
                                .getSymptomsModel;
                        return Wrap(
                          children: List.generate(
                            getSymptomsModel.symptoms!.length,
                            (index) => Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedSymptoms.contains(
                                          getSymptomsModel
                                              .symptoms![index].id!)) {
                                        selectedSymptoms.remove(getSymptomsModel
                                            .symptoms![index].id!);
                                      } else {
                                        selectedSymptoms.add(getSymptomsModel
                                            .symptoms![index].id!);
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: selectedSymptoms.contains(
                                              getSymptomsModel
                                                  .symptoms![index].id!)
                                          ? Colors.grey
                                          : kCardColor,
                                      border: Border.all(
                                          color: kMainColor, width: 1),
                                    ),
                                    margin: const EdgeInsets.all(3.0),
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      getSymptomsModel.symptoms![index].symtoms
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.sp,
                                          color: selectedSymptoms.contains(
                                                  getSymptomsModel
                                                      .symptoms![index].id!)
                                              ? Colors.white
                                              : kTextColor),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  Text(
                    "When did it start",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kSubTextColor),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      deceaseStartingTime.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStart = selectedStart == index ? -1 : index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedStart == index
                                ? Colors.grey
                                : kCardColor,
                            border: Border.all(color: kMainColor, width: 1),
                          ),
                          margin: const EdgeInsets.all(3.0),
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            deceaseStartingTime[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: selectedStart == index
                                  ? Colors.white
                                  : kTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpacingWidget(height: 10),
                  Text(
                    "When it's comes",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: kSubTextColor),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      deceaseRepeats.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCome = selectedCome == index ? -1 : index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedCome == index
                                ? Colors.grey
                                : kCardColor,
                            border: Border.all(color: kMainColor, width: 1),
                          ),
                          margin: const EdgeInsets.all(3.0),
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            deceaseRepeats[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: selectedCome == index
                                  ? Colors.white
                                  : kTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Using any regular medicines?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: kSubTextColor),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                    activeColor: kMainColor,
                                    value: "Yes",
                                    groupValue: regularMedicine,
                                    onChanged: (value) {
                                      setState(() {
                                        regularMedicine = value!;
                                      });
                                    }),
                                Text("Yes", style: TextStyle(fontSize: 14.sp)),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                    activeColor: kMainColor,
                                    value: "No",
                                    groupValue: regularMedicine,
                                    onChanged: (value) {
                                      setState(() {
                                        regularMedicine = value!;
                                      });
                                    }),
                                Text("No", style: TextStyle(fontSize: 14.sp)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                          activeColor: kMainColor,
                          value: "Self",
                          groupValue: bookingFor,
                          onChanged: (value) {
                            setState(() {
                              bookingFor = value!;
                              selectedBookingFor=1.toString();
                              print(bookingFor);
                              print(selectedBookingFor);
                            });
                          }),
                      Text("Self", style: TextStyle(fontSize: 14.sp)),
                      Radio<String>(
                          activeColor: kMainColor,
                          value: "Family Member",
                          groupValue: bookingFor,
                          onChanged: (value) {
                            setState(() {
                              bookingFor = value!;
                              selectedBookingFor=2.toString();
                              print(bookingFor);
                              print(selectedBookingFor);
                            });
                          }),
                      Text("Family Member", style: TextStyle(fontSize: 14.sp)),
                      Radio<String>(
                          activeColor: kMainColor,
                          value: "Other",
                          groupValue: bookingFor,
                          onChanged: (value) {
                            setState(() {
                              bookingFor = value!;
                              selectedBookingFor=3.toString();
                              print(bookingFor);
                              print(selectedBookingFor);
                            });
                          }),
                      Text("Other", style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 10),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: kTextColor),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Text(
                    "Doctors is conceived and developed by Mediezy Technology Pvt Ltd and is the owner of Doctors website and App",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: kSubTextColor),
                  ),
                  const VerticalSpacingWidget(height: 10),
                  Text(
                    "Instructions",
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: kTextColor),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Text(
                    "Please follow the below mentioned instructions for our online/offline appointments for a great experience at Doctors",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: kSubTextColor),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Text(
                    "By proceeding to avail a consultation, you agree to Doktors Terms ofUse.",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: kSubTextColor),
                  ),
                  const VerticalSpacingWidget(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDate(),
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: kSubTextColor),
                      ),
                      Text(
                        widget.bookingTime,
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: kTextColor),
                      ),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Consultation Fee",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: kSubTextColor),
                      ),
                      Text(
                        "₹ 10",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: kTextColor),
                      ),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 10),
                  CommonButtonWidget(
                      title: "Book Now",
                      onTapFunction: () {
                        BlocProvider.of<BookAppointmentBloc>(context).add(
                          PassBookAppointMentEvent(
                              patientName: patientNameController.text,
                              doctorId: widget.doctorId,
                              clinicId: widget.clinicId,
                              date: formatDate(),
                              regularmedicine: regularMedicine.toString(),
                              whenitcomes: deceaseStartingTime[selectedStart],
                              whenitstart: deceaseRepeats[selectedCome],
                              tokenTime: widget.bookingTime,
                              tokenNumber: widget.tokenNo,
                              gender: dropdownValue,
                              age: patientAgeController.text,
                              mobileNo: patientContactNumberController.text,
                              appoinmentfor1: [appointmentForController.text],
                              appoinmentfor2: selectedSymptoms,
                              bookingType: selectedBookingFor),
                        );
                      }),
                  const VerticalSpacingWidget(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
