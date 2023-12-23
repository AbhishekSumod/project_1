import 'package:flutter/material.dart';

class detail extends StatelessWidget {
  final String? username;
  final String? address;
  final String? pincode;
  final String? phonenumber;

  detail({this.username, this.address, this.pincode, this.phonenumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username:',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              '$username',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Address:',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              '$address',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Pincode:',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              '$pincode',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Phonenumber:',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              '$phonenumber',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Handle the pay button click
                  // You can implement your payment logic here
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(width: 8.0),
                    Text(
                      'Pay Now',
                      style: TextStyle(fontSize: 20),
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
}
