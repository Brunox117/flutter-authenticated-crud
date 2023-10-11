//! 1 - State de este provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  // final ConfirmedPassword password2;
  final FullName fullName;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    // this.password2 = const ConfirmedPassword.pure(),
    this.fullName = const FullName.pure(),
    });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    // ConfirmedPassword? password2,
    FullName? fullName,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
    // password2: password2 ?? this.password2,
    fullName: fullName ?? this.fullName,
  );

  @override
  String toString() {
    return '''
    isPosting: $isPosting 
    isFormPosted: $isFormPosted 
    isValid: $isValid 
    email: $email 
    password: $password 
    
    fullName: $fullName 
  ''';}
}

//! 2 - Como implementar un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;
  RegisterFormNotifier({required this.registerUserCallback}): super(RegisterFormState());

  onEmailChange( String value ) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password, state.fullName])
      // isValid: Formz.validate([newEmail, state.password, state.password2, state.fullName])
    );
  }

  onPasswordChange( String value ){
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([state.email, newPassword, state.fullName])
      // isValid: Formz.validate([state.email, newPassword, state.password2, state.fullName])
    );
  }

  // onPassword2Change( String value ){
  //   final newPassword2 = ConfirmedPassword.dirty(password: state.password.value, value: value);
  //   state = state.copyWith(
  //     password2: newPassword2,
  //     isValid: Formz.validate([state.email, state.password, newPassword2, state.fullName])
  //   );
  // }

  onFullNameChange( String value ){
    final newFullName = FullName.dirty(value);
    state = state.copyWith(
      fullName: newFullName,
      isValid: Formz.validate([state.email, state.password, newFullName])
      // isValid: Formz.validate([state.email, state.password, state.password2, newFullName])
    );
  }

  onRegisterFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);
    await registerUserCallback(state.email.value, state.password.value, state.fullName.value);
    state = state.copyWith(isPosting: false);

  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    // final password2 = ConfirmedPassword.dirty(password: state.password.value, value: state.password2.value);
    final fullName = FullName.dirty(state.fullName.value);
    state = state.copyWith(
      email: email,
      password: password,
      isFormPosted: true,
      // password2: password2,
      fullName: fullName,
      isValid: Formz.validate([email, password, fullName])
      // isValid: Formz.validate([email, password, password2, fullName])
    );
  }

  
}

//! 3 - StateNotifierProvider - consume afuera

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});