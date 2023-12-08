// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetAppointments/get_upcoming_appointments_model.dart';
import 'package:mediezy_user/Model/HealthCategories/get_health_categories_model.dart';
import 'package:mediezy_user/Model/Profile/get_user_model.dart';
import 'package:mediezy_user/Repository/Bloc/GetAppointment/GetUpcomingAppointment/get_upcoming_appointment_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthCategories/GetHealthCategories/get_health_categories_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/GetUser/get_user_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/heading_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Data/app_datas.dart';
import 'package:mediezy_user/Ui/Screens/AppointmentsScreen/Widgets/appointment_card_widget.dart';
import 'package:mediezy_user/Ui/Screens/AppointmentsScreen/appointments_screen.dart';
import 'package:mediezy_user/Ui/Screens/HomeScreen/Widgets/health_concern_widget.dart';
import 'package:mediezy_user/Ui/Screens/HomeScreen/Widgets/lab_test_health_concern_widget.dart';
import 'package:mediezy_user/Ui/Screens/SearchScreen/search_screen.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetUpComingAppointmentsModel getUpComingAppointmentsModel;
  late GetHealthCategoriesModel getHealthCategoriesModel;
  late GetUserModel getUserModel;
  int currentDotIndex = 0;
  final CarouselController controller = CarouselController();
  String? firstName;
  String? lastName;

  Future<void> getUserName() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      firstName = preferences.getString('firstName');
      lastName = preferences.getString('lastName');
    });
  }

  late Timer pollingTimer;

  @override
  void initState() {
    super.initState();

    getUserName();
    BlocProvider.of<GetUpcomingAppointmentBloc>(context)
        .add(FetchUpComingAppointments());
    BlocProvider.of<GetHealthCategoriesBloc>(context)
        .add(FetchHealthCategories());
    BlocProvider.of<GetUserBloc>(context).add(FetchUserDetails());
    startPolling();
  }

  void startPolling() async {
    pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      BlocProvider.of<GetUpcomingAppointmentBloc>(context)
          .add(FetchUpComingAppointments());
    });
  }

  void stopPolling() {
    pollingTimer.cancel();
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadedSlideAnimation(
      beginOffset: const Offset(0, 0.3),
      endOffset: const Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
      child: WillPopScope(
        onWillPop: () async {
          GeneralServices.instance
              .appCloseDialogue(context, "Are you want to Exit", () async {
            SystemNavigator.pop();
          });
          return Future.value(false);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 69, 143, 104),
                        Color(0xFF313C75)
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpacingWidget(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20.sp,
                                color: Colors.white,
                              ),
                              const HorizontalSpacingWidget(width: 5),
                              Text(
                                "Kochi",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Image(
                            image: const AssetImage(
                              "assets/icons/mediezy logo small.png",
                            ),
                            height: 40.h,
                            width: 100.w,
                          )
                        ],
                      ),
                      BlocBuilder<GetUserBloc, GetUserState>(
                        builder: (context, state) {
                          if (state is GetUserDetailsLoading) {
                            return const CircularProgressIndicator();
                          }
                          if (state is GetUserDetailsError) {
                            return const Center(
                              child: Text("No Name"),
                            );
                          }
                          if (state is GetUserDetailsLoaded) {
                            getUserModel = BlocProvider.of<GetUserBloc>(context)
                                .getUserModel;
                            return Text(
                              "${getUserModel.userdetails!.firstname} ${getUserModel.userdetails!.lastname}",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            );
                          }
                          return Container();
                        },
                      ),
                      Text(
                        "How do you feel today?",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacingWidget(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(color: kCardColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search Your needs",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: kSubTextColor),
                        ),
                        Icon(
                          IconlyLight.search,
                          color: kMainColor,
                          size: 20.sp,
                        )
                      ],
                    ),
                  ),
                ),

                const VerticalSpacingWidget(height: 10),
                //! banner one
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SizedBox(
                    height: 140.h,
                    child: Swiper(
                      autoplay: true,
                      itemCount: doctorBannerImagesOneHome.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 6.w, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              doctorBannerImagesOneHome[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }),
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                            color: Colors.grey[200],
                            activeColor: Colors.red[400],
                            size: 8.sp,
                            activeSize: 8.sp),
                      ),
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 10),
                //! your appointments
                BlocBuilder<GetUpcomingAppointmentBloc,
                    GetUpcomingAppointmentState>(
                  builder: (context, state) {
                    if (state is GetUpComingAppointmentLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
                    }
                    if (state is GetUpComingAppointmentError) {
                      return const Center(
                        child: Text("Something Went Wrong"),
                      );
                    }
                    if (state is GetUpComingAppointmentLoaded) {
                      if (state.isLoaded) {
                        getUpComingAppointmentsModel =
                            BlocProvider.of<GetUpcomingAppointmentBloc>(context)
                                .getUpComingAppointmentsModel;
                        return getUpComingAppointmentsModel.appointments == null
                            ? Container()
                            : Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: HeadingWidget(
                                      title: "Your Appointments",
                                      viewAllFunction: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AppointmentsScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails!
                                                  .length >
                                              2
                                          ? 2
                                          : getUpComingAppointmentsModel
                                              .appointments!
                                              .appointmentsDetails!
                                              .length,
                                      itemBuilder: (context, index) {
                                        return AppointmentCardWidget(
                                          docterImage:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .docterImage
                                                  .toString(),
                                          docterFirstname:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .firstname
                                                  .toString(),
                                          docterSecondName:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .secondname
                                                  .toString(),
                                          appointmentFor:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .mainSymptoms!
                                                  .first
                                                  .symtoms
                                                  .toString(),
                                          tokenNumber:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .tokenNumber
                                                  .toString(),
                                          clinicName:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .clincs!
                                                  .first
                                                  .hospitalName
                                                  .toString(),
                                          appointmentDate:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .date
                                                  .toString(),
                                          appointmentTime:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .startingtime
                                                  .toString(),
                                          patientName:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .patientName
                                                  .toString(),
                                          bookinTime:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .tokenBookingTime
                                                  .toString(),
                                          bookingDate:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .tokenBookingDate
                                                  .toString(),
                                          consultationStartingTime:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .consultationStartsfrom
                                                  .toString(),
                                          earlyTime:
                                              getUpComingAppointmentsModel
                                                  .appointments!
                                                  .appointmentsDetails![index]
                                                  .doctorEarlyFor
                                                  .toString(),
                                          estimatedArrivalTime:
                                              getUpComingAppointmentsModel
                                                          .appointments!
                                                          .appointmentsDetails![
                                                              index]
                                                          .estimateTime ==
                                                      null
                                                  ? getUpComingAppointmentsModel
                                                      .appointments!
                                                      .appointmentsDetails![
                                                          index]
                                                      .startingtime
                                                      .toString()
                                                  : getUpComingAppointmentsModel
                                                      .appointments!
                                                      .appointmentsDetails![
                                                          index]
                                                      .estimateTime
                                                      .toString(),
                                          lateTime: getUpComingAppointmentsModel
                                              .appointments!
                                              .appointmentsDetails![index]
                                              .doctorLateFor
                                              .toString(),
                                          liveToken:
                                              getUpComingAppointmentsModel
                                                      .appointments
                                                      ?.currentOngoingToken ??
                                                  '0'.toString(),
                                        );
                                      }),
                                ],
                              );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        );
                      }
                    }

                    return Container();
                  },
                ),
                BlocBuilder<GetHealthCategoriesBloc, GetHealthCategoriesState>(
                  builder: (context, state) {
                    if (state is GetHealthCategoriesLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: kMainColor,
                        ),
                      );
                    }
                    if (state is GetHealthCategoriesError) {
                      return const Center(
                        child: Text("Something Went Wrong"),
                      );
                    }
                    if (state is GetHealthCategoriesLoaded) {
                      getHealthCategoriesModel =
                          BlocProvider.of<GetHealthCategoriesBloc>(context)
                              .getHealthCategoriesModel;
                      return getHealthCategoriesModel.categories!.isEmpty
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //! health concern
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Text(
                                      "Browse by Health Concern",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: kSubTextColor),
                                    ),
                                  ),
                                  const VerticalSpacingWidget(height: 10),
                                  GridView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: getHealthCategoriesModel
                                          .categories!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: .65),
                                      itemBuilder: (context, index) {
                                        return HealthConcernWidget(
                                          title: getHealthCategoriesModel
                                              .categories![index].categoryName
                                              .toString(),
                                          imageUrl: getHealthCategoriesModel
                                              .categories![index].image
                                              .toString(),
                                          healthCategoryId:
                                              getHealthCategoriesModel
                                                  .categories![index].id
                                                  .toString(),
                                        );
                                      }),
                                ],
                              ),
                            );
                    }
                    return Container();
                  },
                ),
                const VerticalSpacingWidget(height: 20),
                //! second adbanner
                Container(
                  height: 230.h,
                  width: double.infinity,
                  color: Colors.blue[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarouselSlider(
                        carouselController: controller,
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          height: 180.h,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentDotIndex = index;
                            });
                          },
                        ),
                        items:
                            doctorBannerImagesTwoHome.map((String imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const VerticalSpacingWidget(height: 10),
                      AnimatedSmoothIndicator(
                        activeIndex: currentDotIndex,
                        count: doctorBannerImagesTwoHome.length,
                        effect: SlideEffect(
                            spacing: 5.w,
                            activeDotColor: Colors.white,
                            dotHeight: 8.h,
                            dotWidth: 8.w),
                      )
                    ],
                  ),
                ),
                const VerticalSpacingWidget(height: 20),
                //! lab tests
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: HeadingWidget(
                    title: "Lab Tests by Health Concern",
                    viewAllFunction: () {},
                  ),
                ),
                const VerticalSpacingWidget(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: labTestshealthConcernDatasOne.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 8.w, 0),
                                  child: LabTestHealthConcernWidget(
                                      imageUrl:
                                          labTestshealthConcernDatasOne[index]),
                                );
                              }),
                        ),
                        const VerticalSpacingWidget(height: 10),
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: labTestshealthConcernDatasTwo.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 8.w, 0),
                                  child: LabTestHealthConcernWidget(
                                      imageUrl:
                                          labTestshealthConcernDatasTwo[index]),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpacingWidget(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
