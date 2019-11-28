import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_app/models/repo.dart';
import 'package:github_app/models/user.dart';
import 'package:http/http.dart' as http;

Future<List<Repo>> fetchRepos(String repos_url) async {
  final response = await http.get(repos_url);
  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    List<Repo> repos = [];
    for (Map<String, dynamic> repo in json) {
      repos.add(Repo.fromJson(repo));
    }
    return repos;
  } else {
    throw Exception('Failed to load repos');
  }
}

class UserPage extends StatefulWidget {
  UserPage(this.user);

  User user;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<List<Repo>> repos;

  @override
  void initState() {
    super.initState();
    repos = fetchRepos(widget.user.repos_url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Image.network(
              widget.user.avatar_url,
              width: 128,
              height: 128,
            ),
          ),
          Text(widget.user.name),
          Text(widget.user.bio),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<List<Repo>>(
              future: repos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          child: Card(
                            child: Column(children: <Widget>[
                              Text(snapshot.data[index].name),
                              Text(snapshot.data[index].full_name),
                            ],)
                          ),
                        );
                      },
                    ),
                  );
                }

                return CircularProgressIndicator();
              }),
        ],
      ),
    );
  }
}
