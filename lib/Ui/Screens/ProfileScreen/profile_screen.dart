// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/Profile/get_user_model.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/GetUser/get_user_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/horizontal_spacing_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/AuthenticationScreens/LoginScreen/login_screen.dart';
import 'package:mediezy_user/Ui/Screens/ProfileScreen/ProfileEditScreen/profile_edit_screen.dart';
import 'package:mediezy_user/Ui/Screens/ProfileScreen/SavedDoctorsScreen/saved_doctors_screen.dart';
import 'package:mediezy_user/Ui/Screens/ProfileScreen/Widgets/profile_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Future<void> getUserDetails() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      firstName = preferences.getString('firstName');
      lastName = preferences.getString('lastName');
      phoneNumber = preferences.getString('phoneNumber');
    });
  }

  late GetUserModel getUserModel;

  @override
  void initState() {
    BlocProvider.of<GetUserBloc>(context).add(FetchUserDetails());
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationControlWidget(),
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Account"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                final preferences = await SharedPreferences.getInstance();
                await preferences.remove('token');
                await preferences.remove('firstName');
                await preferences.remove('lastName');
                await preferences.remove('userId');
                await preferences.remove('phoneNumber');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              icon: const Icon(IconlyLight.logout),
            )
          ],
          automaticallyImplyLeading: false,
        ),
        body: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  //! first section
                  BlocBuilder<GetUserBloc, GetUserState>(
                    builder: (context, state) {
                      if (state is GetUserDetailsLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: kMainColor,
                          ),
                        );
                      }
                      if (state is GetUserDetailsError) {
                        return const Center(
                          child: Text("Something Went Wrong"),
                        );
                      }
                      if (state is GetUserDetailsLoaded) {
                        getUserModel =
                            BlocProvider.of<GetUserBloc>(context).getUserModel;
                        return Container(
                          color: kCardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            //! image and name details
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadedScaleAnimation(
                                  scaleDuration:
                                      const Duration(milliseconds: 400),
                                  fadeDuration:
                                      const Duration(milliseconds: 400),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 50.sp,
                                        backgroundColor: kCardColor,
                                        child: Image.asset(
                                          "assets/icons/profile pic.png",
                                          height: 75.h,
                                          width: 85.w,
                                          color: kMainColor,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -4.h,
                                        right: -10.w,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            IconlyLight.camera,
                                            size: 26.sp,
                                            weight: 5,
                                            color: kMainColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const HorizontalSpacingWidget(width: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${getUserModel.userdetails!.firstname.toString()}\n${getUserModel.userdetails!.lastname.toString()}",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: kTextColor),
                                    ),
                                    const VerticalSpacingWidget(height: 25),
                                    Text(
                                      "+91 $phoneNumber",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: kSubTextColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  const VerticalSpacingWidget(height: 10),
                  //! profile card items
                  Row(
                    children: [
                      Expanded(
                        child: ProfileCardWidget(
                          title: "My Profile",
                          subTitle: "Edit your profile",
                          icon: Icons.edit,
                          onTapFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => ProfileEditScreen(
                                  firstName: getUserModel.userdetails!.firstname
                                      .toString(),
                                  secondname: getUserModel.userdetails!.lastname
                                      .toString(),
                                  email: getUserModel.userdetails!.email
                                      .toString(),
                                  phNo: getUserModel.userdetails!.mobileNo
                                      .toString(),
                                  location: getUserModel.userdetails!.location
                                      .toString(),
                                  gender: getUserModel.userdetails!.gender
                                      .toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 5),
                      Expanded(
                        child: ProfileCardWidget(
                            title: "Saved",
                            subTitle: "Doctors",
                            icon: Icons.bookmark_outlined,
                            onTapFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SavedDoctorsScreen(),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: ProfileCardWidget(
                          title: "Lab Tests",
                          subTitle: "Test Booking",
                          icon: Icons.assignment_turned_in,
                          onTapFunction: () {},
                        ),
                      ),
                      const HorizontalSpacingWidget(width: 5),
                      Expanded(
                        child: ProfileCardWidget(
                            title: "My Address",
                            subTitle: "Save Address",
                            icon: Icons.location_pin,
                            onTapFunction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SavedDoctorsScreen(),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
