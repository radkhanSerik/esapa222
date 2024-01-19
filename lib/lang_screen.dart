import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/supports/constant.dart';
import 'package:qr_code_test_site/onboard_screen/onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangScreen extends StatefulWidget {
  const LangScreen({super.key});

  @override
  State<LangScreen> createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  late Locale selectedLocale;

  bool isRussianSelected = true;
  bool isKazakhSelected = false;

  @override
  void initState() {
    var locale = const Locale('ru', 'RU');
    _saveLocale(locale);
    Get.updateLocale(locale);
    setState(() {
      isRussianSelected = true;
      isKazakhSelected = false;
    });
  }

  // Function to save the selected language preference
  Future<void> _saveLanguagePreference(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 10),
                child: Text(
                  'lang_screen_text'.tr,
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF242424),
                      fontFamily: 'RobotoBold',
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text(
                  'lang_screen_subtext'.tr,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8F9BBA),
                      fontFamily: 'RobotoBold',
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isRussianSelected ? kblue : Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: const Text(
                            'РУ',
                            style: TextStyle(
                              fontSize: 23,
                              color: Color(0xFF5B53FF),
                            ),
                          ),
                          onPressed: () async {
                            var locale = const Locale('ru', 'RU');
                            await _saveLocale(locale);
                            Get.updateLocale(locale);
                            setState(() {
                              isRussianSelected = true;
                              isKazakhSelected = false;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Русский',
                        style: TextStyle(
                            fontSize: 16,
                            color: isRussianSelected ? kblue : kblack),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isKazakhSelected ? kblue : Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: const Text(
                            'ҚАЗ',
                            style: TextStyle(
                              fontSize: 23,
                              color: Color(0xFF5B53FF),
                            ),
                          ),
                          onPressed: () async {
                            var locale = const Locale('kk', 'KZ');
                            await _saveLocale(locale);
                            Get.updateLocale(locale);
                            setState(() {
                              isRussianSelected = false;
                              isKazakhSelected = true;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Қазақша',
                        style: TextStyle(
                            fontSize: 16,
                            color: isRussianSelected ? kblack : kblue),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnBoardScreen()),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                decoration: BoxDecoration(
                  color: kblue,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: kblue, // Set shadow color
                      spreadRadius: 0.1, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: Offset(0, 3), // Offset
                    ),
                  ],
                ),
                child: Text(
                  'lang_screen_btn_text'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _saveLocale(Locale locale) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      'selectedLocale', '${locale.languageCode}_${locale.countryCode}');
}
