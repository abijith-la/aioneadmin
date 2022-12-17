import 'dart:async';
import 'package:adminspace/emailpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RootPage(),
      title: "adminspace",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('adminspace - home'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('ACCOUNTS'),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EmailPage()));
        },
      )),
    );
  }
}
