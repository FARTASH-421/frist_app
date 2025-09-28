import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frist_app/Module/Currency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Vazirmatn',
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'Vazirmatn',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa'), // Persion
      ],
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  void getResponse() {
    var url =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";
    http.get(Uri.parse(url)).then((value) {
      if (currency.isEmpty) {
        if (value.statusCode == 200) {
          List jsonList = convert.jsonDecode(value.body);
          if (jsonList.isNotEmpty) {
            for (var item in jsonList) {
              setState(() {
                Currency myCurr = Currency(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  changes: item['changes'],
                  status: item['status'],
                );
                currency.add(myCurr);
              });
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getResponse();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        actions: [
          SizedBox(width: 16.0),
          Image.asset('assets/images/icon.png'),
          SizedBox(width: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'قیمت به‌روز ارز',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/menu.png'),
            ),
          ),
          SizedBox(width: 16.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/q.png'),
                SizedBox(width: 12.0),
                Text(
                  'نرخ ارز آزاد چیست؟ ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            SizedBox(height: 18),
            Text(
              ' نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.',
              style: Theme.of(context).textTheme.bodyMedium,
              textDirection: TextDirection.rtl,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Container(
                height: 34,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 133, 133, 133),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'نام آزاد ارز',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'قیمت',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'تغییر',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 430,
              width: double.infinity,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return (index % 10 == 0) ? Add() : SizedBox.shrink();
                },
                physics: BouncingScrollPhysics(),
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int postion) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 2,
                    ),
                    child: MyItems(currency: currency[postion]),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 232, 232, 232),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Color.fromARGB(255, 202, 195, 255),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            _showSankBar(context, "در حال بروز رسانی..."),
                        icon: Icon(
                          CupertinoIcons.refresh_bold,
                          color: Colors.black,
                          size: 20,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "بروز رسانی",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "آخرین بروز رسانی ${_getTime()}",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTime() {
    return "20:45";
  }
}

void _showSankBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
    ),
    duration: Duration(seconds: 5),
    backgroundColor: Colors.green,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class MyItems extends StatelessWidget {
  Currency currency;
  MyItems({required this.currency, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(currency.title, style: Theme.of(context).textTheme.bodyMedium),
          Text(currency.price, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            currency.changes,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: currency.status == "p" ? Colors.green : Colors.red,
            ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 255, 73, 73),
        boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "تبلیغات شما اینجاست!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Image.asset('./assets/images/icon.png', scale: 0.4),
        ],
      ),
    );
  }
}
