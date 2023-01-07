import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_data/views/list_people.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowPeople(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const usernameKey = 'username';
  List<String> usernameList = [];

  Future saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(usernameKey, ['Phanith', 'Dara']);
    readData();
  }

  Future readData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      usernameList = (preferences.getStringList(usernameKey) ?? ['No Data']);
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: List.generate(usernameList.length, (index) {
                return Text(usernameList[index]);
              }),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Colors.red,
              child: const Text('Save'),
              onPressed: () {
                saveData();
              },
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Colors.red,
              child: const Text('Read'),
              onPressed: () {
                readData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
