class User {
  User({
    required this.name,
    required this.email,
    required this.uid,
    required this.isOnline,
  });

  final String name;
  final String email;
  final String uid;
  final bool isOnline;
}
