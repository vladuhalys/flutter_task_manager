import 'package:flutter_task_manager/core/localization/keys.dart';
import 'package:get/get.dart';

class ValidationController extends GetxController {
  final _email = ''.obs;
  final _password = ''.obs;
  final _confirmPassword = ''.obs;
  final _emailError = ''.obs;
  final _passwordError = ''.obs;
  final _confirmPasswordError = ''.obs;
  final _isEmailValid = false.obs;
  final _isPasswordValid = false.obs;
  final _isConfirmPasswordValid = false.obs;
  final _isRegistrForm = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  String get email => _email.value;
  String get password => _password.value;
  String get confirmPassword => _confirmPassword.value;
  String get emailError => _emailError.value;
  String get passwordError => _passwordError.value;
  String get confirmPasswordError => _confirmPasswordError.value;
  bool get isEmailValid => _isEmailValid.value;
  bool get isPasswordValid => _isPasswordValid.value;
  bool get isConfirmPasswordValid => _isConfirmPasswordValid.value;
  bool get isRegistrForm => _isRegistrForm.value;

  void changeShowPassword() {
    obscurePassword.value = !obscurePassword.value;
    update();
  }

  void changeShowConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
    update();
  }

  void changeForm() {
    _isRegistrForm.value = !_isRegistrForm.value;
    update();
  }

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

  void onConfirmPasswordChanged(String value) {
    _confirmPassword.value = value;
    _confirmPasswordError.value = '';
    _isConfirmPasswordValid.value = false;
    update();
  }

  void validateEmail() {
    if (email.isEmpty) {
      _emailError.value = LangKeys.emailIsRequired;
    } else if (!GetUtils.isEmail(email)) {
      _emailError.value = LangKeys.invalidEmail;
    } else {
      _isEmailValid.value = true;
    }
    update();
  }

  void validatePassword() {
    if (password.isEmpty) {
      _passwordError.value = LangKeys.passwordIsRequired;
    } else if (password.length < 6) {
      _passwordError.value = LangKeys.passwordMustBeAtLeast6Characters;
    } else {
      _isPasswordValid.value = true;
    }
    update();
  }

  void validateConfirmPassword() {
    if (confirmPassword.isEmpty && isRegistrForm) {
      _confirmPasswordError.value = LangKeys.confirmPasswordIsRequired;
    } else if (confirmPassword != password && isRegistrForm) {
      _confirmPasswordError.value = LangKeys.passwordsDoNotMatch;
    } else {
      _isConfirmPasswordValid.value = true;
    }
    update();
  }

  void validateAll() {
    validateEmail();
    validatePassword();
    if (isRegistrForm) validateConfirmPassword();
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
