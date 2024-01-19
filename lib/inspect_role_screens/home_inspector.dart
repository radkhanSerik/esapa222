import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/inspect_role_screens/qr_screen_inspect/inspec_qr_scr_inner/inspect_enter_hand_screen.dart';
import 'package:qr_code_test_site/inspect_role_screens/qr_screen_inspect/ispect_qr_screen.dart';
import 'package:qr_code_test_site/user_role_screens/user_qr_screen/user_qr_inner_screens/history_screen.dart';
import 'package:qr_code_test_site/user_role_screens/home_user.dart';
import 'package:qr_code_test_site/inspect_role_screens/place_of_inspect_screen.dart';
import 'package:qr_code_test_site/supports/constant.dart';
// ignore: unused_import
import 'package:qr_code_test_site/user_role_screens/user_qr_screen/user_enter_hand_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeInspector extends StatefulWidget {
  const HomeInspector({super.key});

  @override
  State<HomeInspector> createState() => _HomeInspectorState();
}

class _HomeInspectorState extends State<HomeInspector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          Row(
            children: [
              AppBarHomeButtom(),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              ImageHomeInspecWidget(),
              SizedBox(height: 50),
              PlaceOfInspectWidget(),
              SizedBox(height: 25),
              ButtomCheckMarkQr(),
              SizedBox(height: 25),
              ButtomCheckMarkHand(),
              SizedBox(height: 25),
              HistoryButtomWidget(),
            ],
          ),
          ExitButtomInspecScreen(),
        ],
      ),
    );
  }
}

// class AppBarHomeButtonMail extends StatelessWidget {
//   const AppBarHomeButtonMail({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => MessageScreen()));
//       },
//       icon: Icon(
//         Icons.message_outlined,
//         color: kblue,
//         size: 28,
//       ),
//     );
//   }
// }

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

class ImageHomeInspecWidget extends StatelessWidget {
  const ImageHomeInspecWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/img_home_inspec.png'),
    );
  }
}

class PlaceOfInspectWidget extends StatelessWidget {
  const PlaceOfInspectWidget({
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
            spreadRadius: 5, // Spread radius of the shadow
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
              builder: (context) => PlaceOfInspecScreen(),
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/local_icon.png'),
              const SizedBox(
                width: 10,
              ),
              Text(
                'scan_button_txt_create'.tr,
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
            spreadRadius: 5, // Spread radius of the shadow
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
              builder: (context) => const InspectQrScreen(),
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
              builder: (context) => const InspectEnterHandScreen(),
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

class HistoryButtomWidget extends StatelessWidget {
  const HistoryButtomWidget({
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
              builder: (context) => const HistoryScreen(),
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/history_icon.png'),
              const SizedBox(width: 10),
              Text(
                'scan_button_txt_history'.tr,
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
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('exit_kabinet_inspec_buttom_user'.tr),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              content: Text(
                'exit_alert_title_txt_kabinet'.tr,
                style: TextStyle(fontSize: 18),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Отмена'),
                  child: Text(
                    'exit_alert_txt_no'.tr,
                    style: TextStyle(fontSize: 17, color: Color(0xFF5D55FE)),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeUser()),
                    (Route<dynamic> route) => false,
                  ),
                  child: Text(
                    'exit_alert_txt_yes_kabinet'.tr,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF5D55FE),
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.exit_to_app,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    'exit_buttom_user'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'RobotoMed',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
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
