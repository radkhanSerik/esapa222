import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/supports/constant.dart';
import 'package:qr_code_test_site/user_role_screens/home_user.dart';
import 'package:qr_code_test_site/login_screen/login_screen.dart';
import 'package:qr_code_test_site/onboard_screen/onboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/img-1.png',
      bigText: "first_clide_big_txt".tr,
      text: "first_clide_txt".tr,
      bg: Colors.white,
      button: kblue,
    ),
    OnboardModel(
      img: 'assets/images/img-2.png',
      bigText: "second_clide_big_txt".tr,
      text: "second_clide_txt".tr,
      bg: Colors.white,
      button: kblue,
    ),
    OnboardModel(
      img: 'assets/images/img-3.png',
      bigText: "third_clide_big_txt".tr,
      text: "third_clide_txt".tr,
      bg: Colors.white,
      button: kblue,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height * 0.38;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeUser()));
            },
            child: Text(
              "appbar_next_text".tr + '  ',
              style: TextStyle(
                  color: kblue, fontSize: 17, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: screens.length,
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: screenHeight,
                        child: Image.asset(screens[index].img)),
                    Text(
                      screens[index].bigText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 27,
                          fontFamily: 'Poppins',
                          color: kblack,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        screens[index].text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'Poppins',
                          color: kGrey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        print(index);
                        if (index == screens.length - 1) {
                          await _storeOnboardInfo();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeUser()));
                        }
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 25),
                        decoration: BoxDecoration(
                          color: kblue,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: kblue, // Set shadow color
                              spreadRadius: 0.1, // Spread radius
                              blurRadius: 10, // Blur radius
                              offset: const Offset(0, 3), // Offset
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: kwhite,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                );
              },
            ),
          ),
          DotsIndicator(
            dotsCount: screens.length,
            position: currentIndex,
            decorator: DotsDecorator(
              color: kgrey, // Inactive color
              activeColor: kblue, // Active color
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
