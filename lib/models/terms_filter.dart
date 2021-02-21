/// title_terms : "Attributes"
/// field_terms : "terms"
/// position_terms : "3"
/// data : [{"id":9,"name":"Car Type","slug":"car-type","terms":[{"id":61,"name":"Convertibles","slug":"convertibles"},{"id":62,"name":"Coupes","slug":"coupes"},{"id":63,"name":"Hatchbacks","slug":"hatchbacks"},{"id":64,"name":"Minivans","slug":"minivans"},{"id":65,"name":"Sedan","slug":"sedan"},{"id":66,"name":"SUVs","slug":"suvs"},{"id":67,"name":"Trucks","slug":"trucks"},{"id":68,"name":"Wagons","slug":"wagons"}]},{"id":10,"name":"Car Features","slug":"car-features","terms":[{"id":69,"name":"Airbag","slug":"airbag"},{"id":70,"name":"FM Radio","slug":"fm-radio"},{"id":71,"name":"Power Windows","slug":"power-windows"},{"id":72,"name":"Sensor","slug":"sensor"},{"id":73,"name":"Speed Km","slug":"speed-km"},{"id":74,"name":"Steering Wheel","slug":"steering-wheel"}]}]

class Terms_filter {
  String _title;
  String _field;
  String _position;
  List<Data> _data;

  String get title => _title;
  String get field => _field;
  String get position => _position;
  List<Data> get data => _data;

  Terms_filter({
      String title,
      String field,
      String position,
      List<Data> data}){
    _title = title;
    _field = field;
    _position = position;
    _data = data;
}

  Terms_filter.fromJson(dynamic json) {
    _title = json["title"];
    _field = json["field"];
    _position = json["position"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["field"] = _field;
    map["position"] = _position;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 9
/// name : "Car Type"
/// slug : "car-type"
/// terms : [{"id":61,"name":"Convertibles","slug":"convertibles"},{"id":62,"name":"Coupes","slug":"coupes"},{"id":63,"name":"Hatchbacks","slug":"hatchbacks"},{"id":64,"name":"Minivans","slug":"minivans"},{"id":65,"name":"Sedan","slug":"sedan"},{"id":66,"name":"SUVs","slug":"suvs"},{"id":67,"name":"Trucks","slug":"trucks"},{"id":68,"name":"Wagons","slug":"wagons"}]

class Data {
  int _id;
  String _name;
  String _slug;
  List<Terms> _terms;

  int get id => _id;
  String get name => _name;
  String get slug => _slug;
  List<Terms> get terms => _terms;

  Data({
      int id, 
      String name, 
      String slug, 
      List<Terms> terms}){
    _id = id;
    _name = name;
    _slug = slug;
    _terms = terms;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _slug = json["slug"];
    if (json["terms"] != null) {
      _terms = [];
      json["terms"].forEach((v) {
        _terms.add(Terms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["slug"] = _slug;
    if (_terms != null) {
      map["terms"] = _terms.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 61
/// name : "Convertibles"
/// slug : "convertibles"

class Terms {
  int _id;
  String _name;
  String _slug;

  int get id => _id;
  String get name => _name;
  String get slug => _slug;

  Terms({
      int id, 
      String name, 
      String slug}){
    _id = id;
    _name = name;
    _slug = slug;
}

  Terms.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _slug = json["slug"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["slug"] = _slug;
    return map;
  }

}