import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/schedule.dart';

class SchedulePageController {
  // Method to create a user
  Future<bool> createPickup({
    required String date,
    required String status,
    required String id,
  }) async {
    // Create user id with auto increment
    try {
      // Get the total number of id in the users collection
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('Schedule');

      QuerySnapshot querySnapshot = await collectionReference.get();
      int numberOfDocuments = querySnapshot.size;

      if (querySnapshot.size == 0) {
        print('Collection is empty.');
        String leading = "S";
        String formattedInteger = numberOfDocuments.toString().padLeft(5, '0');
        id = "$leading${formattedInteger}1";
      } else {
        print('Collection is not empty.');
        String leading = "S";
        int idplacholder = 0;

        // Access the latest document
        QuerySnapshot latestDocument = await FirebaseFirestore.instance
            .collection('Schedule')
            .orderBy('id', descending: true)
            .limit(1)
            .get();

        DocumentSnapshot latestData = latestDocument.docs.first;
        Map<String, dynamic> data = latestData.data() as Map<String, dynamic>;

        String latestID = data['id'];
        print(latestID);

        // Detect integer from String id, assign to a variable,
        // Increase the variable value by 1
        // Combine with leading variable to create new ID
        RegExp regExp = RegExp(r'\d+');
        Match? match = regExp.firstMatch(latestID);

        if (match != null) {
          String numericPartString = match.group(0)!;
          idplacholder = int.parse(numericPartString) + 1;
        } else {
          print('No numeric part found in the id.');
        }

        String formattedInteger = idplacholder.toString().padLeft(5, '0');
        id = leading + formattedInteger;
      }

      // Create instance of Schedule class and initialize its properties with values
      // passed as arguments
      final Schedule pickup = Schedule(
        schedule_id: id,
        date: date,
        status: status,
      );

      // Set the desired path of a collection
      final docPickup = FirebaseFirestore.instance.collection('Schedule');
      // Convert data to Json method and write into database
      final json = pickup.toJson();
      await docPickup.doc(id).set(json);
      return true;
    } catch (e) {
      print('Error checking collection: $e');
      return false;
    }
  }
}
