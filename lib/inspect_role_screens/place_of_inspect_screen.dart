import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/inspect_role_screens/qr_screen_inspect/ispect_qr_screen.dart';
import 'package:qr_code_test_site/supports/constant.dart';

class PlaceOfInspecScreen extends StatefulWidget {
  const PlaceOfInspecScreen({super.key});

  @override
  State<PlaceOfInspecScreen> createState() => _PlaceOfInspecScreenState();
}

class _PlaceOfInspecScreenState extends State<PlaceOfInspecScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('place_of_scr_appbar'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'place_of_scr_title'.tr,
                style: TextStyle(color: Colors.black87, fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'place_of_scr_subtitle'.tr,
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
              SizedBox(height: 30),
              PlaceOfInspecForm(),
              SizedBox(height: 40),
              PlaceOfScreenButton(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceOfInspecForm extends StatelessWidget {
  const PlaceOfInspecForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController myController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            MyTextField(
              myInputDecoration:
                  MyInputDecoration(hintText: 'place_of_scr_name'.tr),
              controller: myController,
            ),
            MyTextField(
              myInputDecoration:
                  MyInputDecoration(hintText: 'place_of_scr_iin'.tr),
              controller: myController,
            ),
            CustomDropdownWidget(),
            MyTextField(
              myInputDecoration:
                  MyInputDecoration(hintText: 'place_of_scr_place'.tr),
              controller: myController,
            ),
            MyTextField(
              myInputDecoration:
                  MyInputDecoration(hintText: 'place_of_scr_city'.tr),
              controller: myController,
            ),
            MyTextField(
              myInputDecoration:
                  MyInputDecoration(hintText: 'place_of_scr_home'.tr),
              controller: myController,
            ),
            MyTextField(
              myInputDecoration:
                  MyInputDecoration(hintText: 'place_of_scr_street'.tr),
              controller: myController,
            ),
            MyTextField(
              myInputDecoration:
                  MyInputDecoration(hintText: 'place_of_scr_build'.tr),
              controller: myController,
            ),
            MyTextField(
              myInputDecoration:
                  MyInputDecoration(hintText: 'place_of_scr_info'.tr),
              controller: myController,
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final MyInputDecoration myInputDecoration;
  final TextEditingController controller;

  MyTextField({
    required this.myInputDecoration,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextField(
        // controller: controller,
        decoration: myInputDecoration.build(),
      ),
    );
  }
}

class MyInputDecoration {
  final String hintText;

  MyInputDecoration({
    required this.hintText,
  });

  InputDecoration build() {
    return InputDecoration(
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
          color: Colors.white,
          width: 1,
        ),
      ),
      hintStyle: const TextStyle(
        color: Colors.black45,
        fontFamily: 'RobotoReg',
      ),
      hintText: hintText,
    );
  }
}

class CustomDropdownWidget extends StatefulWidget {
  @override
  _CustomDropdownWidgetState createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  String selectedValue =
      'place_of_scr_dropdawn'.tr; // Установите значение по умолчанию

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'place_of_scr_pred'.tr,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(width: 10.0),
          Container(
            decoration: BoxDecoration(
                color: kBackgColor, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                value: selectedValue,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  }
                },
                items: <String>[
                  'place_of_scr_dropdawn'.tr,
                  '01010010101',
                  '0202020202',
                  '0300303030',
                  '0606060060'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                borderRadius:
                    BorderRadius.circular(15), // Радиус скругления углов
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceOfScreenButton extends StatelessWidget {
  const PlaceOfScreenButton({
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InspectQrScreen(),
          ));
        },
        child: Text(
          'place_of_scr_btn'.tr,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
