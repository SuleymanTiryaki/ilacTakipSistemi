import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class LoginState{
final String email;
final String password;


LoginState({

  required this.email,
  required this.password,
});

LoginState copyWith({
String? email,
String? password,
}){

return LoginState(
email: email ?? this.email,
password: password ?? this.password,

);

 }
}

class LoginCubit extends Cubit<LoginState>{

final TextEditingController emailController; 
final TextEditingController passwordController;

LoginCubit(this.emailController,this.passwordController) : super(LoginState(email:"",password:""));

void emailChanged(String email){

  emit(state.copyWith(email: email));
}
void passwordChanged(String password){

  emit(state.copyWith(password: password));
}
void login(){
  print("${emailController.text}");
  print("${passwordController.text}");
}
}