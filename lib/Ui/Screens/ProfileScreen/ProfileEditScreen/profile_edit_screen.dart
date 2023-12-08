import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/EditUser/edit_user_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/bottom_navigation_control_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/common_button_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Services/general_services.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen(
      {super.key,
      required this.firstName,
      required this.secondname,
      required this.email,
      required this.phNo,
      required this.location,
      required this.gender});
  final String firstName;
  final String secondname;
  final String email;
  final String phNo;
  final String location;
  final String gender;
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Edit"),
        centerTitle: true,
       
      ),
      body: BlocListener<EditUserBloc, EditUserState>(
        listener: (context, state) {
          if (state is EditUserDetailsLoaded) {
            GeneralServices.instance
                .showToastMessage("Profile Edit Successfully");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const BottomNavigationControlWidget(),
              ),
            );
          }
        },
        child: FadedSlideAnimation(
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    const VerticalSpacingWidget(height: 25),
                    //! first name
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconlyLight.profile,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: widget.firstName,
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 20),
                    //! last name
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: secondNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconlyBroken.profile,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: widget.secondname,
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 20),
                    //! email
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: widget.email,
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 20),
                    //! phone number
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: mobileNoController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_iphone,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: widget.phNo,
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 20),
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: locationController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: widget.location,
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 20),
                    TextFormField(
                      cursorColor: kMainColor,
                      controller: genderController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.none,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.transgender,
                          color: kMainColor,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: kSubTextColor),
                        hintText: widget.gender,
                        filled: true,
                        fillColor: kCardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const VerticalSpacingWidget(height: 30),
                    CommonButtonWidget(
                        title: "Update",
                        onTapFunction: () {
                          BlocProvider.of<EditUserBloc>(context).add(
                            FetchEditUser(
                                firstName: firstNameController.text,
                                secondName: secondNameController.text,
                                mobileNo: mobileNoController.text,
                                email: emailController.text,
                                location: locationController.text,
                                gender: genderController.text),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
