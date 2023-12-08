import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_user/Repository/Bloc/BookAppointment/book_appointment_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Favourites/AddFavourites/add_favourites_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Favourites/GetFavourites/get_favourites_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetAppointment/GetCompletedAppointments/get_completed_appointments_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetAppointment/GetUpcomingAppointment/get_upcoming_appointment_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetDoctor/GetDoctorById/get_doctor_by_id_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetDoctor/GetDoctors/get_doctor_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetSpecialisations/GetAllSpecialisations/get_all_specialisations_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetSpecialisations/GetDoctorsAsPerSpecialisation/get_doctors_as_per_specialisation_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetSymptoms/get_symptoms_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthCategories/GetDoctorsByHealthCategory/get_doctors_by_health_category_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/HealthCategories/GetHealthCategories/get_health_categories_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/LoginAndSignUp/login_and_signup_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/EditUser/edit_user_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/Profile/GetUser/get_user_bloc.dart';
import 'package:mediezy_user/Repository/Bloc/SearchDoctor/search_doctor_bloc.dart';
import 'package:mediezy_user/Ui/Consts/app_theme_style.dart';
import 'package:mediezy_user/Controllers/saved_doctor_controller.dart';
import 'package:mediezy_user/Ui/Screens/AuthenticationScreens/SplashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => GetDoctorBloc()),
    BlocProvider(create: (context) => GetDoctorByIdBloc()),
    BlocProvider(create: (context) => LoginAndSignupBloc()),
    BlocProvider(create: (context) => GetTokenBloc()),
    BlocProvider(create: (context) => GetSymptomsBloc()),
    BlocProvider(create: (context) => BookAppointmentBloc()),
    BlocProvider(create: (context) => GetUpcomingAppointmentBloc()),
    BlocProvider(create: (context) => GetCompletedAppointmentsBloc()),
    BlocProvider(create: (context) => GetAllSpecialisationsBloc()),
    BlocProvider(create: (context) => GetDoctorsAsPerSpecialisationBloc()),
    BlocProvider(create: (context) => AddFavouritesBloc()),
    BlocProvider(create: (context) => GetFavouritesBloc()),
    BlocProvider(create: (context) => SearchDoctorBloc()),
    BlocProvider(create: (context) => GetHealthCategoriesBloc()),
    BlocProvider(create: (context) => GetDoctorsByHealthCategoryBloc()),
    BlocProvider(create: (context) => GetUserBloc()),
    BlocProvider(create: (context) => EditUserBloc()),

  ], child: const Mediezy()));
}

class Mediezy extends StatelessWidget {
  const Mediezy({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SavedDoctorController()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mediezy',
            theme: appThemeStyle(),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
