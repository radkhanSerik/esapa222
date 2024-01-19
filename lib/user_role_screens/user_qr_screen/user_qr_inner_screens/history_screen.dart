import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_test_site/supports/constant.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, String>> myData = [
    {
      'date': 'Май 22, 2023',
      'organizationName': 'ТОО "Натур Продукт"',
      'series': ' 839EC5',
      'number': 'AA 000000033',
    },
    {
      'date': 'Апрель 28, 2023',
      'organizationName': 'ТОО "Натур Продукт"',
      'series': ' 839EC5',
      'number': 'AA 000000045',
    },
    {
      'date': 'Сентябрь 10, 2023',
      'organizationName': 'ТОО "Натур Продукт"',
      'series': ' 839EC5',
      'number': 'AA 000000013',
    },
    {
      'date': 'Декабрь 24, 2023',
      'organizationName': 'ТОО "Натур Продукт"',
      'series': ' 839EC5',
      'number': 'AA 000000007',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appbar_txt_history'.tr),
      ),
      body: ListView.builder(
        itemCount: myData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListBuilderHistory(
            myData: myData,
            index: index,
          );
        },
      ),
    );
  }
}

class ListBuilderHistory extends StatelessWidget {
  const ListBuilderHistory({
    Key? key,
    required this.myData,
    required this.index,
  }) : super(key: key);

  final List<Map<String, String>> myData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' ${myData[index]['date']}',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'card_organization_txt'.tr,
                        style: TextStyle(
                          color: kblueTextHistSubtitle,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${myData[index]['organizationName']}',
                        style: TextStyle(
                            color: kblueTextHistTitle,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        'card_seria_txt'.tr,
                        style: TextStyle(
                          color: kblueTextHistSubtitle,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '${myData[index]['series']}',
                        style: TextStyle(
                          color: kblueTextHistSubtitle,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        'card_nomer_txt'.tr,
                        style: TextStyle(
                          color: kblueTextHistSubtitle,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '${myData[index]['number']}',
                        style: TextStyle(
                          color: kblueTextHistSubtitle,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Divider(
                        // Добавление разделителя
                        height: 1,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
