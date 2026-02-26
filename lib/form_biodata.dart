import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_biodata.dart';

class FormBiodata extends StatefulWidget {
  @override
  _FormBiodataState createState() => _FormBiodataState();
}

class _FormBiodataState extends State<FormBiodata> {

  final _formKey = GlobalKey<FormState>();
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();

  bool isLoading = false;

  Future<void> simpanData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse("https://69a032b03188b0b1d5380617.mockapi.io/mahasiswa");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nim": _nimController.text,
          "nama": _namaController.text,
          "email": _emailController.text,
        }),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data berhasil disimpan")),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBiodata(
              nim: _nimController.text,
              nama: _namaController.text,
              email: _emailController.text,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menyimpan data")),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FORM BIODATA"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(labelText: "NIM"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "NIM tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: "Nama"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: simpanData,
                      child: Text("Simpan"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}