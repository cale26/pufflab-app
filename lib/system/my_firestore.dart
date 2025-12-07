import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCloud extends StatefulWidget {
  @override
  _MyCloudState createState() => _MyCloudState();
}

class _MyCloudState extends State<MyCloud> {
  List<Widget> dataListWidget(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs.map<Widget>((document) {
      final data = document.data() as Map<String, dynamic>; // Cast to Map
      return ListTile(
        title: Text(data["email"] ?? "No Email"),
        subtitle: Text(data["password"] ?? "No Password"),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Cloud Firestore'),
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('customer').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No data found."));
              }

              return ListView(
                children: dataListWidget(snapshot),
              );
            },
          ),
        ),
      ),
    );
  }
}
