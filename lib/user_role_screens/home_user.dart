import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/inspect_role_screens/home_inspector.dart';
import 'package:qr_code_test_site/login_screen/login_screen.dart';
import 'package:qr_code_test_site/login_screen/login_test.dart';
import 'package:qr_code_test_site/services/api.dart';
import 'package:qr_code_test_site/user_role_screens/user_qr_screen/user_qr_screen.dart';
import 'package:qr_code_test_site/supports/constant.dart';
import 'package:qr_code_test_site/user_role_screens/user_qr_screen/user_enter_hand_screen.dart';
import 'package:qr_code_test_site/user_role_screens/message_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  late ApiService _apiService; // Объявите переменную для экземпляра ApiService
  @override
  void initState() {
    super.initState();
    // _initializeApi(); // Вызывайте функцию инициализации в initState
  }

  void _initializeApi() {
    SharedPreferences.getInstance().then((prefs) async {
      print(prefs.toString());
      try {
        String token = prefs.getString('token') ?? '';
        _apiService = ApiService(token);

        // Вызывайте функцию initialize, передавая логин и пароль, если необходимо
        await _apiService.initialize('login', 'password');
      } catch (e) {
        // Обработка ошибок, если необходимо
        print('Error initializing ApiService HomeUser: $e');
      }

      bool? isInspector = prefs.getBool('isInspector');

      if (isInspector!) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeUser(),
        ));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeInspector(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          Row(
            children: [
              AppBarHomeButtom(),
              AppBarHomeButtonMail(),
              SizedBox(width: 12)
            ],
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                TitleHomeScreenWidget(),
                SizedBox(height: 40),
                ButtomCheckMarkQr(),
                SizedBox(height: 25),
                ButtomCheckMarkHand(),
              ],
            ),
            SizedBox(height: 25),
            ExitButtomInspecScreen(),
          ],
        ),
      ),
    );
  }
}

class AppBarHomeButtonMail extends StatelessWidget {
  const AppBarHomeButtonMail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MessageScreen()));
      },
      icon: Icon(
        Icons.message_outlined,
        color: kblue,
        size: 28,
      ),
    );
  }
}

class AppBarHomeButtom extends StatelessWidget {
  const AppBarHomeButtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // add icon, by default "3 dot" icon
      icon: Icon(
        size: 30,
        Icons.language,
        color: kblue,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Set the desired radius here
      ),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: 0,
            child: Text("Қазақ тілі"),
          ),
          const PopupMenuItem<int>(
            value: 1,
            child: Text("Русский язык"),
          ),
        ];
      },
      onSelected: (value) async {
        if (value == 0) {
          var locale = const Locale('kk', 'KZ');
          await _saveLocale(locale);
          Get.updateLocale(locale);
        } else if (value == 1) {
          var locale = const Locale('ru', 'RU');
          await _saveLocale(locale);
          Get.updateLocale(locale);
        }
      },
    );
  }
}

class TitleHomeScreenWidget extends StatelessWidget {
  const TitleHomeScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'home_screen_text'.tr,
          style: const TextStyle(
              fontSize: 23,
              color: Color(0xFF242424),
              fontFamily: 'RobotoBold',
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'home_screen_sub_text'.tr,
          style: const TextStyle(
              fontSize: 19,
              color: Color(0xFF8F9BBA),
              fontFamily: 'RobotoBold',
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class ButtomCheckMarkQr extends StatelessWidget {
  const ButtomCheckMarkQr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 236, 234, 253), // Shadow color
            offset: Offset(3, 2), // Offset of the shadow
            blurRadius: 15, // Blur radius of the shadow
            spreadRadius: 3, // Spread radius of the shadow
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.width * 0.21,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UserQrScreen(),
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/qr_buttom.png'),
              const SizedBox(
                width: 10,
              ),
              Text(
                'scan_button_txt'.tr,
                style: TextStyle(
                  fontSize: 16,
                  color: kblueText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )),
    );
  }
}

class ButtomCheckMarkHand extends StatelessWidget {
  const ButtomCheckMarkHand({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 223, 221, 236), // Shadow color
            offset: Offset(3, 3), // Offset of the shadow
            blurRadius: 15, // Blur radius of the shadow
            spreadRadius: 3, // Spread radius of the shadow
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.width * 0.21,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UserEnterHandScreen(),
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/hand_buttom.png'),
              const SizedBox(width: 10),
              Text(
                'hand_button_txt'.tr,
                style: TextStyle(
                  fontSize: 16,
                  color: kblueText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )),
    );
  }
}

class ExitButtomInspecScreen extends StatefulWidget {
  const ExitButtomInspecScreen({super.key});

  @override
  State<ExitButtomInspecScreen> createState() => _ExitButtomInspecScreenState();
}

class _ExitButtomInspecScreenState extends State<ExitButtomInspecScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.width * 0.16,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: kblue,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.exit_to_app,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    'kabinet_inspect_buttom_user'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'RobotoMed',
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
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

Future<void> _saveLocale(Locale locale) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      'selectedLocale', '${locale.languageCode}_${locale.countryCode}');
}
