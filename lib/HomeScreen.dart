import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:japfood/ConvertedApi.dart';
//import 'package:japfood/UserApi.dart';
import 'package:japfood/info.dart';
import 'package:japfood/login.dart';
import 'package:japfood/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//class _HomeScreenState extends State<HomeScreen> {
class _HomeScreenState extends State<HomeScreen> {
  List<ConvertedApi> apiList = []; // Initialize as an empty list
  //List<UserApi> UserApiList = [];

  get index => null;

  @override
  void initState() {
    super.initState();
    getApiData();
    // getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_rounded),
            SizedBox(
              width: 20,
            ),
            Text('food menu'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
              //  login(UserApiList: UserApiList[index])));
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
        children: [getListView()],
      ),
    );
  }

  Widget getListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: apiList.length, // Use the length of apiList
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Handle item tap here
              // For example, you can inavigate to a new screen or show a dialog
              //print("Tapped on ${apiList[index].name}");
              /*Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => descriptionpage()));*/
              Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Info(
                          apiList:
                              apiList[index])) // Use the correct class name
                  );
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.6),
                      offset: Offset(
                        0.0,
                        10.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: -6.0,
                    ),
                  ],
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0),
                      BlendMode.multiply,
                    ),
                    image: NetworkImage("${apiList[index].Image}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        /*child: Text(
                      apiList[index].name ??
                          "nothing", // Display the name from API data
                      style: TextStyle(
                        fontSize: 19,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),*/
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white10.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                SizedBox(width: 7),
                                Text("${apiList[index].star}"),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.food_bank_outlined,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                                SizedBox(width: 7),
                                Text("${apiList[index].name}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }

  Future<void> getApiData() async {
    String url = "http://localhost:3000/product";
    var result = await http.get(Uri.parse(url));
    if (result.statusCode == 200) {
      apiList = (jsonDecode(result.body) as List)
          .map((item) => ConvertedApi.fromJson(item))
          .toList(); // Use toList() to convert
      setState(() {});
    } else {
      // Handle API error here
      print("Failed to fetch data: ${result.statusCode}");
    }
  }

  /* Future<void> getUser() async {
    String url = "http://localhost:3000/user";+
    var result = await http.get(Uri.parse(url));
    if (result.statusCode == 200) {
      UserApiList = (jsonDecode(result.body) as List)
          .map((item) => UserApi.fromJson(item))
          .toList(); // Use toList() to convert
      setState(() {});
    } else {
      // Handle API error here
      print("Failed to fetch data: ${result.statusCode}");
    }
  }*/

  //descriptionpage() {}
}
