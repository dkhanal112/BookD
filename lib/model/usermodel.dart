class AppUser {
  String? uid;
  String? username;
  String? email;
  String? profilePhoto;
  int? totalCoins;

  AppUser(
      {this.uid,
      this.username,
      this.email,
      this.profilePhoto,
      this.totalCoins});

  Map toMap(AppUser user) {
    var data = <String, dynamic>{};
    data['uid'] = user.uid;
    data['username'] = user.username;
    data['email'] = user.email;
    data["profilePhoto"] = user.profilePhoto;
    data["totalCoins"] = user.totalCoins;

    return data;
  }

  // Named constructor
  AppUser.fromMap(Map<String, dynamic> mapData) {
    uid = mapData['uid'];
    username = mapData['username'];
    email = mapData['email'];
    profilePhoto = mapData['profilePhoto'];
    totalCoins = mapData['totalCoins'];
  }
}
