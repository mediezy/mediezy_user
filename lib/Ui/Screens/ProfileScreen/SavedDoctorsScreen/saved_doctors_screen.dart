import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Model/GetFavourites/get_favourites_model.dart';
import 'package:mediezy_user/Repository/Bloc/Favourites/GetFavourites/get_favourites_bloc.dart';
import 'package:mediezy_user/Ui/CommonWidgets/empty_custome_widget.dart';
import 'package:mediezy_user/Ui/CommonWidgets/vertical_spacing_widget.dart';
import 'package:mediezy_user/Ui/Consts/app_colors.dart';
import 'package:mediezy_user/Ui/Screens/DoctorScreen/Widgets/doctor_card_widget.dart';

class SavedDoctorsScreen extends StatefulWidget {
  const SavedDoctorsScreen({super.key});

  @override
  State<SavedDoctorsScreen> createState() => _SavedDoctorsScreenState();
}

class _SavedDoctorsScreenState extends State<SavedDoctorsScreen> {
  late GetFavouritesModel getFavouritesModel;

  @override
  void initState() {
    BlocProvider.of<GetFavouritesBloc>(context).add(FetchAllFavourites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Doctors"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<GetFavouritesBloc, GetFavouritesState>(
        builder: (context, state) {
          if (state is GetAllFavouritesLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            );
          }
          if (state is GetAllFavouritesError) {
            return const Center(
              child: Text("Something Went wrong"),
            );
          }
          if (state is GetAllFavouritesLoaded) {
            getFavouritesModel =
                BlocProvider.of<GetFavouritesBloc>(context).getFavouritesModel;
            return FadedSlideAnimation(
              beginOffset: const Offset(0, 0.3),
              endOffset: const Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: getFavouritesModel.favoriteDoctors!.isEmpty
                  ? const EmptyCutomeWidget(
                      emptyTitle: "No doctors are available")
                  : SingleChildScrollView(
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
                                    doctorId: getFavouritesModel
                                        .favoriteDoctors![index].userId
                                        .toString(),
                                    firstName: getFavouritesModel
                                        .favoriteDoctors![index].firstname
                                        .toString(),
                                    lastName: getFavouritesModel
                                        .favoriteDoctors![index].secondname
                                        .toString(),
                                    imageUrl: getFavouritesModel
                                        .favoriteDoctors![index].docterImage
                                        .toString(),
                                    mainHospitalName: getFavouritesModel
                                        .favoriteDoctors![index].mainHospital
                                        .toString(),
                                    specialisation: getFavouritesModel
                                        .favoriteDoctors![index].specialization
                                        .toString(),
                                    location: getFavouritesModel
                                        .favoriteDoctors![index].location
                                        .toString(),
                                  );
                                },
                                itemCount:
                                    getFavouritesModel.favoriteDoctors!.length)
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
