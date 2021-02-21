class Locations {
  List<Location> _locations;



  Locations({List<Location> locations}) {
    this._locations = locations;
    if(locations==null){
      this._locations=new List<Location>();
    }
  }
  List<Location> get locations => _locations;
  set cars(List<Location> locations) => _locations = locations;

  factory Locations.fromJson(List<dynamic> json) =>
      Locations(locations: List<Location>.from(json.map((x) => Location.fromJson(x))));
}


class Location {
  int _id;
  String _title;
  String _image;
  dynamic _content;

  int get id => _id;
  String get title => _title;
  String get image => _image;
  dynamic get content => _content;

  Location({
      int id, 
      String title, 
      String image, 
      dynamic content}){
    _id = id;
    _title = title;
    _image = image;
    _content = content;
}

  Location.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _image = json["image"];
    _content = json["content"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["image"] = _image;
    map["content"] = _content;
    return map;
  }

}