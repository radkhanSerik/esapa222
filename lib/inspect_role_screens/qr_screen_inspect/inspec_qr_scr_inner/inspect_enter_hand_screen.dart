import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/inspect_role_screens/home_inspector.dart';
import 'package:qr_code_test_site/inspect_role_screens/qr_screen_inspect/ispect_qr_screen.dart';
import 'package:qr_code_test_site/supports/constant.dart';

class InspectEnterHandScreen extends StatefulWidget {
  const InspectEnterHandScreen({super.key});

  @override
  State<InspectEnterHandScreen> createState() => _InspectEnterHandScreenState();
}

class _InspectEnterHandScreenState extends State<InspectEnterHandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'hand_appbar_txt'.tr,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InspectQrScreen(),
                ));
              },
              icon: Icon(
                Icons.qr_code_scanner_sharp,
                size: 30,
                color: kblue,
              ),
            ),
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeInspector()));
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TopTextWidget(),
            MarkWidgets(),
            SizedBox(height: 30),
            HandScreenButton(),
          ],
        ),
      ),
    );
  }
}

class TopTextWidget extends StatelessWidget {
  const TopTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'hand_screen_txt'.tr,
        style:
            TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: kblack),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MarkWidgets extends StatefulWidget {
  const MarkWidgets({Key? key}) : super(key: key);

  @override
  State<MarkWidgets> createState() => _MarkWidgetsState();
}

class _MarkWidgetsState extends State<MarkWidgets> {
  int _current = 0;
  List<String> imageList = [
    'assets/images/mark1.jpg',
    'assets/images/mark2.jpg',
  ];

  bool isCyrillic(int index) {
    return index == 0; // Предположим, что 0 - это кириллица, а 1 - латиница
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          items: imageList
              .map((item) => Center(
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            height: 180.0,
            initialPage: 0,
            enableInfiniteScroll: false, // Отключение бесконечной прокрутки
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((entry) {
            int index = entry.key;
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 25,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCyrillic(_current)
                        ? 'hand_kgd_txt_new'.tr
                        : 'hand_kgd_txt'.tr,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        if (!isCyrillic(_current))
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[а-яА-Я ]')),
                        if (isCyrillic(_current))
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z ]')),
                        LengthLimitingTextInputFormatter(2),
                      ],
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        hintStyle: const TextStyle(
                            color: Colors.black54, fontFamily: 'RobotoReg'),
                        hintText: "seriya_txt".tr,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(9),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.black54, fontFamily: 'RobotoReg'),
                      hintText: "momer_txt".tr,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class HandScreenButton extends StatelessWidget {
  const HandScreenButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kblue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: () {
            _showDialog(context);
          },
          child: Text(
            'check_btn_txt'.tr,
            style: const TextStyle(fontSize: 20),
          )),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                ImageDialogWidget(),
                SizedBox(height: 15),
                qrInDialogWidget(),
                SizedBox(height: 15),
                InfoToMarkWidget(),
                SizedBox(height: 15),
                InfoToProductWidget(),
                SizedBox(height: 20),
                buttomInDialogWidget()
              ],
            ),
          ),
        ),
      );
    },
  );
}

class ImageDialogWidget extends StatelessWidget {
  const ImageDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: Image.asset('assets/images/scene.png'),
      ),
    );
  }
}

class qrInDialogWidget extends StatelessWidget {
  const qrInDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 25,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 70,
              child: Image.asset('assets/images/qr_image.png'),
            ),
            const Text(
              'Код присутствует в\nбазе акцизных марок',
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class InfoToMarkWidget extends StatelessWidget {
  const InfoToMarkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 25,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Информация о марке:',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Серия марки:  '),
                    SizedBox(height: 10),
                    Text('Номер марки:  '),
                    SizedBox(height: 5),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('839EC5'),
                    SizedBox(height: 10),
                    Text('АА 000000000'),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoToProductWidget extends StatelessWidget {
  const InfoToProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 25,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Информация о продукте ',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Организация:  '),
                    SizedBox(height: 10),
                    Text('Продукт:  '),
                    SizedBox(height: 10),
                    Text('Вид продукта:  '),
                    SizedBox(height: 5),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ТОО "Натур Продукт"'),
                    SizedBox(height: 10),
                    Text('Алкогольная продукция'),
                    SizedBox(height: 10),
                    Text('Водка'),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class buttomInDialogWidget extends StatelessWidget {
  const buttomInDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          decoration: BoxDecoration(
            color: kblue,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Text(
            'Продолжить',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
