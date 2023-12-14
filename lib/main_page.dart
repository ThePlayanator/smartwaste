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
      body: StreamBuilder( //real time update
        stream: readUsers(),
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

  Widget buildUser(User user) => ListTile(
    leading: CircleAvatar(child: Text(user.age)),
    title: Text(user.name),
    subtitle: Text(user.birthday.toIso8601String()),
  );

}