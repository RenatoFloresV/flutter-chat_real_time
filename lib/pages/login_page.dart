import '../helpers/custom_snackbar.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';

import '../helpers/alert_dialog.dart';
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
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            controller: emailController,
            prefixIcon: Icons.mail_outline,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            controller: passwordController,
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            hintText: 'Password',
          ),
          CustomBtn(
            text: authService.isLoading ? 'Loading...' : 'Login',
            onPressed: authService.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final res = await authService.login(
                        emailController.text, passwordController.text);

                    if (res.ok) {
                      Navigator.pushReplacementNamed(context, 'users');
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackbar.create(
                          message: res.msg,
                          backgroundColor: Colors.green,
                          icon: Icons.check_circle,
                        ),
                      );
                    } else {
                      viewAlert(
                          context, 'Error', res.errorMsg!, AlertType.error);
                    }
                  },
          )
        ],
      ),
    );
  }
}
