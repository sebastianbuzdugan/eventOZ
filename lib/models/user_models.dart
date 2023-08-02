class UserModel {
  final String uid;
  final String email;
  final String name;
  final String age;
  final String sex;
  final String photoUrl;
  final List<String>? isFavorite;
  final List<String>? favoriteTasks;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.sex,
    required this.age,
    required this.photoUrl,
    final List<String>? isFavorite,
    final List<String>? favoriteTasks,
  })  : isFavorite = isFavorite ?? [],
        favoriteTasks = favoriteTasks ?? [];

  factory UserModel.fromMap(Map data, {final List<String>? favoriteTasks}) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      sex: data['sex'] ?? '',
      name: data['name'] ?? '',
      age: data['age'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      isFavorite:
          List.from(data.toString().contains('favoriteTasks') ? data['favoriteTasks'] : []),
      favoriteTasks: favoriteTasks ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "sex": sex,
        "age": age,
        "photoUrl": photoUrl,
      };
}
