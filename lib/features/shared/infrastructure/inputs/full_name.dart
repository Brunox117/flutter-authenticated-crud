
//Define input validation errors
import 'package:formz/formz.dart';

enum FullNameError { empty}

//Extend FormzInput and provide the input type and error type
class FullName extends FormzInput<String, FullNameError>{
  const FullName.pure() : super.pure('');

  const FullName.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure ) return null;
    if( displayError == FullNameError.empty ) return 'El campo es requerido';
    return null;
  }

  @override
  FullNameError? validator(String value) {
    if ( value.isEmpty || value.trim().isEmpty ) return FullNameError.empty;
    return null;
  }

}