import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpDelScreen extends StatefulWidget {
  const UpDelScreen({super.key});

  @override
  State<UpDelScreen> createState() => _UpDelScreenState();
}

class _UpDelScreenState extends State<UpDelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Firebase CRUD Update & Delete'),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final docUser = FirebaseFirestore.instance
                    .collection('users') //specify collection
                    .doc('3Slel9pVnC4fh7Of7LZS'); // specify documents

                /*//Update specific fields
                docUser.update({
                  // Kalau ada dalam punya dalam guna dot notation
                  // Ex: 'name.firstname' : 'details'
                  'name' : 'hensem',
                });*/

                //Delete specific fields
                docUser.update({
                  'country': FieldValue.delete(),
                });

                docUser.delete(); // Delete whole data based on specified c&d
                // guna docUser.set -> set all fields into apa yang kita nak
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
