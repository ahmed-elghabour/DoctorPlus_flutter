import 'package:intl/intl.dart';

class GeneralFunction {
  bool isArabic() {
    return Intl.getCurrentLocale() == "ar";
  }
}
