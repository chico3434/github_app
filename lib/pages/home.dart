import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/values.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<User> fetchUser() async {
  final String urlApiBase = 'https://api.github.com/users/';
  final response = await http.get(urlApiBase + Values.userName);
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Future<User> user;

  @override
  void initState() {
    super.initState();
    Values.userName = 'chico3434';
    user = fetchUser();
  }

  void _openSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String userName;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Card(
            child: Container(
              width: 200,
              height: 110,
              child: Column(
                children: <Widget>[
                  Text("Digite o nome de usuário: "),
                  TextFormField(
                    onChanged: (value) {
                      userName = value;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  ClipOval(child: Image.network(snapshot.data.avatar_url, width: 128, height: 128,),),
                  Text(snapshot.data.name),
                  Text(snapshot.data.bio),
                ],
              );
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
