import 'package:flutter/material.dart';
import 'package:github_app/pages/profile.dart';
import 'package:github_app/values.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _userName = '';

  void _search(userName) {
    Values.userName = userName;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Text(
                'Github App é um aplicativo que te permite ver os perfis do Github.'),
            Text(
                'Para encontrar um perfil basta digitar o nome de usuário dele abaixo: '),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: TextField(
                onChanged: (value) => _userName = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome de usuário',
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Buscar'),
                onPressed: () => _search(_userName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
