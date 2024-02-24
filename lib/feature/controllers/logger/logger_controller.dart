import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoggerController extends GetxController {
  var logger = Logger();

  void logInfo(String message) {
    logger.i(message);
  }

  void logError(String message) {
    logger.e(message);
  }

  void logWarning(String message) {
    logger.w(message);
  }

  void logDebug(String message) {
    logger.d(message);
  }
}
