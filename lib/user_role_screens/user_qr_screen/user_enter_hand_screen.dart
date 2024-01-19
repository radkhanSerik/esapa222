import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/qr_result/no_result_screen.dart';
import 'package:qr_code_test_site/qr_result/result_screen.dart';
import 'package:qr_code_test_site/services/api.dart';
import 'package:qr_code_test_site/user_role_screens/user_qr_screen/user_qr_screen.dart';
import 'package:qr_code_test_site/supports/constant.dart';
import 'package:qr_code_test_site/user_role_screens/home_user.dart';

class UserEnterHandScreen extends StatefulWidget {
  const UserEnterHandScreen({super.key});

  @override
  State<UserEnterHandScreen> createState() => _UserEnterHandScreenState();
}

class _UserEnterHandScreenState extends State<UserEnterHandScreen> {
  // Создайте контроллеры для TextField
  final TextEditingController seriesController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  ApiService apiService = ApiService(
      'eyJhbGciOiJBMTI4S1ciLCJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwidHlwIjoiSldUIn0.Ie4sQO5vrcLetRllF1hJBEXBxaq2Zi1sMDocsQzhIu3QWgOywh8hwA.lKne9nlZ23S5CGYKfXK1bQ.nUfP718ya70UumIT0YYZOGpKRDoW7wLM-5XUg5OCIkH79ZlF-V-REkWHs2FUKEMg0l2GZLK_Px-tXjpqeW8oT-xWEI61WYj65Fwr7ir-8PzuR3gX7gooLywKAkH_BDDkvcEjEjRjlKC6WRpmqM5EVOf7-tZuPk6-4an5j-KrzCExYZHtRT6fLvrjNiMNCpTGAOF8_kvcyxeGlCcMNcGBNy6rqEB8XzUd9Lt9xSPzgwjbkflo_c2LsHYPhLrJtzLFv3cqN9MuLLBDAbIDdy2bge35FCWHk-aBbcCa1wVrI8vZNgx4sBi4vEjBh-emFnFsYEm7uQC83bQulAILJ-StsUkWDPYtd6s_qaRRhNdP1bcupf6pRNPPA26FF8JcCWiw4TbDsYvoud_XWmjVlQ06Hs3-iVNUg3ZjNNdDYVVXvuSwFuvry98mJ_AAFtU-0doX_NRJSLNv0YRZ-p6CYNgYW4lVd6QeQ0_ZPaenTpLaN6sPFi-nXJocpHyM1K8opE94DtewCcwKRtc9IvOa4hKIOG1pr9rsid4oFbnalt719xvaiECQy0ciFyhWE2Io-IjlIFQ92ch0qZ2DtoUVGd1Z0YYbgO9Qoxyg5tk58zwlD2H4KoZmbcIM5_L5P--i7-B9rKCFNTz4jY5_8393nRyZ95dO4PL0hnu8dzGA05k_CiSbUObYN6s9zg5J5bgN0F0xGgyABQ1_9oAwtrTFGZsHxSM5BkzhmFPWzvI_WbFURDSGBanIPto8fd9A1e6jSUnByXMZKvycZZpzKKRFbjABN07jXrn7264wOYn4I6wOXtyPA33Jg3v3bCOfKxZxWy9_peoC2xlxEwjAI-CYxZrZw7BdSfVh4OEGcmkYGgTWnBFbspveqmSNPBFc12pbwJBqKCCW2dxJC5ga-5JUmVvDMQ.7nvR_DvW3D_3qYdNDN7Yug');

  // void handleCheckButtonPressed(String series, String number) {
  //   // Вызовите метод handCheckScan из apiService
  //   apiService.handCheckScan(series, number).then((response) {
  //     // Обработка ответа, если необходимо
  //     // print('Response: $response');
  //   }).catchError((error) {
  //     // Обработка ошибки, если необходимо
  //     print('Error: $error');
  //   });
  // }

  void handleCheckButtonPressed(String series, String number) {
    // Вызовите метод handCheckScan из apiService
    apiService.handCheckScan(series, number).then((response) {
      // Обработка ответа
      if (response.data != null) {
        String status = response.data!['items'] != null
            ? response.data!['items'][0]['status']
            : null;

        if (status == 'Получен производителем или импортером') {
          // Переходим на ResultScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                responseData: response.data!,
              ),
            ),
          );
        } else if (status == 'Номер отсутствует в БД' ||
            (response.data!['items'] == null)) {
          // Переходим на NoResultScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NoResultScreen(),
            ),
          );
        } else {
          // Обработка других статусов
          print('Unhandled status: $status');
        }
      } else {
        // Обработка случая, когда ответ не содержит ожидаемых данных
        print('Unexpected response format');
      }
    }).catchError((error) {
      // Обработка ошибки
      print('Error: $error');
    });
  }

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
                    builder: (context) => const UserQrScreen(),
                  ));
                },
                icon: Icon(
                  Icons.qr_code_scanner_sharp,
                  size: 30,
                  color: kblue,
                )),
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeUser()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopTextWidget(),
            MarkWidgets(
              seriesController: seriesController,
              numberController: numberController,
            ),
            SizedBox(height: 30),
            HandScreenButton(
              seriesController: seriesController,
              numberController: numberController,
              onPressedCallback: handleCheckButtonPressed,
            ),
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
  final TextEditingController seriesController;
  final TextEditingController numberController;
  const MarkWidgets({
    Key? key,
    required this.seriesController,
    required this.numberController,
  }) : super(key: key);

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
                      controller: widget.seriesController,
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
                    controller: widget.numberController,
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

class HandScreenButton extends StatefulWidget {
  HandScreenButton({
    super.key,
    required this.seriesController,
    required this.numberController,
    required this.onPressedCallback,
  });

  // Объявите контроллеры
  final TextEditingController seriesController;
  final TextEditingController numberController;
  final Function(String series, String number) onPressedCallback;

  @override
  State<HandScreenButton> createState() => _HandScreenButtonState();
}

class _HandScreenButtonState extends State<HandScreenButton> {
  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
            // Получите значения из контроллеров
            String series = widget.seriesController.text;
            String number = widget.numberController.text;
            // Проверка на заполненность хотя бы одного поля
            if (series.isEmpty && number.isEmpty) {
              // Если ни одно поле не заполнено, покажем SnackBar
              showSnackBar("Заполните поля серии и номера!");
            } else if (series.length < 2) {
              // Если длина серии менее 2 символов, покажем SnackBar
              showSnackBar("Длина серии должна быть 2 символа");
            } else if (number.length < 9) {
              // Если длина номера менее 9 символов, покажем SnackBar
              showSnackBar("Неверная длина номера");
            } else {
              // Вызовите функцию onPressedCallback с передачей значений
              widget.onPressedCallback(series, number);
            }
          },
          child: Text(
            'check_btn_txt'.tr,
            style: const TextStyle(fontSize: 20),
          )),
    );
  }
}
