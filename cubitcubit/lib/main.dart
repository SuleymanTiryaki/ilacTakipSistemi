import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "giriş ekranı",
        theme: ThemeData(),
        home: BlocProvider(
          create: (context) => LoginCubit(_emailController,_passwordController),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text('Login'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          onChanged: (value) =>
                              context.read<LoginCubit>().emailChanged(value),
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) => (value ?? "").length > 6 ? null : "6 dan küçük" ,
                          
                        ),
                        TextFormField(
                          controller: _passwordController,
                          onChanged: (value) =>
                              context.read<LoginCubit>().passwordChanged(value),
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) => (value ?? "").length > 6 ? null : "6 dan küçük" ,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => context.read<LoginCubit>().login(),
                          child: Text('Login'),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        ));
  }
}

// class LoginForm extends StatelessWidget {
  

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
