import 'package:flutter/material.dart';
import 'package:smartwaste/view/bin_register.dart';

import 'detailed_status.dart';

class BinPage extends StatefulWidget {
  final String loginId;

  const BinPage({super.key, required this.loginId});

  @override
  State<BinPage> createState() => _BinPage();
}

class _BinPage extends State<BinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bin List'),
        ),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BinRegisterPage(loginId: widget.loginId)),
                  );
                },
                child: Text('Register New Bin')),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const detailedStatusPage()),
              );
              // Handle tap for CardLocation
              print('Bin List Tapped!');
            },
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.blue, size: 60.0),
                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BIN 01',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Display Location',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ])
    );
  }
}
