import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:japfood/ConvertedApi.dart';
import 'package:japfood/info.dart';
import 'package:japfood/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ConvertedApi> apiList = [];
  List<ConvertedApi> uniqueApiList = []; // List to store unique API elements

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 182, 187),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_rounded),
            SizedBox(width: 20),
            Text('Food Menu'),
          ],
        ),
        actions: <Widget>[
          _buildQRCodeWidget(), // Widget to display QR code number
          SizedBox(
              width:
                  10), // Add some spacing between QR code widget and Login button
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
          ),
          SizedBox(
              height: 10), // Increased space between search box and offer box
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              padding: EdgeInsets.all(16), // Increased padding for a bigger box
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.tealAccent, Colors.teal], // Gradient colors
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.network(
                    // Displaying the image of the first item of "Biriyani" category
                    apiList
                            .firstWhere((element) =>
                                element.CategoryName?.toLowerCase() ==
                                "biriyani")
                            .CategoryImage ??
                        "",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Special Offer: \₹110', // Offer price
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Increased font size for a bigger text
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  uniqueApiList.length > 10
                      ? 10
                      : uniqueApiList
                          .length, // Limit the number of items displayed
                  (index) {
                    ConvertedApi firstCategoryElement = apiList.firstWhere(
                      (element) =>
                          element.CategoryName ==
                          uniqueApiList[index].CategoryName,
                      orElse: () =>
                          ConvertedApi(CategoryName: "", CategoryImage: ""),
                    );

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Info(apiList: uniqueApiList[index]),
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    child: uniqueApiList[index].CategoryImage !=
                                                null &&
                                            uniqueApiList[index]
                                                .CategoryImage!
                                                .isNotEmpty
                                        ? Image.network(
                                            "${uniqueApiList[index].CategoryImage}",
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          )
                                        : Placeholder(),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  uniqueApiList[index].CategoryName ?? "",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.qr_code),
          SizedBox(width: 5),
          Text(
            '12345', // Replace '12345' with your unique QR code number
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getApiData() async {
    try {
      String url = "http://server-hbua.onrender.com/product";
      var result = await http.get(Uri.parse(url));
      if (result.statusCode == 200) {
        setState(() {
          apiList = (jsonDecode(result.body) as List)
              .map((item) => ConvertedApi.fromJson(item))
              .toList();

          // Filter out duplicates based on category name
          uniqueApiList =
              apiList.fold([], (List<ConvertedApi> previousValue, element) {
            if (!previousValue
                .any((e) => e.CategoryName == element.CategoryName)) {
              previousValue.add(element);
            }
            return previousValue;
          });
        });
      } else {
        print("Failed to fetch data: ${result.statusCode}");
        // Handle error: Display a message or retry data fetching
      }
    } catch (e) {
      print("Error fetching data: $e");
      // Handle error: Display a message or retry data fetching
    }
  }
}

void main() {
  runApp(MaterialApp(
    title: 'QR Code Demo',
    home: HomeScreen(),
  ));
}
