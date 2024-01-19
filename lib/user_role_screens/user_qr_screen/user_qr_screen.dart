import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_test_site/supports/constant.dart';
import 'package:qr_code_test_site/user_role_screens/home_user.dart';
import 'package:qr_code_test_site/user_role_screens/user_qr_screen/user_enter_hand_screen.dart';
import 'package:qr_code_test_site/user_role_screens/user_qr_screen/user_qr_inner_screens/history_screen.dart';
import 'package:qr_code_test_site/qr_result/no_result_screen.dart';
import 'package:qr_code_test_site/qr_result/result_screen.dart';
import 'package:qr_code_test_site/services/api.dart';

class UserQrScreen extends StatefulWidget {
  const UserQrScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserQrScreenState();
}

class _UserQrScreenState extends State<UserQrScreen> {
  ApiService apiService = ApiService(
      'eyJhbGciOiJBMTI4S1ciLCJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwidHlwIjoiSldUIn0.Ie4sQO5vrcLetRllF1hJBEXBxaq2Zi1sMDocsQzhIu3QWgOywh8hwA.lKne9nlZ23S5CGYKfXK1bQ.nUfP718ya70UumIT0YYZOGpKRDoW7wLM-5XUg5OCIkH79ZlF-V-REkWHs2FUKEMg0l2GZLK_Px-tXjpqeW8oT-xWEI61WYj65Fwr7ir-8PzuR3gX7gooLywKAkH_BDDkvcEjEjRjlKC6WRpmqM5EVOf7-tZuPk6-4an5j-KrzCExYZHtRT6fLvrjNiMNCpTGAOF8_kvcyxeGlCcMNcGBNy6rqEB8XzUd9Lt9xSPzgwjbkflo_c2LsHYPhLrJtzLFv3cqN9MuLLBDAbIDdy2bge35FCWHk-aBbcCa1wVrI8vZNgx4sBi4vEjBh-emFnFsYEm7uQC83bQulAILJ-StsUkWDPYtd6s_qaRRhNdP1bcupf6pRNPPA26FF8JcCWiw4TbDsYvoud_XWmjVlQ06Hs3-iVNUg3ZjNNdDYVVXvuSwFuvry98mJ_AAFtU-0doX_NRJSLNv0YRZ-p6CYNgYW4lVd6QeQ0_ZPaenTpLaN6sPFi-nXJocpHyM1K8opE94DtewCcwKRtc9IvOa4hKIOG1pr9rsid4oFbnalt719xvaiECQy0ciFyhWE2Io-IjlIFQ92ch0qZ2DtoUVGd1Z0YYbgO9Qoxyg5tk58zwlD2H4KoZmbcIM5_L5P--i7-B9rKCFNTz4jY5_8393nRyZ95dO4PL0hnu8dzGA05k_CiSbUObYN6s9zg5J5bgN0F0xGgyABQ1_9oAwtrTFGZsHxSM5BkzhmFPWzvI_WbFURDSGBanIPto8fd9A1e6jSUnByXMZKvycZZpzKKRFbjABN07jXrn7264wOYn4I6wOXtyPA33Jg3v3bCOfKxZxWy9_peoC2xlxEwjAI-CYxZrZw7BdSfVh4OEGcmkYGgTWnBFbspveqmSNPBFc12pbwJBqKCCW2dxJC5ga-5JUmVvDMQ.7nvR_DvW3D_3qYdNDN7Yug');
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    // requestCameraPermission();
    if (controller != null) {
      controller!.resumeCamera();
    }
  }

  // Future<void> requestCameraPermission() async {
  //   var status = await Permission.camera.status;
  //   print('Camera permission status: $status');
  //   if (status.isDenied) {
  //     await Permission.camera.request();
  //   }
  // }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.pauseCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final qrButtonWith = MediaQuery.of(context).size.width * 0.40;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'appbar_qr_screen_txt'.tr,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: 17),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeUser()));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserEnterHandScreen(),
                  ));
                },
                icon: Icon(
                  Icons.keyboard_alt_outlined,
                  size: 30,
                  color: kblue,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0, right: 15, left: 15),
            child: Text(
              'qr_screen_txt_title'.tr,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
          //QR Scanner

          Expanded(flex: 8, child: _buildQrView(context)),

          //bottom Buttons
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      bool isFlashOn = snapshot.data ?? false;
                      return GestureDetector(
                        onTap: () async {
                          await controller?.toggleFlash();
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isFlashOn ? Icons.flash_on : Icons.flash_off,
                              size: 30,
                              color: isFlashOn ? null : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isFlashOn
                                  ? 'flash_icon_txt_on'.tr
                                  : 'flash_icon_txt_off'.tr,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserEnterHandScreen(),
                        ));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Image.asset('assets/images/keyboard.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'hand_scan_btn'.tr,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HistoryScreen(),
                        ));
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Image.asset('assets/images/Icon_history.png'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'buttom_qr_screen_history'.tr,
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 180.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: kblue,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    bool processingCode = false;

    controller.scannedDataStream.listen(
      (scanData) {
        if (!processingCode) {
          processingCode = true;
          result = scanData;

          if (result != null) {
            // Проверяем формат строки result.code
            if (_isValidCodeFormat(result!.code.toString())) {
              apiService
                  .checkScan(result!.code.toString())
                  .then((dynamic response) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      responseData: response.data,
                      controller: controller,
                    ),
                  ),
                ).then((_) {
                  processingCode =
                      false; // После завершения перехода снова разрешаем обработку кодов
                });
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoResultScreen(
                    controller: controller,
                  ),
                ),
              ).then((_) {
                processingCode =
                    false; // После завершения перехода снова разрешаем обработку кодов
              });
            }
          }
        }
      },
    );
  }

// Метод для проверки формата строки
  bool _isValidCodeFormat(String code) {
    // Создаем регулярное выражение для проверки первого формата (AA000000008 I9S4M58)
    final RegExp regex1 = RegExp(r'^[A-Z0-9]{11} [A-Z0-9]{7}$');

    // Создаем регулярное выражение для проверки второго формата (U019179d8651b994175b1727806c65446e2000000484419)
    final RegExp regex2 = RegExp(r'^U[0-9a-fA-F]{48}$');

    // Проверяем соответствие строки хотя бы одному из форматов
    return regex1.hasMatch(code) || regex2.hasMatch(code);
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
