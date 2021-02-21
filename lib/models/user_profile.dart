
class UserProfile {
  int _id;
  String _firstname;
  String _lastname;
  String _phoneNumber;
  String _email;
//  bool _term;


  int get id => _id;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
//  bool get term => _term;

  UserProfile({
    int id,
    String firstname,
    String lastname,
    String phoneNumber,
    String email,
//    bool term
  }){
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _phoneNumber = phoneNumber;
    _email = email;
//    _term = term;
  }

  UserProfile.fromJson(dynamic json) {
    _id = json["id"];
    _firstname = json["first_name"];
    _lastname = json["last_name"];
    _phoneNumber = json["phone"];
    _email = json["email"];
//    _term = json["term"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["first_name"] = _firstname;
    map["last_name"] = _lastname;
    map["phone"] = _phoneNumber;
    map["email"] = _email;
//    map["term"] = _term;
    return map;
  }

}