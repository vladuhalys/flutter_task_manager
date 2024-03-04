import 'package:get/get.dart';

class ValidationController extends GetxController {
  final _email = ''.obs;
  final _password = ''.obs;
  final _emailError = ''.obs;
  final _passwordError = ''.obs;
  final _isEmailValid = false.obs;
  final _isPasswordValid = false.obs;

  String get email => _email.value;
  String get password => _password.value;
  String get emailError => _emailError.value;
  String get passwordError => _passwordError.value;
  bool get isEmailValid => _isEmailValid.value;
  bool get isPasswordValid => _isPasswordValid.value;

  void onEmailChanged(String value) {
    _email.value = value;
    _emailError.value = '';
    _isEmailValid.value = false;
    update();
  }

  void onPasswordChanged(String value) {
    _password.value = value;
    _passwordError.value = '';
    _isPasswordValid.value = false;
    update();
  }

  void validateEmail() {
    if (email.isEmpty) {
      _emailError.value = 'Email is required';
    } else if (!GetUtils.isEmail(email)) {
      _emailError.value = 'Invalid email';
    } else {
      _isEmailValid.value = true;
    }
    update();
  }

  void validatePassword() {
    if (password.isEmpty) {
      _passwordError.value = 'Password is required';
    } else if (password.length < 6) {
      _passwordError.value = 'Password must be at least 6 characters';
    } else {
      _isPasswordValid.value = true;
    }
    update();
  }

  void validateAll() {
    validateEmail();
    validatePassword();
    update();
  }

  void clear() {
    _email.value = '';
    _password.value = '';
    _emailError.value = '';
    _passwordError.value = '';
    _isEmailValid.value = false;
    _isPasswordValid.value = false;
    update();
  }
}
