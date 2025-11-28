import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howdy/features/auth/application/bloc/auth_bloc.dart';
import 'package:howdy/features/auth/presensation/widgets/auth_button.dart';
import 'package:howdy/features/auth/presensation/widgets/auth_input_fields.dart';
import 'package:howdy/features/auth/presensation/widgets/login_prompt.dart';

class Register extends StatefulWidget {


  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController _userNameController = TextEditingController();

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
          "register",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthInputFields(hint: "Username",icon: Icons.person_outline,controller: _userNameController),
            AuthInputFields(hint:"password",icon:Icons.lock_outline,controller:_passwordController,obscureText: true),
            AuthInputFields(hint:"email",icon:Icons.email_outlined,controller:_emailController),
            SizedBox(height: 20,),
            BlocConsumer<AuthBloc,AuthState>(
                builder: (context, state) {
                  if(state is AuthLoading){
                    return Center(child: CircularProgressIndicator());
                  }
                  return AuthButton(onPressed: _onRegister, text: "Register");
                },
                listener: (context, state) {
                  if(state is AuthSuccess){
                    Navigator.pushNamed(context, '/login');
                  }
                  else if(state is AuthFailure){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },),
            SizedBox(height: 20,),
            LoginPrompt(title: "Already have an account? ", subTitle: "Sign In", onTap:() {
              Navigator.pushNamed(context, '/login');
            },),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  _onRegister() {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
          password:_passwordController.text,
          username: _userNameController.text,
          email:_emailController.text
      )
    );
  }
}
