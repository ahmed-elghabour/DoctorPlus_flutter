

import 'package:doctor_plus/domain/cubits/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/shared_preferences.dart';


class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  String theme = SharedPreference().getString(key: 'lang') ?? 'en';

  void changeLanguage() {
    if (SharedPreference().getString(key: 'lang') == null) {
      SharedPreference().setString(key: 'lang', value: 'en');
    } else {
      theme == 'en' ? theme = 'ar' : theme = 'en';
      SharedPreference().setString(key: 'lang', value: theme);
      emit(ThemeChanged());
    }
  }
}
