import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/supports/constant.dart';
import 'package:qr_code_test_site/user_role_screens/home_user.dart';
import 'package:qr_code_test_site/supports/lacale_string.dart';
import 'package:qr_code_test_site/lang_screen.dart';
import 'package:qr_code_test_site/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isviewed;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await _setInitialLocale();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');

  runApp(MyApp());
}

Future<void> _setInitialLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedLocale = prefs.getString('selectedLocale');
  if (selectedLocale != null) {
    List<String> localeParts = selectedLocale.split('_');
    Locale locale = Locale(localeParts[0], localeParts[1]);
    Get.updateLocale(locale);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Get.locale, // Set the app's locale
      fallbackLocale: Locale('ru', 'RU'), // Set a fallback locale
      translations: LocalString(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgColor,
          // fontFamily: 'BaseFont',
          primaryColor: kblue,
          appBarTheme: AppBarTheme(
              color: kBackgColor,
              titleTextStyle: TextStyle(
                  color: kblack, fontSize: 19, fontWeight: FontWeight.w500),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black))),
      home: isviewed != 0 ? LangScreen() : HomeUser(),
    );
  }
}
