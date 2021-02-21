/// id : 2
/// object_id : 11
/// object_model : "car"
/// user_id : 26
/// create_user : 26
/// update_user : null
/// created_at : "2021-02-10T20:59:28.000000Z"
/// updated_at : "2021-02-10T20:59:28.000000Z"
/// service : {"id":11,"title":"Vinfast Lux V8 (SUV)","price":250,"sale_price":0,"discount_percent":null,"image":"http://localhost:8000/uploads/demo/car/car-10.jpg","content":"<p>Libero sem vitae sed donec conubia integer nisi integer rhoncus imperdiet orci odio libero est integer a integer tincidunt sollicitudin blandit fusce nibh leo vulputate lobortis egestas dapibus faucibus metus conubia maecenas cras potenti cum hac arcu rhoncus nullam eros dictum torquent integer cursus bibendum sem sociis molestie tellus purus</p><p>Quam fusce convallis ipsum malesuada amet velit aliquam urna nullam vehicula fermentum id morbi dis magnis porta sagittis euismod etiam</p><h4>HIGHLIGHTS</h4><ul><li>Visit the Museum of Modern Art in Manhattan</li><li>See amazing works of contemporary art, including Vincent van Gogh's The Starry Night</li><li>Check out Campbell's Soup Cans by Warhol and The Dance (I) by Matisse</li><li>Behold masterpieces by Gauguin, Dali, Picasso, and Pollock</li><li>Enjoy free audio guides available in English, French, German, Italian, Spanish, Portuguese</li></ul>","location":{"id":8,"name":"Virginia"},"is_featured":1,"service_icon":"icofont-car","review_score":{"score_total":"4.7","total_review":3,"review_text":"Excellent"},"service_type":"Car"}

class Wishlist {
  int _id;
  int _objectId;
  String _objectModel;
  int _userId;
  int _createUser;
  dynamic _updateUser;
  String _createdAt;
  String _updatedAt;
  Service _service;

  int get id => _id;
  int get objectId => _objectId;
  String get objectModel => _objectModel;
  int get userId => _userId;
  int get createUser => _createUser;
  dynamic get updateUser => _updateUser;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  Service get service => _service;

  Wishlist({
      int id, 
      int objectId, 
      String objectModel, 
      int userId, 
      int createUser, 
      dynamic updateUser, 
      String createdAt, 
      String updatedAt, 
      Service service}){
    _id = id;
    _objectId = objectId;
    _objectModel = objectModel;
    _userId = userId;
    _createUser = createUser;
    _updateUser = updateUser;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _service = service;
}

  Wishlist.fromJson(dynamic json) {
    _id = json["id"];
    _objectId = json["object_id"];
    _objectModel = json["object_model"];
    _userId = json["user_id"];
    _createUser = json["create_user"];
    _updateUser = json["update_user"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _service = json["service"] != null ? Service.fromJson(json["service"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["object_id"] = _objectId;
    map["object_model"] = _objectModel;
    map["user_id"] = _userId;
    map["create_user"] = _createUser;
    map["update_user"] = _updateUser;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_service != null) {
      map["service"] = _service.toJson();
    }
    return map;
  }

}

/// id : 11
/// title : "Vinfast Lux V8 (SUV)"
/// price : 250
/// sale_price : 0
/// discount_percent : null
/// image : "http://localhost:8000/uploads/demo/car/car-10.jpg"
/// content : "<p>Libero sem vitae sed donec conubia integer nisi integer rhoncus imperdiet orci odio libero est integer a integer tincidunt sollicitudin blandit fusce nibh leo vulputate lobortis egestas dapibus faucibus metus conubia maecenas cras potenti cum hac arcu rhoncus nullam eros dictum torquent integer cursus bibendum sem sociis molestie tellus purus</p><p>Quam fusce convallis ipsum malesuada amet velit aliquam urna nullam vehicula fermentum id morbi dis magnis porta sagittis euismod etiam</p><h4>HIGHLIGHTS</h4><ul><li>Visit the Museum of Modern Art in Manhattan</li><li>See amazing works of contemporary art, including Vincent van Gogh's The Starry Night</li><li>Check out Campbell's Soup Cans by Warhol and The Dance (I) by Matisse</li><li>Behold masterpieces by Gauguin, Dali, Picasso, and Pollock</li><li>Enjoy free audio guides available in English, French, German, Italian, Spanish, Portuguese</li></ul>"
/// location : {"id":8,"name":"Virginia"}
/// is_featured : 1
/// service_icon : "icofont-car"
/// review_score : {"score_total":"4.7","total_review":3,"review_text":"Excellent"}
/// service_type : "Car"

class Service {
  int _id;
  String _title;
  int _price;
  int _salePrice;
  dynamic _discountPercent;
  String _image;
  String _content;
  Location _location;
  int _isFeatured;
  String _serviceIcon;
  Review_score _reviewScore;
  String _serviceType;

  int get id => _id;
  String get title => _title;
  int get price => _price;
  int get salePrice => _salePrice;
  dynamic get discountPercent => _discountPercent;
  String get image => _image;
  String get content => _content;
  Location get location => _location;
  int get isFeatured => _isFeatured;
  String get serviceIcon => _serviceIcon;
  Review_score get reviewScore => _reviewScore;
  String get serviceType => _serviceType;

  Service({
      int id, 
      String title, 
      int price, 
      int salePrice, 
      dynamic discountPercent, 
      String image, 
      String content, 
      Location location, 
      int isFeatured, 
      String serviceIcon, 
      Review_score reviewScore, 
      String serviceType}){
    _id = id;
    _title = title;
    _price = price;
    _salePrice = salePrice;
    _discountPercent = discountPercent;
    _image = image;
    _content = content;
    _location = location;
    _isFeatured = isFeatured;
    _serviceIcon = serviceIcon;
    _reviewScore = reviewScore;
    _serviceType = serviceType;
}

  Service.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _price = json["price"];
    _salePrice = json["sale_price"];
    _discountPercent = json["discount_percent"];
    _image = json["image"];
    _content = json["content"];
    _location = json["location"] != null ? Location.fromJson(json["location"]) : null;
    _isFeatured = json["is_featured"];
    _serviceIcon = json["service_icon"];
    _reviewScore = json["review_score"] != null ? Review_score.fromJson(json["reviewScore"]) : null;
    _serviceType = json["service_type"];
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
    map["service_icon"] = _serviceIcon;
    if (_reviewScore != null) {
      map["review_score"] = _reviewScore.toJson();
    }
    map["service_type"] = _serviceType;
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

/// id : 8
/// name : "Virginia"

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