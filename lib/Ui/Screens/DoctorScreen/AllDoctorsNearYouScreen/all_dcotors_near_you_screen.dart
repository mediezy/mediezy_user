import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/Doctor/doctor_model.dart';
import 'package:mediezy_user/Repository/Bloc/GetDoctor/GetDoctors/get_doctor_bloc.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/Widgets/doctor_near_you_widget.dart';

class AllDoctorNearYouScreen extends StatefulWidget {
  const AllDoctorNearYouScreen({super.key, required this.doctorModel});

  final DoctorModel doctorModel;

  @override
  State<AllDoctorNearYouScreen> createState() => _AllDoctorNearYouScreenState();
}

class _AllDoctorNearYouScreenState extends State<AllDoctorNearYouScreen> {
  late DoctorModel doctorModel;

  @override
  void initState() {
    BlocProvider.of<GetDoctorBloc>(context).add(FetchGetDoctor());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors Near You"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<GetDoctorBloc, GetDoctorState>(
        builder: (context, state) {
          if (state is GetDoctorLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            );
          }
          if (state is GetDoctorError) {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
          if (state is GetDoctorLoaded) {
            doctorModel = BlocProvider.of<GetDoctorBloc>(context).doctorModel;
            return FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: const Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: doctorModel.docters!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.90),
                        itemBuilder: ((context, index) {
                          return DoctorNearYouWidget(
                            doctorId:
                                doctorModel.docters![index].userId.toString(),
                            firstName: doctorModel.docters![index].firstname
                                .toString(),
                            lastName: doctorModel.docters![index].secondname
                                .toString(),
                            imageUrl: doctorModel.docters![index].docterImage
                                .toString(),
                            location:
                                doctorModel.docters![index].location.toString(),
                          );
                        }),
                      ),
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
