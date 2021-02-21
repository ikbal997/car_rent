/// title_price : "Filter Price"
/// field_price : "price_range"
/// position_price : "1"
/// min_price : 168
/// max_price : 600

class Price_filter {
  String _title;
  String _field;
  String _position;
  int _minPrice;
  int _maxPrice;

  String get title => _title;
  String get field => _field;
  String get position => _position;
  int get minPrice => _minPrice;
  int get maxPrice => _maxPrice;

  Price_filter({
      String title,
      String field,
      String position,
      int minPrice, 
      int maxPrice}){
    _title = title;
    _field = field;
    _position = position;
    _minPrice = minPrice;
    _maxPrice = maxPrice;
}

  Price_filter.fromJson(dynamic json) {
    _title = json["title"];
    _field = json["field"];
    _position = json["position"];
    _minPrice = json["min_price"];
    _maxPrice = json["max_price"];
  }

//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["title_price"] = _titlePrice;
//    map["field_price"] = _fieldPrice;
//    map["position_price"] = _positionPrice;
//    map["min_price"] = _minPrice;
//    map["max_price"] = _maxPrice;
//    return map;
//  }

}