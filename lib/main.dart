import 'package:doctor_plus/core/theming/colors.dart';
import 'package:doctor_plus/domain/cubits/appointments/appointment_cubit.dart';
import 'package:doctor_plus/domain/cubits/auth/signup_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctor%20reservations/doctor_reservation_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctor%20reservations/patients_number_at_day_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctorReviews/doctor_reviews_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctors/recommended_doctors_cubit.dart';
import 'package:doctor_plus/domain/cubits/prescriptions/prescription_cubit.dart';
import 'package:doctor_plus/domain/cubits/user/user_cubit.dart';
import 'package:doctor_plus/presentation/admin/admin_home.dart';
import 'package:doctor_plus/presentation/admin/complaints_page.dart';
import 'package:doctor_plus/presentation/admin/doctor_managment_page.dart';
import 'package:doctor_plus/presentation/admin/statistics_page.dart';
import 'package:doctor_plus/presentation/appointments/pages/appointments.dart';
import 'package:doctor_plus/presentation/appointments/pages/payment.dart';
import 'package:doctor_plus/presentation/doctor%20profile/pages/doctor_profile.dart';
import 'package:doctor_plus/presentation/patient%20home/pages/all_specializations.dart';
import 'package:doctor_plus/presentation/patient%20home/pages/complaints.dart';
import 'package:doctor_plus/presentation/doctor%20home/pages/doctor_home.dart';
import 'package:doctor_plus/presentation/patient%20profile/FAQ.dart';
import 'package:doctor_plus/presentation/patient%20profile/language.dart';
import 'package:doctor_plus/presentation/patient%20profile/notification.dart';

import 'package:doctor_plus/presentation/patient%20profile/profile.dart';
import 'package:doctor_plus/presentation/patient%20profile/security.dart';
import 'package:doctor_plus/presentation/patient%20profile/settings.dart';
import 'package:doctor_plus/presentation/search/pages/search_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'presentation/Doctor Profile/pages/doctor_page.dart';
import 'utils/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:doctor_plus/presentation/home.dart';
import 'package:doctor_plus/presentation/auth/login/login.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:doctor_plus/presentation/auth/signup/register.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:doctor_plus/domain/cubits/theme/theme_cubit.dart';
import 'package:doctor_plus/presentation/auth/signup/register_fill.dart';
import 'package:doctor_plus/domain/cubits/language/language_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreference.initialize();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserCubit()),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => SignupCubit()),
          BlocProvider(create: (_) => DoctorsCubit()),
          BlocProvider(create: (_) => LanguageCubit()),
          BlocProvider(create: (_) => AppointmentCubit()),
          BlocProvider(create: (_) => PrescriptionCubit()),
          BlocProvider(create: (_) => DoctorReviewsCubit()),
          BlocProvider(create: (_) => DoctorReservationCubit()),
          BlocProvider(create: (_) => PatientsNumberAtDayCubit()),
        ],
        child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: false,
              primaryColor: ColorsManager.mainBlue,
            ),
            // theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            supportedLocales: S.delegate.supportedLocales,
            locale: const Locale("en"),
            // locale: Locale(context.read<LanguageCubit>().language),
            localizationsDelegates: const [
              S.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routes: {
              Routes.admin: (context) => const AdminHomePage(),
              Routes.adminStatistics: (context) => const StatisticsPage(),
              Routes.adminComplaints: (context) => const AdminComplaintsPage(),
              Routes.doctorManagement: (context) => const DoctorManagmentPage(),
              Routes.faq: (context) => const FAQPage(),
              Routes.home: (context) => const HomePage(),
              Routes.login: (context) => const LoginPage(),
              Routes.search: (context) => const SearchScreen(),
              Routes.profile: (context) => const ProfilePage(),
              Routes.settings: (context) => const SettingsPage(),
              Routes.notification: (context) => const NotificationPage(),
              Routes.security: (context) => const SecurityPage(),
              Routes.language: (context) => const LanguagePage(),
              Routes.register: (context) => const RegisterPage(),
              Routes.doctorHome: (context) => const DoctorHome(),
              Routes.complaint: (context) => const ComplaintsPage(),
              Routes.registerFill: (context) => const RegisterFillData(),
              Routes.doctorAppointments: (context) =>
                  const DoctorAppointments(),
              Routes.doctorProfile: (context) => const DoctorProfile(),
              Routes.payment: (context) => const PaymentPage(),
              Routes.allSpecialization: (context) =>
                  const AllSpecializationsPage(),
              Routes.allDoctors: (context) => const AllSpecializationsPage(),
            },
            // initialRoute: Routes.home,
            initialRoute: Routes.home,
          );
        }),
      ),
    );
  }
}
