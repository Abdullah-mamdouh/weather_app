
import 'package:flutter/material.dart';
import 'package:untitled1/core/constant_colors/constant_colors.dart';
import 'package:untitled1/presentation/pages/login_page/login_page.dart';
import '../../../utils/authentication/authentication_service.dart';
import '../../../utils/authentication/exception/auth_exception.dart';
import '../../../utils/loader.dart';
import '../../../utils/validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/snackbar.dart';


class SignUpPage extends StatefulWidget {
  static const String id = 'signup_page';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
  final _key = GlobalKey<FormState>();
  ConstantColor constantColor = ConstantColor();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _authService = AuthenticationService();
  //disposing all text controllers
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constantColor.fristBackgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        //color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close,color: Colors.white,),
                  ),
                  const SizedBox(height: 70),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Open an account with a few details.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'Enter your name',
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) =>
                        Validator.fullNameValidate(value ?? ""),
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: '******',
                    obscureText: true,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    controller: _passwordController,
                    validator: (value) =>
                        Validator.validatePassword(value ?? ""),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: 'CREATE YOUR ACCOUNT',
                    color: Colors.black,
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        LoaderX.show(context);
                        final _status = await _authService.createAccount(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                          name: _nameController.text,
                        );
                        if (_status == AuthStatus.successful) {
                          LoaderX.hide();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                        } else {
                          LoaderX.hide();
                          final error =
                          AuthExceptionHandler.generateErrorMessage(
                              _status);
                          CustomSnackBar.showErrorSnackBar(
                            context,
                            message: error,
                          );
                        }
                      }
                    },
                    size: size,
                    textColor: Colors.white,
                    borderSide: BorderSide.none,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: RichText(
                      textScaleFactor: 0.8,
                      text: const TextSpan(
                        text: "Do you already have an acccount? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign in here',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}