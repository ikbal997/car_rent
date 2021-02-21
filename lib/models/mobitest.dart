/// id : 677
/// active : 1
/// price : 300
/// is_instant : 1
/// is_default : true
/// textColor : "#2791fe"
/// price_html : "$300 x 3"
/// event : "$300 x 3"
/// title : "$300 x 3"
/// end : "2021-01-01"
/// start : "2021-01-01"
/// number : 3

class Mobitest {
  int _id;
  int _active;
  int _price;
  int _isInstant;
  bool _isDefault;
  String _textColor;
  String _priceHtml;
  String _event;
  String _title;
  String _end;
  String _start;
  int _number;

  int get id => _id;
  int get active => _active;
  int get price => _price;
  int get isInstant => _isInstant;
  bool get isDefault => _isDefault;
  String get textColor => _textColor;
  String get priceHtml => _priceHtml;
  String get event => _event;
  String get title => _title;
  String get end => _end;
  String get start => _start;
  int get number => _number;

  Mobitest({
      int id, 
      int active, 
      int price, 
      int isInstant, 
      bool isDefault, 
      String textColor, 
      String priceHtml, 
      String event, 
      String title, 
      String end, 
      String start, 
      int number}){
    _id = id;
    _active = active;
    _price = price;
    _isInstant = isInstant;
    _isDefault = isDefault;
    _textColor = textColor;
    _priceHtml = priceHtml;
    _event = event;
    _title = title;
    _end = end;
    _start = start;
    _number = number;
}

  Mobitest.fromJson(dynamic json) {
    _id = json["id"];
    _active = json["active"];
    _price = json["price"];
    _isInstant = json["is_instant"];
    _isDefault = json["is_default"];
    _textColor = json["textColor"];
    _priceHtml = json["price_html"];
    _event = json["event"];
    _title = json["title"];
    _end = json["end"];
    _start = json["start"];
    _number = json["number"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["active"] = _active;
    map["price"] = _price;
    map["is_instant"] = _isInstant;
    map["is_default"] = _isDefault;
    map["textColor"] = _textColor;
    map["price_html"] = _priceHtml;
    map["event"] = _event;
    map["title"] = _title;
    map["end"] = _end;
    map["start"] = _start;
    map["number"] = _number;
    return map;
  }

}