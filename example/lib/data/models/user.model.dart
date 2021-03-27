class User {
  int id;
  String name;
  int age;
  String email;
  bool isActive;
  DateTime createdAt;
  DateTime birthDate;
  DateTime lastUpdate;

  User({
    this.id,
    this.name,
    this.age,
    this.email,
    this.isActive,
    this.birthDate,
    this.createdAt,
    this.lastUpdate,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    email = json['email'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    birthDate = json['birthDate'];
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['email'] = email;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['birthDate'] = birthDate;
    data['lastUpdate'] = lastUpdate;
    return data;
  }
}
