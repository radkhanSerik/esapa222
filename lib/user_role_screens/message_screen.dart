import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/supports/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

final Uri _url2gis = Uri.parse('https://goo.gl/maps/rVViovuPiYrSiFmk7');

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        title: AppBarMessageTxt(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30.0, bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MessageScreen_txt_image(),
            ForgotScreenButton(),
          ],
        ),
      ),
    );
  }
}

class AppBarMessageTxt extends StatelessWidget {
  const AppBarMessageTxt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'message_screen_app_text'.tr,
      style: TextStyle(
          color: Colors.black87,
          fontSize: 22,
          fontFamily: 'RobotoBold',
          fontWeight: FontWeight.w600),
    );
  }
}

class MessageScreen_txt_image extends StatelessWidget {
  const MessageScreen_txt_image({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 40),
            Text(
              'message_screen_text'.tr,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 60),
            Image.asset('assets/images/email_image.png'),
          ]),
    );
  }
}

class ForgotScreenButton extends StatelessWidget {
  const ForgotScreenButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          String? encodeQueryParameters(Map<String, String> params) {
            return params.entries
                .map((MapEntry<String, String> e) =>
                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                .join('&');
          }

          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'Sd_pbf@nitec.kz',
            query: encodeQueryParameters(<String, String>{
              'subject': '',
            }),
          );

          launchUrl(emailLaunchUri);
        },
        child: Text(
          'check_btn_txt'.tr,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
