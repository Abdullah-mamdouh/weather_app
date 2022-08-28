

import 'package:flutter/material.dart';
import '../../../utils/authentication/authentication_service.dart';
import '../../../utils/loader.dart';
import '../login_page/login_page.dart';
import '../../widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final userInfo = AuthenticationService.auth.currentUser!;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/person.png'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Hi ${userInfo.displayName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to your profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${userInfo.email}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 100,
                child: CustomButton(
                  label: 'LOGOUT',
                  color: Colors.black,
                  onPressed: () async {
                    LoaderX.show(context);
                    await AuthenticationService.auth.signOut().then((value) {
                      LoaderX.hide();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.id, (route) => false);
                    });
                  },
                  size: size,
                  textColor: Colors.white,
                  borderSide: BorderSide.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
