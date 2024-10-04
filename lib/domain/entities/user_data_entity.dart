class UserDataEntity {
  String? userStamp;
  String? name;
  String? email;
  String? noreg;
  String? jabatan;
  String? phone;
  int? typeuser;
  String? profilePicture;

  UserDataEntity({
    this.userStamp,
    this.name,
    this.email,
    this.noreg,
    this.jabatan,
    this.phone,
    this.typeuser,
    this.profilePicture,
  });

  factory UserDataEntity.fromJson(Map<String, dynamic> json) => UserDataEntity(
        userStamp: json["user_stamp"],
        name: json["name"],
        email: json["email"],
        noreg: json["noreg"],
        jabatan: json["jabatan"],
        phone: json["phone"],
        typeuser: json["typeuser"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "user_stamp": userStamp,
        "name": name,
        "email": email,
        "noreg": noreg,
        "jabatan": jabatan,
        "phone": phone,
        "typeuser": typeuser,
        "profile_picture": profilePicture,
      };
}
