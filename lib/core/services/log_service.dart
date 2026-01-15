import 'package:logger/logger.dart';

class LogService {
  static final Logger _logger = Logger();

  static void logInfo(String message) {
    _logger.i(message);
  }

  static void logWarning(String message) {
    _logger.w(message);
  }

  static void logError(String m, Object e, StackTrace s) {
    _logger.e(m, error: e, stackTrace: s);
  }

  static void logDebug(String message) {
    _logger.d(message);
  }
}
