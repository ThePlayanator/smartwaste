import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartwaste/view/detailed_status.dart';

class BinPage extends StatefulWidget {
  const BinPage({super.key});

  @override
  State<BinPage> createState() => _BinPage();
}

class Bin {
  //String? location;
  double temperature;
  double weight;
  String alias;

  //String userId;

  Bin(this.temperature, this.weight, this.alias);

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'weight': weight,
        'alias': alias,
      };

  Future createBinId() async {
    String id = '';
    try {
      // Replace 'your_collection' with the actual name of your collection

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('bin');

      QuerySnapshot querySnapshot = await collectionReference.get();
      int numberOfDocuments = querySnapshot.size;

      if (querySnapshot.size == 0) {
        print('Collection is empty.');
        String leading = "b";
        String formattedInteger = numberOfDocuments.toString().padLeft(5, '0');
        id = leading + formattedInteger + "1";
        return id;
      } else {
        print('Collection is not empty.');
        print(numberOfDocuments);
        String leading = "b";
        String formattedInteger = numberOfDocuments.toString().padLeft(5, '0');
        id = leading + formattedInteger;
        return id;
      }
    } catch (e) {
      print('Error checking collection: $e');
    }
  }

  Future createBin(Bin bin, String id) async {
    try {
      final newBin = FirebaseFirestore.instance.collection('bin');

      final json = bin.toJson();

      await newBin.doc(id).set(json);
      print('Document created with ID : $id');
    } catch (e) {
      print('Error creating Document: $e');
    }
  }
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.delete_outline, color: Colors.blue, size: 60.0),
                    SizedBox(height: 16),
                    Column(
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
