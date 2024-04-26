import 'package:mvc_pattern/mvc_pattern.dart';

class Controller extends ControllerMVC {
  factory Controller() {
    _this ??= Controller._();
    return _this;
  }
  static Controller _this = Controller._();
  Controller._();
}
