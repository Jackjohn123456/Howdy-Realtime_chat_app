import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/features/auth/application/bloc/auth_bloc.dart';
import 'package:howdy/features/auth/presensation/widgets/auth_button.dart';
import 'package:howdy/features/auth/presensation/widgets/auth_input_fields.dart';
import 'package:howdy/features/auth/presensation/widgets/login_prompt.dart';

class Login extends StatefulWidget {


  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Login",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthInputFields(hint:"email",icon:Icons.person_outline,controller:_emailController),
            AuthInputFields(hint:"password",icon:Icons.lock_outline,controller:_passwordController,obscureText: true),
            SizedBox(height: 20,),
            BlocConsumer<AuthBloc,AuthState>(
              builder: (context, state) {
                if(state is AuthLoading){
                  return Center(child: CircularProgressIndicator());
                }
                return AuthButton(onPressed: _onLogin, text: "Login");
              },
              listener: (context, state) {
                if(state is AuthSuccess){
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false,);
                }
                else if(state is AuthFailure){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },),
            SizedBox(height: 20,),
            LoginPrompt(title: "Don't have an account? ", subTitle: "Sign Up", onTap: () {
              Navigator.pushNamed(context, '/register');
            },),
          ],
        ),
      ),
    );
  }

  _onLogin() {
    BlocProvider.of<AuthBloc>(context).add(
        LoginEvent(
            password:_passwordController.text,
            email:_emailController.text
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
