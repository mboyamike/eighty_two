class User {
  User({required this.id, required this.email, this.imageURL});

  String id;
  String email;
  String? imageURL;

  User.fromMap({required Map<String, dynamic> map})
      : id = map['id'],
        email = map['email'],
        imageURL = map['imageURL'];

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'imageURL': imageURL};
  }
}
