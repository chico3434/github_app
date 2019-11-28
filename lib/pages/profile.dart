import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/pages/user.dart';
import 'package:github_app/values.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser() async {
  final String urlApiBase = 'https://api.github.com/users/';
  final response = await http.get(urlApiBase + Values.userName);
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<User> user;

  @override
  void initState() {
    super.initState();
    user = fetchUser();
  }

  void _openSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String userName;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          title: Text('Digite o nome de usuário: '),
          content: TextField(
            onChanged: (value) {
              userName = value;
            },
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Nome de usuário', contentPadding: EdgeInsets.all(12)),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Buscar'),
              onPressed: () {
                setState(() {
                  Values.userName = userName;
                  user = fetchUser();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Values.userName.isEmpty) ? Text('Github app') : Text(Values.userName),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              return UserPage(snapshot.data);
            }

            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: _openSearchDialog,
        tooltip: 'Search',
      ),
    );
  }
}
