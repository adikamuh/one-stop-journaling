part of 'helper.dart';

class DateHelper {
  static String formatDateTime(DateTime datetime) {
    return DateFormat('EEEE, dd MMMM yyyy').format(datetime);
  }

  static String formatMonthYear(DateTime datetime) {
    return DateFormat('MMMM yyyy').format(datetime);
  }
}
