import 'package:bloc/bloc.dart';
import 'package:doctor_plus/utils/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());
  String language = SharedPreference().getString(key: 'lang') ?? 'en';

  void changeLanguage() {
    if (SharedPreference().getString(key: 'lang') == null) {
      SharedPreference().setString(key: 'lang', value: 'en');
    } else {
      language == 'en' ? language = 'ar' : language = 'en';
      SharedPreference().setString(key: 'lang', value: language);
      print(language);
      emit(LanguageChanged());
    }
  }
}
