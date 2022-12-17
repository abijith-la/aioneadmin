import 'dart:developer';
import 'package:adminspace/main.dart';
import 'package:adminspace/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  List _datalist = [];
  late Stream<List<NewUser>> userlist = readUsers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("adminspace - accounts"),
      ),
      body: StreamBuilder<List<NewUser>>(
          stream: userlist,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!;
              _datalist = users.toList();
            }
            return DataTable(
                columnSpacing: 11,
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Authentication'))
                ],
                rows: List<DataRow>.generate(
                    _datalist.length,
                    (index) => DataRow(cells: [
                          DataCell(Text(_datalist[index].name)),
                          DataCell(Text(_datalist[index].email)),
                          DataCell(Text(_datalist[index].auth.toString())),
                        ])));
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            userlist = readUsers();
          });
        },
      ),
    );
  }

  Stream<List<NewUser>> readUsers() => FirebaseFirestore.instance
      .collection('admins')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => NewUser.fromJson(doc.data())).toList());

  Future createUser(
      {required String name,
      required String email,
      required String password,
      required bool auth}) async {
    final docUser = FirebaseFirestore.instance.collection('admins').doc();
    final json = {
      'auth': auth,
      'email': email,
      'name': name,
      'password': password,
    };
    await docUser.set(json);
  }
}
