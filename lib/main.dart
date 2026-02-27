import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_biodata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataMahasiswaPage(),
    );
  }
}

class DataMahasiswaPage extends StatefulWidget {
  @override
  _DataMahasiswaPageState createState() => _DataMahasiswaPageState();
}

class _DataMahasiswaPageState extends State<DataMahasiswaPage> {
  List dataMahasiswa = [];

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse("https://69a032b03188b0b1d5380617.mockapi.io/Mahasiswa"),
    );

    if (response.statusCode == 200) {
      setState(() {
        dataMahasiswa = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Mahasiswa"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: dataMahasiswa.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(dataMahasiswa[index]['nim']),
              subtitle: Text(dataMahasiswa[index]['nama']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBiodata(
                      nim: dataMahasiswa[index]['nim'],
                      nama: dataMahasiswa[index]['nama'],
                      email: dataMahasiswa[index]['email'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}