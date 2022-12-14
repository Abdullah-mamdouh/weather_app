

import '../../../utils/authentication/authentication_service.dart';
import '../../../utils/authentication/exception/auth_exception.dart';
import '../../../utils/loader.dart';
import '../../../utils/validator.dart';


import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/snackbar.dart';
import '../login_page/login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  static const String id = 'reset_password';
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthenticationService();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
                const SizedBox(height: 70),
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter your email address to recover your password.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Email address',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'abc@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  controller: _emailController,
                  validator: (value) => Validator.validateEmail(value ?? ""),
                ),
                const SizedBox(height: 16),
                const Expanded(child: SizedBox()),
                CustomButton(
                  label: 'RECOVER PASSWORD',
                  color: Colors.black,
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      LoaderX.show(context);
                      final _status = await _authService.resetPassword(
                          email: _emailController.text.trim());
                      if (_status == AuthStatus.successful) {
                        LoaderX.hide();
                        Navigator.pushNamed(context, LoginPage.id);
                      } else {
                        LoaderX.hide();
                        final error =
                        AuthExceptionHandler.generateErrorMessage(_status);
                        CustomSnackBar.showErrorSnackBar(context,
                            message: error);
                      }
                    }
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
