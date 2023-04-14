import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ログイン'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _email = "";
  String _password = "";
  String _token = "";

  void requestPostSigninAPI() async {
    final response = await http.post(Uri.parse("http://10.0.2.2:3000/signin/"), body: {
      "email": _email,
      "password": _password,
    });
    setState(() {
      _token = jsonDecode(response.body)['token'] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Spacer(),
            Text(_token, maxLines: 1,),
            TextField(
              decoration: const InputDecoration(
                  labelText: "email"
              ),
              onChanged: (text) {
                setState(() {
                  _email = text;
                });
              },
            ),
            const SizedBox(height: 10,),
            TextField(
              decoration: const InputDecoration(
                  labelText: "password"
              ),
              onChanged: (text) {
                setState(() {
                  _password = text;
                });
              },
              obscureText: true,
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: requestPostSigninAPI,
              child: const Text("サインイン")
            ),
            const SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
