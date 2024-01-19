import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_test_site/supports/constant.dart';

class NoResultScreen extends StatefulWidget {
  final QRViewController? controller;

  const NoResultScreen({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  State<NoResultScreen> createState() => _NoResultScreenState();
}

class _NoResultScreenState extends State<NoResultScreen> {
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
    // List<dynamic> items = widget.responseData['items'];
    // firstProduct = items.isNotEmpty ? items[0] : null;

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
        child: const SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImageDialogWidget(),
              SizedBox(height: 15),
              qrInDialogWidget(),
              SizedBox(height: 15),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Информация о марке ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.black54),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'УКМ с таким кодом не найдена',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              buttomInDialogWidget(),
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
        child: Image.asset('assets/images/sceneNo.png'),
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
              ' Код отсутствует в\nбазе акцизных марок',
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
            color: Colors.red,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Text(
            'Продолжить',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
