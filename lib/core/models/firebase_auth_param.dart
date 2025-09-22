class FireBaseAuthParam {
  final String email;
  final String password;

  FireBaseAuthParam({required this.email, required this.password});
  Map<String, dynamic> toJson() {
    return {'password': password, 'email': email};
  }
}
