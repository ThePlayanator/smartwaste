/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartwaste/user_page.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<MainPage> createState()=> _MainPageState();
}

class User{
  String id;
  final String name;
  final String age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'age' : age,
    'birthday' : birthday,
  };

  static User fromJson(Map<String,dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    age: json['age'],
    birthday: (json['birthday'] as Timestamp).toDate(),
  );

}

class _MainPageState extends State<MainPage>{
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: FutureBuilder<User?>( //real time update
        future: readUser(),
        builder: (context, snapshot){
 if (snapshot.hasError){
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData){
            final users = snapshot.data!;

            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }



          if (snapshot.hasError){
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData){
            final user = snapshot.data;

            return user == null
                ? Center(child: Text('No User'))
                : buildUser(user);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context)=> const UserPage(),
          ),
          );
        },
      ),
    );
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
  .collection('users')
      .snapshots() // All documents within a collection
      .map((snapshot) =>
  snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Future<User?> readUser() async {
    // Get single document by ID
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc('w6o5gWq4vqaZC3XpugZL');
    final snapshot= await docUser.get();

    if (snapshot.exists){
      return User.fromJson(snapshot.data()!);
    }
  }

  Widget buildUser(User user) => ListTile(
    leading: CircleAvatar(child: Text(user.age)),
    title: Text(user.name),
    subtitle: Text(user.birthday.toIso8601String()),
  );

}

*/
