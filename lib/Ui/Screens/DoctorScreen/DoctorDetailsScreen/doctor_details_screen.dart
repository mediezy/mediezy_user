import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/Doctor/get_doctor_by_id_model.dart';
import 'package:mediezy_user/Repository/Bloc/Favourites/AddFavourites/add_favourites_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetDoctor/GetDoctorById/get_doctor_by_id_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/BookAppointmentScreen/book_appointment_screen.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({
    super.key,
    required this.doctorId,
  });

  final String doctorId;

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  late GetDoctorByIdModel getDoctorByIdModel;
  bool isClicked = false;

  @override
  void initState() {
    BlocProvider.of<GetDoctorByIdBloc>(context)
        .add(FetchDoctorById(id: widget.doctorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetDoctorByIdBloc, GetDoctorByIdState>(
        builder: (context, state) {
          if (state is GetDoctorByIdLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            );
          }
          if (state is GetDoctorByIdError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          if (state is GetDoctorByIdLoaded) {
            getDoctorByIdModel =
                BlocProvider.of<GetDoctorByIdBloc>(context).getDoctorByIdModel;
            return FadedSlideAnimation(
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
                          const VerticalSpacingWidget(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios,
                                    color: kMainColor),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isClicked = !isClicked;
                                  });
                                  BlocProvider.of<AddFavouritesBloc>(context)
                                      .add(AddFavourites(
                                          doctorId: widget.doctorId));
                                },
                                icon: Icon(
                                  getDoctorByIdModel.docter!.first
                                                  .favoriteStatus ==
                                              1 ||
                                          isClicked == true
                                      ? IconlyBold.bookmark
                                      : IconlyLight.bookmark,
                                  color: kMainColor,
                                ),
                              )
                            ],
                          ),
                          //! first section
                          Container(
                            color: kCardColor,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0.w),
                                      child: FadedScaleAnimation(
                                        scaleDuration:
                                            const Duration(milliseconds: 400),
                                        fadeDuration:
                                            const Duration(milliseconds: 400),
                                        //! image
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image(
                                              image: NetworkImage(
                                                  getDoctorByIdModel
                                                      .docter!.first.docterImage
                                                      .toString()),
                                              width: 150.w,
                                              height: 170.h,
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 8),
                                            //! name
                                            Text(
                                              'Dr.\n${getDoctorByIdModel.docter!.first.firstname.toString()}\n${getDoctorByIdModel.docter!.first.secondname.toString()}\n\n',
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: kTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const VerticalSpacingWidget(height: 23),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //! location
                                            Text(
                                              "Location",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: kSubTextColor),
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 5),
                                            Text(
                                              getDoctorByIdModel
                                                  .docter!.first.location
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 30),
                                            Text(
                                              "Works at",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: kSubTextColor),
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 5),
                                            //! hsopital name
                                            SizedBox(
                                              width: 130.w,
                                              child: Text(
                                                getDoctorByIdModel
                                                    .docter!.first.mainHospital
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 30),
                                            Text(
                                              "Specialisation In",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: kSubTextColor),
                                            ),
                                            const VerticalSpacingWidget(
                                                height: 5),
                                            //! specialisation
                                            SizedBox(
                                              width: 120.w,
                                              child: Text(
                                                getDoctorByIdModel.docter!.first
                                                    .specialization
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! second section
                          Container(
                            color: kCardColor,
                            padding: EdgeInsets.only(
                                top: 10.h,
                                left: 20.w,
                                bottom: 20.h,
                                right: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //! about
                                Text(
                                  "About",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kSubTextColor),
                                ),
                                const VerticalSpacingWidget(height: 10),
                                Text(
                                  getDoctorByIdModel.docter!.first.about
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: kTextColor,
                                      height: 1.3.h),
                                ),
                              ],
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! third section
                          Container(
                            width: double.infinity,
                            color: kCardColor,
                            padding: EdgeInsets.only(
                                top: 10.h,
                                left: 20.w,
                                bottom: 20.h,
                                right: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //! Clinic
                                Text(
                                  "Clinics",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kSubTextColor),
                                ),
                                const VerticalSpacingWidget(height: 5),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getDoctorByIdModel.docter!.first
                                                .clincs![index].name
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kTextColor),
                                          ),
                                          const VerticalSpacingWidget(
                                              height: 2),
                                          Text(
                                            getDoctorByIdModel.docter!.first
                                                .clincs![index].availability
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: kSubTextColor),
                                          )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const VerticalSpacingWidget(
                                          height: 5);
                                    },
                                    itemCount: getDoctorByIdModel
                                        .docter!.first.clincs!.length)
                              ],
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! fourth section
                          Container(
                            width: double.infinity,
                            color: kCardColor,
                            padding: EdgeInsets.only(
                                top: 10.h,
                                left: 20.w,
                                bottom: 10.h,
                                right: 20.w),
                            //! services
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Specifications",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kSubTextColor),
                                ),
                                const VerticalSpacingWidget(height: 10),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: getDoctorByIdModel
                                      .docter!.first.specifications!.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      getDoctorByIdModel
                                          .docter!.first.specifications![index],
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kTextColor),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const VerticalSpacingWidget(height: 3),
                                )
                              ],
                            ),
                          ),
                          const VerticalSpacingWidget(height: 10),
                          //! fifth section
                          Container(
                            color: kCardColor,
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //! specifications
                                Text(
                                  "Sub Specifications",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kSubTextColor),
                                ),
                                const VerticalSpacingWidget(height: 10),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: getDoctorByIdModel
                                      .docter!.first.subspecifications!.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      getDoctorByIdModel.docter!.first
                                          .subspecifications![index],
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kTextColor),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const VerticalSpacingWidget(height: 3),
                                )
                              ],
                            ),
                          ),
                          const VerticalSpacingWidget(height: 70),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.h,
                    left: 10.w,
                    right: 10.w,
                    child: CommonButtonWidget(
                      title: "Book Appointment Now",
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookAppoinmentScreen(
                              doctorId: widget.doctorId,
                              doctorImage: getDoctorByIdModel
                                  .docter!.first.docterImage
                                  .toString(),
                              firstName: getDoctorByIdModel
                                  .docter!.first.firstname
                                  .toString(),
                              lastName: getDoctorByIdModel
                                  .docter!.first.secondname
                                  .toString(),
                              specialisation: getDoctorByIdModel
                                  .docter!.first.specialization
                                  .toString(),
                              mainHospitalName: getDoctorByIdModel
                                  .docter!.first.mainHospital
                                  .toString(),
                              clinicId: getDoctorByIdModel
                                  .docter!.first.clincs!.first.id
                                  .toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
