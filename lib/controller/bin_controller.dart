import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/bin.dart';

class BinPageController {

  // Method to create a user
  Future<void> createBin({
    required String alias,
    required String id,
    required String user_id,

  }) async {
    // Create user id with auto increment
    try {
      // Get the total number of id in the users collection
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('bin');

      QuerySnapshot querySnapshot = await collectionReference.get();
      int numberOfDocuments = querySnapshot.size;

      if (numberOfDocuments == 0) {
        print('Collection is empty.');
        String leading = "B";
        String formattedInteger = numberOfDocuments.toString().padLeft(5, '0');
        id = "$leading${formattedInteger}1";
      } else {
        print('Collection is not empty.');
        String leading = "B";
        int idplacholder = 0;

        // Access the latest document
        QuerySnapshot latestDocument = await FirebaseFirestore.instance
            .collection('bin')
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
    } catch (e) {
      print('Error checking collection: $e');
    }

    // Create instance of User class and initialize its properties with values
    // passed as arguments
    final Bin bin = Bin(
      alias: alias,
      bin_id: id,
      user_id: user_id,
    );

    // Set the desired path of a collection
    final docUser = FirebaseFirestore.instance.collection('bin');
    // Convert data to Json method and write into database
    final json = bin.toJson();
    await docUser.doc(id).set(json);
  }
}
