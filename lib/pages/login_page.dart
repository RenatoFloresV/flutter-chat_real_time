import '../widgets/labels_login.dart';
import '../widgets/logo.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_input.dart';
import '../widgets/custom_btn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Logo(),
              _Form(),
              LabelsLogin(),
              Text('Terms and conditions',
                  style: TextStyle(fontWeight: FontWeight.w200)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const CustomInput(
            prefixIcon: Icons.mail_outline,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const CustomInput(
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            hintText: 'Password',
          ),
          CustomBtn(
            text: 'Login',
            onLoginPressed: () {
              print(emailController.text);
              print(passwordController.text);
            },
          )
        ],
      ),
    );
  }
}
