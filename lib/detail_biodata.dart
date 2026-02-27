import 'package:flutter/material.dart';

class DetailBiodata extends StatelessWidget {
  final String nim;
  final String nama;
  final String email;

  DetailBiodata({
    required this.nim,
    required this.nama,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Biodata"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("NIM: $nim", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Nama: $nama", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Email: $email", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}