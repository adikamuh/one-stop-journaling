part of 'helper.dart';

class DateHelper {
  static String formatDateTime(DateTime datetime) {
    return DateFormat('EEEE, dd MMMM yyyy').format(datetime);
  }
}
