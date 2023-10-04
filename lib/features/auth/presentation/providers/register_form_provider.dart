//! 1 - State de este provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final Password password2;
  final FullName fullName;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.password2 = const Password.pure(),
    this.fullName = const FullName.pure(),
    });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    FullName? fullName,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
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
  RegisterFormNotifier(): super(RegisterFormState());

  onEmailChange( String value ) {
    
  }
  
}

//! 3 - StateNotifierProvider - consume afuera

