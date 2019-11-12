class User {
  String login;
  String avatar_url;
  String name;
  String bio;
  int public_repos;
  int public_gists;
  int followers;
  int following;

  User({this.login, this.avatar_url, this.name, this.bio, this.public_repos, this.public_gists, this.followers, this.following});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      avatar_url: json['avatar_url'],
      name: json['name'],
      bio: json['bio'],
      public_repos: json['public_repos'],
      public_gists: json['public_gists'],
      followers: json['followers'],
      following: json['following'],
    );
  }
}