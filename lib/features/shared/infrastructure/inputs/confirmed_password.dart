import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError {
  empty,
  mismatch,
}

class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  final String password;

  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmedPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == ConfirmedPasswordValidationError.empty)
      {return 'El campo es requerido';}
    if (displayError == ConfirmedPasswordValidationError.mismatch)
      {return 'Las contraseñas no coinciden';}
    return null;
  }

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    if (isValid || isPure) return null;
    if (value.isEmpty) return ConfirmedPasswordValidationError.empty;
    if (password != value) return ConfirmedPasswordValidationError.mismatch;
    return null;
  }
}
