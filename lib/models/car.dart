/// id : 12
/// title : "Vinfast Lux A2.0 Plus"
/// price : 350
/// sale_price : 0
/// discount_percent : null
/// image : "http://localhost:8000/uploads/demo/car/car-11.jpg"
/// content : "<p>Libero sem vitae sed donec conubia integer nisi integer rhoncus imperdiet orci odio libero est integer a integer tincidunt sollicitudin blandit fusce nibh leo vulputate lobortis egestas dapibus faucibus metus conubia maecenas cras potenti cum hac arcu rhoncus nullam eros dictum torquent integer cursus bibendum sem sociis molestie tellus purus</p><p>Quam fusce convallis ipsum malesuada amet velit aliquam urna nullam vehicula fermentum id morbi dis magnis porta sagittis euismod etiam</p><h4>HIGHLIGHTS</h4><ul><li>Visit the Museum of Modern Art in Manhattan</li><li>See amazing works of contemporary art, including Vincent van Gogh's The Starry Night</li><li>Check out Campbell's Soup Cans by Warhol and The Dance (I) by Matisse</li><li>Behold masterpieces by Gauguin, Dali, Picasso, and Pollock</li><li>Enjoy free audio guides available in English, French, German, Italian, Spanish, Portuguese</li></ul>"
/// location : {"id":3,"name":"California"}
/// is_featured : 1
/// passenger : 8
/// gear : "Auto"
/// baggage : 7
/// door : 4
/// review_score : {"score_total":"4.7","total_review":3,"review_text":"Excellent"}

//  "address": "Arrondissement de Paris",
//  "map_lat": "21.054831",
//  "map_lng": "105.796077",
//  "map_zoom": 12,
class Car {
  int _id;
  String _title;
  int _price;
  int _salePrice;
  dynamic _discountPercent;
  String _image;
  String _content;
  Location _location;
  int _isFeatured;
  int _passenger;
  String _gear;
  int _baggage;
  int _door;
  Review_score _reviewScore;
  String  _address;
  String _map_lat;
  String _map_lng;
  int _map_zoom;
  List<Booking_fee> _bookingFee;




  int get id => _id;
  String get title => _title;
  int get price => _price;
  int get salePrice => _salePrice;
  dynamic get discountPercent => _discountPercent;
  String get image => _image;
  String get content => _content;
  Location get location => _location;
  int get isFeatured => _isFeatured;
  int get passenger => _passenger;
  String get gear => _gear;
  int get baggage => _baggage;
  int get door => _door;
  Review_score get reviewScore => _reviewScore;
  String get address => _address;
  String get map_lat => _map_lat;
  String get map_lng => _map_lng;
  int get map_zoom => _map_zoom;
  List<Booking_fee> get bookingFee => _bookingFee;



  Car({
      int id, 
      String title, 
      int price, 
      int salePrice, 
      dynamic discountPercent, 
      String image, 
      String content, 
      Location location, 
      int isFeatured, 
      int passenger, 
      String gear, 
      int baggage, 
      int door, 
      Review_score reviewScore,
      String  address,
      String map_lat,
      String map_lng,
      int map_zoom,
    List<Booking_fee> bookingFee,


  }){
    _id = id;
    _title = title;
    _price = price;
    _salePrice = salePrice;
    _discountPercent = discountPercent;
    _image = image;
    _content = content;
    _location = location;
    _isFeatured = isFeatured;
    _passenger = passenger;
    _gear = gear;
    _baggage = baggage;
    _door = door;
    _reviewScore = reviewScore;
     _address =address;
     _map_lat=map_lat;
     _map_lng=map_lng;
     _map_zoom=map_zoom;
    _bookingFee = bookingFee;
}

  Car.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _price = json["price"];
    _salePrice = json["sale_price"];
    _discountPercent = json["discount_percent"];
    _image = json["image"];
    _content = json["content"];
    _location = json["location"] != null ? Location.fromJson(json["location"]) : null;
    _isFeatured = json["is_featured"];
    _passenger = json["passenger"];
    _gear = json["gear"];
    _baggage = json["baggage"];
    _door = json["door"];
    _reviewScore = json["review_score"] != null ? Review_score.fromJson(json["review_score"]) : null;
    _address = json["address"];
    _map_lat = json["map_lat"];
    _map_lng = json["map_lng"];
    _map_zoom = json["map_zoom"];
    if (json["booking_fee"] != null) {
      _bookingFee = [];
      json["booking_fee"].forEach((v) {
        _bookingFee.add(Booking_fee.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["price"] = _price;
    map["sale_price"] = _salePrice;
    map["discount_percent"] = _discountPercent;
    map["image"] = _image;
    map["content"] = _content;
    if (_location != null) {
      map["location"] = _location.toJson();
    }
    map["is_featured"] = _isFeatured;
    map["passenger"] = _passenger;
    map["gear"] = _gear;
    map["baggage"] = _baggage;
    map["door"] = _door;
    if (_reviewScore != null) {
      map["review_score"] = _reviewScore.toJson();

    }
    map["address"] = _address;
    map["map_lat"] = _map_lat;
    map["map_lng"] = _map_lng;
    map["map_zoom"] = _map_zoom;
    if (_bookingFee != null) {
      map["booking_fee"] = _bookingFee.map((v) => v.toJson()).toList();
    }

    return map;
  }

}

/// score_total : "4.7"
/// total_review : 3
/// review_text : "Excellent"

class Review_score {
  String _scoreTotal;
  int _totalReview;
  String _reviewText;

  String get scoreTotal => _scoreTotal;
  int get totalReview => _totalReview;
  String get reviewText => _reviewText;

  Review_score({
      String scoreTotal, 
      int totalReview, 
      String reviewText}){
    _scoreTotal = scoreTotal;
    _totalReview = totalReview;
    _reviewText = reviewText;
}

  Review_score.fromJson(dynamic json) {
    _scoreTotal = json["score_total"];
    _totalReview = json["total_review"];
    _reviewText = json["review_text"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["score_total"] = _scoreTotal;
    map["total_review"] = _totalReview;
    map["review_text"] = _reviewText;
    return map;
  }

}

/// id : 3
/// name : "California"

class Location {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Location({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Location.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }



}
class Booking_fee {
  String _name;
  String _desc;
  String _nameJa;
  String _descJa;
  String _price;
  String _type;

  String get name => _name;
  String get desc => _desc;
  String get nameJa => _nameJa;
  String get descJa => _descJa;
  String get price => _price;
  String get type => _type;

  Booking_fee({
    String name,
    String desc,
    String nameJa,
    String descJa,
    String price,
    String type}){
    _name = name;
    _desc = desc;
    _nameJa = nameJa;
    _descJa = descJa;
    _price = price;
    _type = type;
  }

  Booking_fee.fromJson(dynamic json) {
    _name = json["name"];
    _desc = json["desc"];
    _nameJa = json["name_ja"];
    _descJa = json["desc_ja"];
    _price = json["price"];
    _type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["desc"] = _desc;
    map["name_ja"] = _nameJa;
    map["desc_ja"] = _descJa;
    map["price"] = _price;
    map["type"] = _type;
    return map;
  }

}