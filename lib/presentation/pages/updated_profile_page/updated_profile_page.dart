import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../core/constant_colors/constant_colors.dart';
import '../../../utils/authentication/authentication_service.dart';
import '../../../utils/authentication/exception/auth_exception.dart';
import '../../../utils/loader.dart';
import '../../../utils/validator.dart';
import '../../bloc/cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/snackbar.dart';


class UpdatedProfilePage extends StatefulWidget {
  UpdatedProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdatedProfilePage> createState() => _UpdatedProfilePageState();
}

class _UpdatedProfilePageState extends State<UpdatedProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final userInfo = AuthenticationService.auth.currentUser!;
  final _authService = AuthenticationService();
  ConstantColor constantColors = ConstantColor();
  late final nameController;
  late final emailController;
  late final passwordController;
  late final locationController;
  @override
  void initState() {
    nameController = TextEditingController(text: userInfo.displayName);
    emailController = TextEditingController(text: userInfo.email);
    passwordController = TextEditingController();
    locationController = TextEditingController(text: AppBloc.locationName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: constantColors.fristcardColor,
      appBar: AppBar(
        backgroundColor: constantColors.fristBackgroundColor,
        centerTitle: true,
        title: Text(
          'Update Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //ImageProfile(),

                SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  hintText: 'Name',
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) => Validator.fullNameValidate(value ?? ""),
                  controller: nameController,
                ),

                SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => Validator.validateEmail(value ?? ""),
                  controller: emailController,
                ),

                SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  hintText: '******',
                  obscureText: true,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  controller: passwordController,
                  validator: (value) => Validator.validatePassword(value ?? ""),
                ),

                SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  hintText: 'Enter your Location',
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) => Validator.fullNameValidate(value ?? ""),
                  controller: locationController,
                ),

                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                    label: 'Update',
                    color: Colors.black,//constantColors.fristcardColor,
                    onPressed: () {
                      onClick(context);
                      //push(context, MaterialPageRoute(builder: (context) => UpdatedProfilePage(),));
                    },
                    size: size,
                    textColor: Colors.white,
                    borderSide: BorderSide()),
              ],
            ),
            )
        ),
      ),
    );
  }

  void onClick(BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      try {
        LoaderX.show(context);
        final _status =await _authService.updateUserAccount(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text);
        if (_status == AuthStatus.successful) {
          print('sssssssssssssssssssssssssss');
          LoaderX.hide();
          // SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pop(context);
            AppBloc.get(context).saveLocation(locationController.text);
          // });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data Updated')),
          );
        } else {
          print('fffffffffff');
          LoaderX.hide();
          final error =
          AuthExceptionHandler.generateErrorMessage(_status);
          CustomSnackBar.showErrorSnackBar(
            context,
            message: error,
          );
        }

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }
}
