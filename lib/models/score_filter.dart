/// title_score : "Review Score"
/// field_score : "review_score"
/// position_score : "2"
/// min : "1"
/// max : "5"

class Score_filter {
  String _title;
  String _field;
  String _position;
  String _min;
  String _max;

  String get title => _title;
  String get field => _field;
  String get position => _position;
  String get min => _min;
  String get max => _max;

  Score_filter({
      String title,
      String field,
      String position,
      String min, 
      String max}){
    _title = title;
    _field = field;
    _position = position;
    _min = min;
    _max = max;
}

  Score_filter.fromJson(dynamic json) {
    _title = json["title"];
    _field = json["field"];
    _position = json["position"];
    _min = json["min"];
    _max = json["max"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["field"] = _field;
    map["position"] = _position;
    map["min"] = _min;
    map["max"] = _max;
    return map;
  }

}