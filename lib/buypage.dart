import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:japfood/ConvertedApi.dart';
import 'package:japfood/detail.dart';
import 'package:japfood/loginApi.dart';

class buypage extends StatefulWidget {
  final ConvertedApi apiList;
  final int count;
  final int result;

  const buypage({
    Key? key,
    required this.apiList,
    required this.count,
    required this.result,
  }) : super(key: key);

  @override
  State<buypage> createState() => _buypageState();
}

class _buypageState extends State<buypage> {
  String? loggedUserName;
  String? loggedEmail;

  final TextEditingController address = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchLastLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    int? price = widget.apiList.price ?? 0;
    String? name = widget.apiList.name;
    int count = widget.count;
    int result = widget.result;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.orangeAccent),
      title: 'Info',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              width: 400,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.6),
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                  ),
                ],
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0),
                    BlendMode.multiply,
                  ),
                  image: NetworkImage(widget.apiList.Image ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              child: Row(
                children: [
                  Text(
                    'Total number of products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                  Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              child: Row(
                children: [
                  Text('Total cost :', style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Text(
                    '₹$result',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(width: 30),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Shipping Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('ADDRESS'),
                  TextField(
                    controller: address,
                    decoration: InputDecoration(
                      hintText: 'Enter The address',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('PINCODE'),
                  TextField(
                    controller: pincode,
                    decoration: InputDecoration(
                      hintText: 'Enter The pincode',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('PHONE NUMBER'),
                  TextField(
                    controller: phonenumber,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter The phone number',
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: navigateToDetailPage,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Proceed To Payment',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  SizedBox(width: 8), // Added spacing
                  Text(
                    'Last Logged User: $loggedUserName\nEmail: $loggedEmail',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchLastLoggedInUser() async {
    String url = "http://localhost:3000/login";
    var result = await http.get(Uri.parse(url));

    if (result.statusCode == 200) {
      List<loginApi> loginData = (jsonDecode(result.body) as List)
          .map((item) => loginApi.fromJson(item))
          .toList();

      if (loginData.isNotEmpty) {
        loginData.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        setState(() {
          loggedUserName = loginData[0].UserName;
          loggedEmail = loginData[0].Email;
        });
      }
    } else {
      print("Failed to fetch last logged-in user data: ${result.statusCode}");
    }
  }

  void navigateToDetailPage() async {
    await fetchLastLoggedInUser();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => detail(
          username: loggedUserName ?? 'No user logged in.',
          address: address.text,
          pincode: pincode.text,
          phonenumber: phonenumber.text,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: buypage(
      apiList: ConvertedApi(), // Provide your ConvertedApi instance
      count: 0,
      result: 0,
    ),
  ));
}
