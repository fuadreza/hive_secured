import 'package:flutter/material.dart';
import 'package:hive_secured/service/hive_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String? savedData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Secured'),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: 'Enter some text',
                  labelText: 'Text',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      if (_controller.text.isNotEmpty) {
                        await hive.saveData(_controller.text).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Save data success!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        });
                      }
                    },
                    icon: const Icon(Icons.save),
                  ),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                onPressed: () async {
                  String data = await hive.loadData();
                  setState(() {
                    savedData = data;
                  });
                },
                child: const Text('Load Saved Data'),
              ),
              const SizedBox(height: 20),
              const Divider(height: 0, thickness: 1),
              const SizedBox(height: 20),
              const Text(
                'Saved Secure Data',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 10),
              Text(savedData ?? '--'),
            ],
          ),
        ),
      ),
    );
  }
}
