import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/HealthCategories/get_doctors_by_health_categories_model.dart';
import 'package:mediezy_user/Repository/Bloc/HealthCategories/GetDoctorsByHealthCategory/get_doctors_by_health_category_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/Widgets/doctor_card_widget.dart';

class DoctorsByHealthCatrgoryScreen extends StatefulWidget {
  const DoctorsByHealthCatrgoryScreen(
      {super.key,
      required this.healthCategoryId,
      required this.healthCategoryName});

  final String healthCategoryId;
  final String healthCategoryName;

  @override
  State<DoctorsByHealthCatrgoryScreen> createState() =>
      _DoctorsByHealthCatrgoryScreenState();
}

class _DoctorsByHealthCatrgoryScreenState
    extends State<DoctorsByHealthCatrgoryScreen> {
  late GetDoctorsByHealthCategoriesModel getDoctorsByHealthCategoriesModel;

  @override
  void initState() {
    BlocProvider.of<GetDoctorsByHealthCategoryBloc>(context).add(
        FetchDoctorByHealthCategory(healthCategoryId: widget.healthCategoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.healthCategoryName),
        centerTitle: true,
      ),
      body: BlocBuilder<GetDoctorsByHealthCategoryBloc,
          GetDoctorsByHealthCategoryState>(
        builder: (context, state) {
          if (state is GetDoctorsByHealthCategoryLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            );
          }
          if (state is GetDoctorsByHealthCategoryError) {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
          if (state is GetDoctorsByHealthCategoryLoaded) {
            getDoctorsByHealthCategoriesModel =
                BlocProvider.of<GetDoctorsByHealthCategoryBloc>(context)
                    .getDoctorsByHealthCategoriesModel;
            return FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: const Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      const VerticalSpacingWidget(height: 5),
                      //! search
                      const VerticalSpacingWidget(height: 10),
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DoctorCardWidget(
                              doctorId: getDoctorsByHealthCategoriesModel.data![index].userid.toString(),
                              firstName: getDoctorsByHealthCategoriesModel.data![index].firstname.toString(),
                              imageUrl: getDoctorsByHealthCategoriesModel.data![index].docterImage.toString(),
                              lastName: getDoctorsByHealthCategoriesModel.data![index].secondname.toString(),
                              location: getDoctorsByHealthCategoriesModel.data![index].location.toString(),
                              mainHospitalName: getDoctorsByHealthCategoriesModel.data![index].mainHospital.toString(),
                              specialisation: getDoctorsByHealthCategoriesModel.data![index].specialization.toString(),
                            );
                          },
                          itemCount:
                              getDoctorsByHealthCategoriesModel.data!.length)
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
