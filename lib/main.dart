import 'package:flutter/material.dart';
import 'package:japfood/HomeScreen.dart';

void main() {
  runApp(MyAPP());
}

class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FOOD MENU',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orangeAccent,
        ),
        home: HomeScreen());
  }
}
//"${apiList[index].name}"
