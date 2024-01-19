import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_test_site/supports/constant.dart';
import 'package:qr_code_test_site/inspect_role_screens/home_inspector.dart';
import 'package:qr_code_test_site/login_screen/forgot_password.dart';

class UserController extends GetxController {}

final UserController userController = Get.put(UserController());

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                WaveContainer(),
                SizedBox(height: 20),
                LoginForm(
                  isPasswordVisible: _isPasswordVisible,
                  togglePasswordVisibility: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WaveContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        color: kBackgColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0,
            ),
            child: Image.asset('assets/images/login_image.png'),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final bool isPasswordVisible;
  final VoidCallback togglePasswordVisibility;

  const LoginForm({
    Key? key,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'come_btn_txt'.tr,
            style: TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 10),
          Text(
            'login_screen_subtitle_txt'.tr,
            style: TextStyle(fontSize: 19, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Логин',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: kblue,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 2,
                    ),
                  ),
                  hintStyle: const TextStyle(
                      color: Colors.black45, fontFamily: 'RobotoReg'),
                  hintText: "Iin_txt".tr,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Пароль',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: kblue,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  hintStyle: const TextStyle(
                      color: Colors.black45, fontFamily: 'RobotoReg'),
                  hintText: "Пароль",
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: togglePasswordVisibility,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen(),
                  ));
                },
                child: Text(
                  'fargot_buttom_txt'.tr,
                  style: TextStyle(fontSize: 18, color: kblue),
                ),
              ),
              InkWell(
                onTap: () {
                  // Ваш обработчик события
                },
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeInspector(),
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kblue,
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
