import 'package:flutter/material.dart';
import 'package:qr_code_test_site/supports/constant.dart';

class QrScreenInnerHistory extends StatelessWidget {
  final String subtitle;

  QrScreenInnerHistory({required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Акт № $subtitle',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: ListViewBuilderWidget(),
      ),
    );
  }
}

class ListViewBuilderWidget extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      'dateTime': '18.05.2023 16:42',
      'productName': 'Водка “Синяя гора легкая”',
      'markNumber': 'Номер марки : AA 000000000',
      'brand': 'Кокшетауская минеральная',
      'legal': 'yes',
    },
    {
      'dateTime': '19.05.2023 14:30',
      'productName': 'Вино “Красная роза”',
      'markNumber': 'Номер марки : BB 111111111',
      'brand': 'Астана Винери',
      'legal': 'no',
    },
    {
      'dateTime': '18.05.2023 16:42',
      'productName': 'Водка “Синяя гора легкая”',
      'markNumber': 'Номер марки : AA 000000000',
      'brand': 'Кокшетауская минеральная',
      'legal': 'yes',
    },
    {
      'dateTime': '18.05.2023 16:42',
      'productName': 'Водка “Синяя гора легкая”',
      'markNumber': 'Номер марки : AA 000000000',
      'brand': 'Кокшетауская минеральная',
      'legal': 'yes',
    },
    {
      'dateTime': '19.05.2023 14:30',
      'productName': 'Вино “Красная роза”',
      'markNumber': 'Номер марки : BB 111111111',
      'brand': 'Астана Винери',
      'legal': 'no',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        String legalStatus = data[index]['legal'] ?? 'no';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 0.1,
                  blurRadius: 30,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: legalStatus == 'yes'
                      ? Image.asset('assets/images/act_yes.png')
                      : Image.asset('assets/images/act_no.png'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text(
                      data[index]['dateTime'] ?? '',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      data[index]['productName'] ?? '',
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                    ),
                    SizedBox(height: 10),
                    Text(
                      data[index]['markNumber'] ?? '',
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                    ),
                    SizedBox(height: 10),
                    Text(
                      data[index]['brand'] ?? '',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
