import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/services/api.dart';
import 'package:qr_code_test_site/supports/constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WaveContainer(),
            SizedBox(height: 20),
            ForgotFormWidget(),
            SizedBox(height: 30),
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
        color: kBackgColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Image.asset('assets/images/forgot_password_image.png'),
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ForgotFormWidget extends StatefulWidget {
  const ForgotFormWidget({Key? key}) : super(key: key);

  @override
  _ForgotFormWidgetState createState() => _ForgotFormWidgetState();
}

class _ForgotFormWidgetState extends State<ForgotFormWidget> {
  final TextEditingController _emailController = TextEditingController();
  final ApiService _apiService = ApiService("https://api.pbf.kz/api");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'fargot_buttom_txt'.tr,
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'fargot_buttom_txt_sub'.tr,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          Text(
            'Email',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 10),
          // TextField for email
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              fillColor: kBackgColor,
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
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              hintStyle: const TextStyle(
                color: Colors.black45,
                fontFamily: 'RobotoReg',
              ),
              hintText: "enter_email_hint".tr,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ForgotScreenButton(
            emailController: _emailController,
            apiService: _apiService,
          ),
        ],
      ),
    );
  }
}

class ForgotScreenButton extends StatefulWidget {
  final TextEditingController? emailController;
  final ApiService apiService;

  ForgotScreenButton({Key? key, this.emailController, required this.apiService})
      : super(key: key);

  @override
  _ForgotScreenButtonState createState() => _ForgotScreenButtonState();
}

class _ForgotScreenButtonState extends State<ForgotScreenButton> {
  bool isLoading = false; // Инициализация состояния isLoading

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kblue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: () async {
            setState(() {
              // Устанавливаем isLoading в true при начале запроса
              isLoading = true;
            });

            String snackBarText = '';

            try {
              String email = widget.emailController!.text;

              if (!email.contains('@')) {
                // Проверка на наличие символа "@" в тексте email
                snackBarText = 'Email должен содержать символ "@"';
              } else {
                String result = await widget.apiService.resetPassword(email);

                if (result == 'OK') {
                  snackBarText =
                      'Ссылка на смену пароля отправлена вам на почту';
                } else if (result == 'Email not found') {
                  snackBarText = 'Email не найден';
                } else {
                  snackBarText = 'Password reset failed. Result: $result';
                }
              }
            } catch (error) {
              snackBarText = 'Email не найден';
            } finally {
              setState(() {
                // Устанавливаем isLoading в false после завершения запроса
                isLoading = false;
              });
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(snackBarText),
                backgroundColor: Colors.red,
                duration: Duration(milliseconds: 1500),
              ),
            );
          },
          child: Stack(
            children: [
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              else
                Center(
                  child: Text(
                    isLoading ? 'Загрузка...' : 'check_btn_txt'.tr,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
