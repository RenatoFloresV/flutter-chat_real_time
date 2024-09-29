import '../widgets/custom_btn.dart';
import '../widgets/logo.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_input.dart';
import '../widgets/labels_register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Logo(text: 'Register'),
              _Form(),
              const LabelsRegister(),
              const Text('Terms and conditions',
                  style: TextStyle(fontWeight: FontWeight.w200)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            prefixIcon: Icons.person_outline,
            hintText: 'Name',
            controller: nameController,
          ),
          CustomInput(
            prefixIcon: Icons.mail_outline,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
          ),
          CustomInput(
            prefixIcon: Icons.lock_outline,
            hintText: 'Password',
            controller: passwordController,
            obscureText: true,
            suffixIcon: Icons.remove_red_eye,
          ),
          CustomBtn(
            text: 'Register',
            onLoginPressed: () {},
          )
        ],
      ),
    );
  }
}
