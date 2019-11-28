class Repo {
  int id;
  String name;
  String full_name;

  Repo({this.id, this.name, this.full_name});

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      id: json['id'],
      name: json['name'],
      full_name: json['full_name'],
    );
  }
}