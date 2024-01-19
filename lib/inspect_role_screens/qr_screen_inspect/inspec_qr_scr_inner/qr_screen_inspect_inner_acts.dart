import 'package:flutter/material.dart';
import 'package:qr_code_test_site/inspect_role_screens/qr_screen_inspect/inspec_qr_scr_inner/qr_screen_inner_history.dart';
import 'package:qr_code_test_site/supports/constant.dart';

class QrScreenInspectActsHistory extends StatefulWidget {
  const QrScreenInspectActsHistory({super.key});

  @override
  State<QrScreenInspectActsHistory> createState() =>
      _QrScreenInspectActsHistoryState();
}

class _QrScreenInspectActsHistoryState
    extends State<QrScreenInspectActsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(),
      ),
      body: Column(
        children: [
          TitleTextWidget(),
          Expanded(
            child: ListActsWidget(),
          )
        ],
      ),
    );
  }
}

class AppBarText extends StatelessWidget {
  const AppBarText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'История проверок',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black87, fontSize: 17),
    );
  }
}

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 50,
            ),
            Text(
              '№ акта',
              style: TextStyle(
                color: kblue,
                fontSize: 16,
              ),
            ),
            Text(
              'Дата создание',
              style: TextStyle(
                color: kblue,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Divider(
            height: 20,
            color: kblue,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class ListActsWidget extends StatelessWidget {
  final List<Map<String, String>> data = [
    {'title': '1', 'subtitle': '111', 'date': '20.10.2023'},
    {'title': '2', 'subtitle': '122', 'date': '20.10.2023'},
    {'title': '3', 'subtitle': '123', 'date': '20.10.2023'},
    {'title': '4', 'subtitle': '124', 'date': '20.10.2023'},
    {'title': '5', 'subtitle': '125', 'date': '20.10.2023'},
  ];
  ListActsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // Переход на вторую страницу при нажатии
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QrScreenInnerHistory(
                    subtitle: data[index]['subtitle'] ?? '',
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      data[index]['title'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      data[index]['subtitle'] ?? '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      data[index]['date'] ?? '',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
