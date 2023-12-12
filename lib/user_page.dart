import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget{
  @override
  State<UserPage> createState()=> _UserPageState();
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
}

class _UserPageState extends State<UserPage>{
  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
    );
    if (pickedDate!= null && pickedTime != null){
      setState(() {
        dateController.text =
        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')} "
            "${pickedTime.hour.toString().padLeft(2,'0')}:${pickedTime.minute.toString().padLeft(2,'0')}:00";
      });
    }
  }

  Future createUser(User user) async{
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;

    final json = user.toJson();

    await docUser.set(json);
    nameController.clear();
    ageController.clear();
    dateController.clear();
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Name",
            ),
            controller: nameController,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              labelText: "Age",
            ),
            controller: ageController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              labelText: "Date",
            ),
            keyboardType: TextInputType.datetime,
            readOnly: true,
            onTap: _selectDate,
            controller: dateController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: (){
                final user = User(
                  name : nameController.text,
                  age : ageController.text,
                  birthday : DateTime.parse(dateController.text),

                );

                createUser(user);

                Navigator.pop(context);
              },
              child: Text('Create'),
          ),
        ],
      ),
    );
  }
}