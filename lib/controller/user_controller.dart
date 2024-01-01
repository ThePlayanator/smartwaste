import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class UserPageController {

  // Method to create a user
  Future<void> createUser({
    required String username,
    required String password,
    required String fullname,
    required String ic,
    required String phoneNumber,
    required String id,

  }) async {
    // Create user id with auto increment
    try {
      // Get the total number of id in the users collection
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await collectionReference.get();
      int numberOfDocuments = querySnapshot.size;

      if (querySnapshot.size == 0) {
        print('Collection is empty.');
        String leading = "U";
        String formattedInteger = numberOfDocuments.toString().padLeft(5, '0');
        id = "$leading${formattedInteger}1";
      } else {
        print('Collection is not empty.');
        String leading = "U";
        int idplacholder = 0;

        // Access the latest document
        QuerySnapshot latestDocument = await FirebaseFirestore.instance
            .collection('users')
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
    final User user = User(
      username: username,
      password: password,
      fullname: fullname,
      ic: ic,
      phoneNumber: phoneNumber,
      user_id: id,
    );

    // Set the desired path of a collection
    final docUser = FirebaseFirestore.instance.collection('users');
    // Convert data to Json method and write into database
    final json = user.toJson();
    await docUser.doc(id).set(json);
  }

  // Handles user login
  Future<bool> loginUser(
      {required String username, required String password}) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (query.docs.isNotEmpty) {
        // User found, perform login logic
        print('Login successful!');
        return true;
      } else {
        // User not found, show an error message
        print('Invalid username or password');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  Future<String> getUserLoginId(
      {required String username, required String password}) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (query.docs.isNotEmpty) {
        // User ID found, get the 'id' field value
        String loginId = query.docs.first.get('id');
        print('Login successful! User ID: $loginId');
        return loginId;
      } else {
        // User ID not found, show an error message
        print('Invalid username or password');
        return 'Invalid username or password';
      }
    } catch (e) {
      print('Error during login: $e');
      return 'Failed to retrieve user ID';
    }
  }

}
