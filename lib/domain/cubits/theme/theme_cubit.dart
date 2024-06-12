import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../utils/shared_preferences.dart';

part 'theme_state.dart';

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
