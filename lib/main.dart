import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            SizedBox(width: 16.0),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/images/menu.png'),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'قیمت به‌روز ارز',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(width: 12),
            Image.asset('assets/images/icon.png'),
            SizedBox(width: 16.0),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'نرخ ارز آزاد چیست؟ ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset('assets/images/q.png'),
                ],
              ),
              SizedBox(height: 12),
              Text(
                ' نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.',
                style: TextStyle(fontSize: 14),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
