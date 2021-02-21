/// data : [{"title":"Filter Price","field":"price_range","position":"1","min_price":168,"max_price":600},{"title":"Review Score","field":"review_score","position":"2","min":"1","max":"5"},{"title":"Attributes","field":"terms","position":"3","data":[{"id":9,"name":"Car Type","slug":"car-type","terms":[{"id":61,"name":"Convertibles","slug":"convertibles"},{"id":62,"name":"Coupes","slug":"coupes"},{"id":63,"name":"Hatchbacks","slug":"hatchbacks"},{"id":64,"name":"Minivans","slug":"minivans"},{"id":65,"name":"Sedan","slug":"sedan"},{"id":66,"name":"SUVs","slug":"suvs"},{"id":67,"name":"Trucks","slug":"trucks"},{"id":68,"name":"Wagons","slug":"wagons"}]},{"id":10,"name":"Car Features","slug":"car-features","terms":[{"id":69,"name":"Airbag","slug":"airbag"},{"id":70,"name":"FM Radio","slug":"fm-radio"},{"id":71,"name":"Power Windows","slug":"power-windows"},{"id":72,"name":"Sensor","slug":"sensor"},{"id":73,"name":"Speed Km","slug":"speed-km"},{"id":74,"name":"Steering Wheel","slug":"steering-wheel"}]}]}]

class Filters {
  Price_filter _priceFilter;
  Score_filter _scoreFilter;
  Terms_filter _termsFilter;

  Price_filter get priceFilter => _priceFilter;

  Score_filter get scoreFilter => _scoreFilter;
  Terms_filter get dataTerms => _termsFilter;

  Filters({
    Price_filter priceFilter,
    Score_filter scoreFilter,
    Terms_filter termsFilter}){
    _priceFilter=priceFilter;
    _scoreFilter=scoreFilter;
    _termsFilter = termsFilter;
  }

  Filters.fromJson(dynamic json) {
    _priceFilter = json["price_filter"] != null ?
    Price_filter.fromJson(json["price_filter"]) : null;
    _scoreFilter = json["score_filter"] != null ?
    Score_filter.fromJson(json["score_filter"]) : null;
    _termsFilter = json["terms_filter"] != null ?
    Terms_filter.fromJson(json["terms_filter"]) : null;


//    if (json["price_filter"] != null) {
//      _priceFilter = [];
//      json["price_filter"].forEach((v) {
//        _priceFilter.add(Price_filter.fromJson(v));
//      });
//    }
//    if (json["score_filter"] != null) {
//      _scoreFilter = [];
//      json["score_filter"].forEach((v) {
//        _scoreFilter.add(Score_filter.fromJson(v));
//      });
////    }
//    if (json["terms_filter"] != null) {
//      _termsFilter = [];
//      json["terms_filter"].forEach((v) {
//        _termsFilter.add(Terms_filter.fromJson(v));
//      });
//    }
  }

//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["title_price"] = _titlePrice;
//    map["field_price"] = _fieldPrice;
//    map["position_price"] = _positionPrice;
//    map["min_price"] = _minPrice;
//    map["max_price"] = _maxPrice;
//    map["title_score"] = _titleScore;
//    map["field_score"] = _fieldScore;
//    map["position_score"] = _positionScore;
//    map["min"] = _min;
//    map["max"] = _max;
//    map["title_terms"] = _titleTerms;
//    map["field_terms"] = _fieldTerms;
//    map["position_terms"] = _positionTerms;
//    if (_dataTerms != null) {
//      map["data_terms"] = _dataTerms.map((v) => v.toJson()).toList();
//    }
//    return map;
//  }
}
class Price_filter {
  String _titlePrice;
  String _fieldPrice;
  String _positionPrice;
  int _minPrice;
  int _maxPrice;

  String get titlePrice => _titlePrice;
  String get fieldPrice => _fieldPrice;
  String get positionPrice => _positionPrice;
  int get minPrice => _minPrice;
  int get maxPrice => _maxPrice;

  Price_filter({
    String titlePrice,
    String fieldPrice,
    String positionPrice,
    int minPrice,
    int maxPrice}){
    _titlePrice = titlePrice;
    _fieldPrice = fieldPrice;
    _positionPrice = positionPrice;
    _minPrice = minPrice;
    _maxPrice = maxPrice;
  }

  Price_filter.fromJson(dynamic json) {
    _titlePrice = json["title"];
    _fieldPrice = json["field"];
    _positionPrice = json["position"];
    _minPrice = json["min_price"];
    _maxPrice = json["max_price"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _titlePrice;
    map["field"] = _fieldPrice;
    map["position"] = _positionPrice;
    map["min_price"] = _minPrice;
    map["max_price"] = _maxPrice;
    return map;
  }

}
class Score_filter {
  String _titleScore;
  String _fieldScore;
  String _positionScore;
  String _min;
  String _max;

  String get titleScore => _titleScore;
  String get fieldScore => _fieldScore;
  String get positionScore => _positionScore;
  String get min => _min;
  String get max => _max;

  Score_filter({
    String titleScore,
    String fieldScore,
    String positionScore,
    String min,
    String max}){
    _titleScore = titleScore;
    _fieldScore = fieldScore;
    _positionScore = positionScore;
    _min = min;
    _max = max;
  }

  Score_filter.fromJson(dynamic json) {
    _titleScore = json["title"];
    _fieldScore = json["field"];
    _positionScore = json["position"];
    _min = json["min"];
    _max = json["max"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _titleScore;
    map["field"] = _fieldScore;
    map["position"] = _positionScore;
    map["min"] = _min;
    map["max"] = _max;
    return map;
  }

}
/// id : 9
/// name : "Car Type"
/// slug : "car-type"
/// terms : [{"id":61,"name":"Convertibles","slug":"convertibles"},{"id":62,"name":"Coupes","slug":"coupes"},{"id":63,"name":"Hatchbacks","slug":"hatchbacks"},{"id":64,"name":"Minivans","slug":"minivans"},{"id":65,"name":"Sedan","slug":"sedan"},{"id":66,"name":"SUVs","slug":"suvs"},{"id":67,"name":"Trucks","slug":"trucks"},{"id":68,"name":"Wagons","slug":"wagons"}]

/// title_terms : "Attributes"
/// field_terms : "terms"
/// position_terms : "3"
/// data : [{"id":9,"name":"Car Type","slug":"car-type","terms":[{"id":61,"name":"Convertibles","slug":"convertibles"},{"id":62,"name":"Coupes","slug":"coupes"},{"id":63,"name":"Hatchbacks","slug":"hatchbacks"},{"id":64,"name":"Minivans","slug":"minivans"},{"id":65,"name":"Sedan","slug":"sedan"},{"id":66,"name":"SUVs","slug":"suvs"},{"id":67,"name":"Trucks","slug":"trucks"},{"id":68,"name":"Wagons","slug":"wagons"}]},{"id":10,"name":"Car Features","slug":"car-features","terms":[{"id":69,"name":"Airbag","slug":"airbag"},{"id":70,"name":"FM Radio","slug":"fm-radio"},{"id":71,"name":"Power Windows","slug":"power-windows"},{"id":72,"name":"Sensor","slug":"sensor"},{"id":73,"name":"Speed Km","slug":"speed-km"},{"id":74,"name":"Steering Wheel","slug":"steering-wheel"}]}]

class Terms_filter {
  String _titleTerms;
  String _fieldTerms;
  String _positionTerms;
  List<Data> _data;

  String get titleTerms => _titleTerms;
  String get fieldTerms => _fieldTerms;
  String get positionTerms => _positionTerms;
  List<Data> get data => _data;

  Terms_filter({
    String titleTerms,
    String fieldTerms,
    String positionTerms,
    List<Data> data}){
    _titleTerms = titleTerms;
    _fieldTerms = fieldTerms;
    _positionTerms = positionTerms;
    _data = data;
  }

  Terms_filter.fromJson(dynamic json) {
    _titleTerms = json["title"];
    _fieldTerms = json["field"];
    _positionTerms = json["position"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _titleTerms;
    map["field"] = _fieldTerms;
    map["position"] = _positionTerms;
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