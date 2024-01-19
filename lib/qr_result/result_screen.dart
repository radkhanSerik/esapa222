import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_test_site/supports/constant.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> responseData;
  final QRViewController? controller;

  const ResultScreen({
    Key? key,
    required this.responseData,
    this.controller,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Map<String, dynamic>? firstProduct;

  @override
  void dispose() {
    // Этот метод вызывается при удалении виджета из дерева виджетов
    // Вызовите resumeCamera() при нажатии стрелки назад
    widget.controller?.resumeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = widget.responseData['items'];
    firstProduct = items.isNotEmpty ? items[0] : null;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: IconButton(
              icon: const Icon(
                Icons.cancel_outlined,
                size: 35,
                color: Colors.black87,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ImageDialogWidget(),
              const SizedBox(height: 15),
              const qrInDialogWidget(),
              const SizedBox(height: 15),
              Container(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Информация о марке:',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Серия марки:  ',
                                style: TextStyle(
                                  color: klightblue,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Номер марки:  ',
                                style: TextStyle(
                                  color: klightblue,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '839EC5',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: klightblue,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'АА 000000000',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: klightblue,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Информация о продукте ',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Организация:  ',
                                style: TextStyle(
                                  color: klightblue,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Продукт:  ',
                                style: TextStyle(
                                  color: klightblue,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Вид продукта:  ',
                                style: TextStyle(
                                  color: klightblue,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  firstProduct?['organization'] ??
                                      'No Product Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: klightblue,
                                    fontSize: 15,
                                  ),
                                  softWrap:
                                      true, // Разрешает перенос текста на новую строку
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  firstProduct?['productName'] ??
                                      'No Product Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: klightblue,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  firstProduct?['productGroup'] ??
                                      'No Product Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: klightblue,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const buttomInDialogWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageDialogWidget extends StatelessWidget {
  const ImageDialogWidget({
    Key? key,
  }) : super(key: key);

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
    Key? key,
  }) : super(key: key);

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
              ' Код присутствует в\nбазе акцизных марок',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

class buttomInDialogWidget extends StatelessWidget {
  const buttomInDialogWidget({
    Key? key,
  }) : super(key: key);

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
