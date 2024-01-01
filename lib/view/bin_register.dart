import 'package:flutter/material.dart';
import '../controller/bin_controller.dart';

class BinRegisterPage extends StatefulWidget {
  final String loginId;

  const BinRegisterPage({Key? key, required this.loginId}) : super(key: key);

  @override
  State<BinRegisterPage> createState() => _BinRegisterPage();
}

class _BinRegisterPage extends State<BinRegisterPage> {
  final TextEditingController aliasController = TextEditingController();

  final BinPageController _newBinController = BinPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register New Bin'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(
              labelText: "Alias",
            ),
            controller: aliasController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _newBinController.createBin(
                alias: aliasController.text,
                id: "",
                user_id: widget.loginId,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('New Bin Registration Successful'),
                ),
              );
            },
            child: const Text('Register Bin'),
          ),
        ],
      ),
    );
  }
}
