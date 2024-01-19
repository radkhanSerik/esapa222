import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/services/api.dart';
import 'package:qr_code_test_site/supports/constant.dart';
import 'package:qr_code_test_site/login_screen/forgot_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {}

final UserController userController = Get.put(UserController());

class LoginTest extends StatefulWidget {
  const LoginTest({Key? key});

  @override
  State<LoginTest> createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  TextEditingController usernameController =
      TextEditingController(text: '950709300557');
  TextEditingController passwordController =
      TextEditingController(text: 'Dauren53');

  late ApiService _apiService;
  bool obscureText = true; // Добавлено для переключения видимости пароля

  void initState() {
    super.initState();
    _initializeApi();
  }

  void _initializeApi() {
    SharedPreferences.getInstance().then((prefs) async {
      try {
        String token = prefs.getString('token') ?? '';
        _apiService = ApiService(token);

        print("token: " + token);
      } catch (e) {
        print('Error initializing ApiService LoginTest: $e');
      }
    });
  }

  // Функция для переключения видимости пароля
  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

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
                  usernameController: usernameController,
                  passwordController: passwordController,
                  obscureText: obscureText,
                  onLoginPressed: () async {
                    // Обработка нажатия кнопки входа
                    // Код аутентификации здесь
                  },
                  togglePasswordVisibility: togglePasswordVisibility,
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
  const LoginForm({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.obscureText,
    required this.onLoginPressed,
    required this.togglePasswordVisibility,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obscureText;
  final VoidCallback onLoginPressed;
  final VoidCallback togglePasswordVisibility;

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
          //Subtitle
          Text(
            'login_screen_subtitle_txt'.tr,
            style: TextStyle(fontSize: 19, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 40),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //iin text
              Text(
                'Логин',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 10),
              //Fieling text
              TextField(
                controller: usernameController,
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
                    color: Colors.black45,
                    fontFamily: 'RobotoReg',
                  ),
                  hintText: "Iin_txt".tr,
                ),
              ),
              const SizedBox(height: 20),

              //password text

              Text(
                'Пароль',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 10),

              //TextField password

              TextField(
                controller: passwordController,
                obscureText: obscureText,
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
                    color: Colors.black45,
                    fontFamily: 'RobotoReg',
                  ),
                  hintText: "Пароль",
                  // Добавление иконки для переключения видимости пароля
                  suffixIcon: IconButton(
                    onPressed: togglePasswordVisibility,
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility_off,
                      color: Colors.grey,
                    ),
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
                onTap: onLoginPressed,
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
