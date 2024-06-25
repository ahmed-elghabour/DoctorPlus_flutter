import 'package:doctor_plus/core/theming/colors.dart';
import 'package:doctor_plus/domain/cubits/doctorReservations/doctor_reservation_cubit.dart';
import 'package:doctor_plus/domain/cubits/doctorReservations/patients_number_atDay_cubit.dart';
// import 'package:doctor_plus/domain/cubits/doctorReservations/patients_number_atDay_cubit.dart';
import 'package:doctor_plus/presentation/appointments/pages/appointments.dart';
import 'package:doctor_plus/presentation/appointments/pages/payment.dart';
import 'package:doctor_plus/presentation/patient%20home/complaints.dart';
import 'package:doctor_plus/presentation/doctor%20home/pages/doctor_home.dart';
import 'package:doctor_plus/presentation/profile/FAQ.dart';
import 'package:doctor_plus/presentation/profile/language.dart';
import 'package:doctor_plus/presentation/profile/notification.dart';

import 'package:doctor_plus/presentation/profile/profile.dart';
import 'package:doctor_plus/presentation/profile/security.dart';
import 'package:doctor_plus/presentation/profile/settings.dart';
import 'package:doctor_plus/presentation/search/pages/search_screen.dart';

import 'utils/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:doctor_plus/presentation/patient%20home/home.dart';
import 'package:doctor_plus/presentation/auth/login/login.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:doctor_plus/presentation/auth/signup/register.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:doctor_plus/domain/cubits/theme/theme_cubit.dart';
import 'package:doctor_plus/presentation/auth/widgets/register_fill.dart';
import 'package:doctor_plus/domain/cubits/language/language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreference.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (_) => DoctorReservationCubit()),
        BlocProvider(create: (_) => PatientsNumberAtDayCubit())
      ],
      child:
          BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
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
            Routes.doctorAppointments: (context) => const DoctorAppointments(),
            Routes.payment: (context) => const PaymentPage(),
          },
          initialRoute: Routes.payment,
        );
      }),
    );
  }
}
