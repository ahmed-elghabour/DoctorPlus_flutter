import 'package:doctor_plus/domain/cubits/doctorReservations/doctor_reservation_cubit.dart';
import 'package:doctor_plus/presentation/pages/complaints.dart';
import 'package:doctor_plus/presentation/pages/doctor_home.dart';

import 'utils/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_plus/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:doctor_plus/presentation/pages/home.dart';
import 'package:doctor_plus/presentation/pages/login.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:doctor_plus/presentation/pages/register.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:doctor_plus/domain/cubits/theme/theme_cubit.dart';
import 'package:doctor_plus/presentation/pages/register_fill.dart';
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
        BlocProvider(
           create: (context) {
            final cubit = DoctorReservationCubit();
            cubit.fetchReservations();
            return cubit;
          },
        )
      ],
      child:
          BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(useMaterial3: false),
          // theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          supportedLocales: S.delegate.supportedLocales,
          locale: const Locale("en"),
          // locale: Locale(context.read<LanguageCubit>().language),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routes: {
            Routes.home: (context) => const HomePage(),
            Routes.login: (context) => const LoginPage(),
            Routes.register: (context) => const RegisterPage(),
            Routes.complaint: (context) => const ComplaintsPage(),
            Routes.registerFill: (context) => const RegisterFillData(),
            Routes.doctorHome: (context) => const DoctorHome(),
          },
          initialRoute: SharedPreference().getBool(key: "isLogged") == true
              ? Routes.login
              : Routes.register,
        );
      }),
    );
  }
}
