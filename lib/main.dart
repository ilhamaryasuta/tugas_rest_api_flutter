import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final String apiUrl = "http://localhost/api/data.json";

  const MyApp({super.key});
  Future<List<dynamic>> _fecthData() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BELAJAR RESTFUL API'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(snapshot.data[index]['avatar']),
                    ),
                    title: Text(snapshot.data[index]['first_name'] + " " + snapshot.data[index]['last_name']),
                    subtitle: Text(snapshot.data[index]['produk']),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
