import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UtilsHelper {
  static String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    DateFormat dateFormat = DateFormat('dd MMMM yyyy  |  hh:mm a');

    return dateFormat.format(dateTime);
  }
}
