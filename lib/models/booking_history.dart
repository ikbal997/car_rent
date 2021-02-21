/// id : 4
/// code : "92e5c828051c1376117971d68fe5d62b"
/// vendor_id : 4
/// customer_id : 26
/// payment_id : null
/// gateway : "offline_payment"
/// object_id : 12
/// object_model : "car"
/// start_date : "2021-02-11 00:00:00"
/// end_date : "2021-02-14 00:00:00"
/// total : "1700.00"
/// total_guests : 1
/// currency : null
/// status : "processing"
/// deposit : null
/// deposit_type : null
/// commission : 140
/// commission_type : {"amount":"10","type":"percent"}
/// email : "ikbalzaidan@gmail.com"
/// first_name : "ikb"
/// last_name : "zaidan"
/// phone : "0989898989"
/// address : null
/// address2 : null
/// city : null
/// state : null
/// zip_code : null
/// country : "AF"
/// customer_notes : null
/// create_user : 26
/// update_user : 26
/// deleted_at : null
/// created_at : "2021-02-10T19:23:06.000000Z"
/// updated_at : "2021-02-10T19:23:57.000000Z"
/// buyer_fees : [{"name":"Equipment fee","desc":"One-time fee charged by host to cover the cost of cleaning their space.","name_ja":"クリーニング代","desc_ja":"スペースを掃除する費用をホストが請求する1回限りの料金。","price":"100","type":"one_time"},{"name":"Facility fee","desc":"This helps us run our platform and offer services like 24/7 support on your trip.","name_ja":"サービス料","desc_ja":"これにより、当社のプラットフォームを実行し、旅行中に","price":"200","type":"one_time"}]
/// total_before_fees : "1400.00"
/// paid_vendor : null
/// object_child_id : null
/// number : 1
/// paid : null
/// pay_now : "1700.00"
/// wallet_credit_used : 0
/// wallet_total_used : 0
/// wallet_transaction_id : null
/// is_refund_wallet : null
/// vendor_service_fee_amount : "0.00"
/// vendor_service_fee : ""
/// service : {"title":"Vinfast Lux A2.0 Plus"}
/// booking_meta : {"duration":null,"base_price":350,"sale_price":"0","extra_price":"[]","tmp_dates":{"2021-02-11":{"number":4,"price":350,"status":1},"2021-02-12":{"number":4,"price":350,"status":1},"2021-02-13":{"number":4,"price":350,"status":1},"2021-02-14":{"number":4,"price":350,"status":1}},"locale":"en","how_to_pay":""}
/// service_icon : "icofont-car"

class Booking_history {
  int _id;
  String _code;
  int _vendorId;
  int _customerId;
  dynamic _paymentId;
  String _gateway;
  int _objectId;
  String _objectModel;
  String _startDate;
  String _endDate;
  String _total;
  int _totalGuests;
  dynamic _currency;
  String _status;
  dynamic _deposit;
  dynamic _depositType;
  int _commission;
  Commission_type _commissionType;
  String _email;
  String _firstName;
  String _lastName;
  String _phone;
  dynamic _address;
  dynamic _address2;
  dynamic _city;
  dynamic _state;
  dynamic _zipCode;
  String _country;
  dynamic _customerNotes;
  int _createUser;
  int _updateUser;
  dynamic _deletedAt;
  String _createdAt;
  String _updatedAt;
  List<Buyer_fees> _buyerFees;
  String _totalBeforeFees;
  dynamic _paidVendor;
  dynamic _objectChildId;
  int _number;
  String _paid;
  String _payNow;
  int _walletCreditUsed;
  int _walletTotalUsed;
  dynamic _walletTransactionId;
  dynamic _isRefundWallet;
  String _vendorServiceFeeAmount;
  String _vendorServiceFee;
  Service _service;
  Booking_meta _bookingMeta;
  String _serviceIcon;

  int get id => _id;
  String get code => _code;
  int get vendorId => _vendorId;
  int get customerId => _customerId;
  dynamic get paymentId => _paymentId;
  String get gateway => _gateway;
  int get objectId => _objectId;
  String get objectModel => _objectModel;
  String get startDate => _startDate;
  String get endDate => _endDate;
  String get total => _total;
  int get totalGuests => _totalGuests;
  dynamic get currency => _currency;
  String get status => _status;
  dynamic get deposit => _deposit;
  dynamic get depositType => _depositType;
  int get commission => _commission;
  Commission_type get commissionType => _commissionType;
  String get email => _email;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phone => _phone;
  dynamic get address => _address;
  dynamic get address2 => _address2;
  dynamic get city => _city;
  dynamic get state => _state;
  dynamic get zipCode => _zipCode;
  String get country => _country;
  dynamic get customerNotes => _customerNotes;
  int get createUser => _createUser;
  int get updateUser => _updateUser;
  dynamic get deletedAt => _deletedAt;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<Buyer_fees> get buyerFees => _buyerFees;
  String get totalBeforeFees => _totalBeforeFees;
  dynamic get paidVendor => _paidVendor;
  dynamic get objectChildId => _objectChildId;
  int get number => _number;
  String get paid => _paid;
  String get payNow => _payNow;
  int get walletCreditUsed => _walletCreditUsed;
  int get walletTotalUsed => _walletTotalUsed;
  dynamic get walletTransactionId => _walletTransactionId;
  dynamic get isRefundWallet => _isRefundWallet;
  String get vendorServiceFeeAmount => _vendorServiceFeeAmount;
  String get vendorServiceFee => _vendorServiceFee;
  Service get service => _service;
  Booking_meta get bookingMeta => _bookingMeta;
  String get serviceIcon => _serviceIcon;

  Booking_history({
      int id, 
      String code, 
      int vendorId, 
      int customerId, 
      dynamic paymentId, 
      String gateway, 
      int objectId, 
      String objectModel, 
      String startDate, 
      String endDate, 
      String total, 
      int totalGuests, 
      dynamic currency, 
      String status, 
      dynamic deposit, 
      dynamic depositType, 
      int commission, 
      Commission_type commissionType, 
      String email, 
      String firstName, 
      String lastName, 
      String phone, 
      dynamic address, 
      dynamic address2, 
      dynamic city, 
      dynamic state, 
      dynamic zipCode, 
      String country, 
      dynamic customerNotes, 
      int createUser, 
      int updateUser, 
      dynamic deletedAt, 
      String createdAt, 
      String updatedAt, 
      List<Buyer_fees> buyerFees, 
      String totalBeforeFees, 
      dynamic paidVendor, 
      dynamic objectChildId, 
      int number,
      String paid,
      String payNow, 
      int walletCreditUsed, 
      int walletTotalUsed, 
      dynamic walletTransactionId, 
      dynamic isRefundWallet, 
      String vendorServiceFeeAmount, 
      String vendorServiceFee, 
      Service service, 
      Booking_meta bookingMeta, 
      String serviceIcon}){
    _id = id;
    _code = code;
    _vendorId = vendorId;
    _customerId = customerId;
    _paymentId = paymentId;
    _gateway = gateway;
    _objectId = objectId;
    _objectModel = objectModel;
    _startDate = startDate;
    _endDate = endDate;
    _total = total;
    _totalGuests = totalGuests;
    _currency = currency;
    _status = status;
    _deposit = deposit;
    _depositType = depositType;
    _commission = commission;
    _commissionType = commissionType;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
    _address = address;
    _address2 = address2;
    _city = city;
    _state = state;
    _zipCode = zipCode;
    _country = country;
    _customerNotes = customerNotes;
    _createUser = createUser;
    _updateUser = updateUser;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _buyerFees = buyerFees;
    _totalBeforeFees = totalBeforeFees;
    _paidVendor = paidVendor;
    _objectChildId = objectChildId;
    _number = number;
    _paid = paid;
    _payNow = payNow;
    _walletCreditUsed = walletCreditUsed;
    _walletTotalUsed = walletTotalUsed;
    _walletTransactionId = walletTransactionId;
    _isRefundWallet = isRefundWallet;
    _vendorServiceFeeAmount = vendorServiceFeeAmount;
    _vendorServiceFee = vendorServiceFee;
    _service = service;
    _bookingMeta = bookingMeta;
    _serviceIcon = serviceIcon;
}

  Booking_history.fromJson(dynamic json) {
    _id = json["id"];
    _code = json["code"];
    _vendorId = json["vendor_id"];
    _customerId = json["customer_id"];
    _paymentId = json["payment_id"];
    _gateway = json["gateway"];
    _objectId = json["object_id"];
    _objectModel = json["object_model"];
    _startDate = json["start_date"];
    _endDate = json["end_date"];
    _total = json["total"];
    _totalGuests = json["total_guests"];
    _currency = json["currency"];
    _status = json["status"];
    _deposit = json["deposit"];
    _depositType = json["deposit_type"];
    _commission = json["commission"];
    _commissionType = json["commission_type"] != null ? Commission_type.fromJson(json["commission_type"]) : null;
    _email = json["email"];
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _phone = json["phone"];
    _address = json["address"];
    _address2 = json["address2"];
    _city = json["city"];
    _state = json["state"];
    _zipCode = json["zip_code"];
    _country = json["country"];
    _customerNotes = json["customer_notes"];
    _createUser = json["create_user"];
    _updateUser = json["update_user"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    if (json["buyer_fees"] != null) {
      _buyerFees = [];
      json["buyer_fees"].forEach((v) {
        _buyerFees.add(Buyer_fees.fromJson(v));
      });
    }
    _totalBeforeFees = json["total_before_fees"];
    _paidVendor = json["paid_vendor"];
    _objectChildId = json["object_child_id"];
    _number = json["number"];
    _paid = json["paid"];
    _payNow = json["pay_now"];
    _walletCreditUsed = json["wallet_credit_used"];
    _walletTotalUsed = json["wallet_total_used"];
    _walletTransactionId = json["wallet_transaction_id"];
    _isRefundWallet = json["is_refund_wallet"];
    _vendorServiceFeeAmount = json["vendor_service_fee_amount"];
    _vendorServiceFee = json["vendor_service_fee"];
    _service = json["service"] != null ? Service.fromJson(json["service"]) : null;
    _bookingMeta = json["booking_meta"] != null ? Booking_meta.fromJson(json["booking_meta"]) : null;
    _serviceIcon = json["service_icon"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["code"] = _code;
    map["vendor_id"] = _vendorId;
    map["customer_id"] = _customerId;
    map["payment_id"] = _paymentId;
    map["gateway"] = _gateway;
    map["object_id"] = _objectId;
    map["object_model"] = _objectModel;
    map["start_date"] = _startDate;
    map["end_date"] = _endDate;
    map["total"] = _total;
    map["total_guests"] = _totalGuests;
    map["currency"] = _currency;
    map["status"] = _status;
    map["deposit"] = _deposit;
    map["deposit_type"] = _depositType;
    map["commission"] = _commission;
    if (_commissionType != null) {
      map["commission_type"] = _commissionType.toJson();
    }
    map["email"] = _email;
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["phone"] = _phone;
    map["address"] = _address;
    map["address2"] = _address2;
    map["city"] = _city;
    map["state"] = _state;
    map["zip_code"] = _zipCode;
    map["country"] = _country;
    map["customer_notes"] = _customerNotes;
    map["create_user"] = _createUser;
    map["update_user"] = _updateUser;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_buyerFees != null) {
      map["buyer_fees"] = _buyerFees.map((v) => v.toJson()).toList();
    }
    map["total_before_fees"] = _totalBeforeFees;
    map["paid_vendor"] = _paidVendor;
    map["object_child_id"] = _objectChildId;
    map["number"] = _number;
    map["paid"] = _paid;
    map["pay_now"] = _payNow;
    map["wallet_credit_used"] = _walletCreditUsed;
    map["wallet_total_used"] = _walletTotalUsed;
    map["wallet_transaction_id"] = _walletTransactionId;
    map["is_refund_wallet"] = _isRefundWallet;
    map["vendor_service_fee_amount"] = _vendorServiceFeeAmount;
    map["vendor_service_fee"] = _vendorServiceFee;
    if (_service != null) {
      map["service"] = _service.toJson();
    }
    if (_bookingMeta != null) {
      map["booking_meta"] = _bookingMeta.toJson();
    }
    map["service_icon"] = _serviceIcon;
    return map;
  }

}

/// duration : null
/// base_price : 350
/// sale_price : "0"
/// extra_price : "[]"
/// tmp_dates : {"2021-02-11":{"number":4,"price":350,"status":1},"2021-02-12":{"number":4,"price":350,"status":1},"2021-02-13":{"number":4,"price":350,"status":1},"2021-02-14":{"number":4,"price":350,"status":1}}
/// locale : "en"
/// how_to_pay : ""

class Booking_meta {
  dynamic _duration;
  int _basePrice;
  String _salePrice;
  String _extraPrice;
  String _locale;
  String _howToPay;

  dynamic get duration => _duration;
  int get basePrice => _basePrice;
  String get salePrice => _salePrice;
  String get extraPrice => _extraPrice;
  String get locale => _locale;
  String get howToPay => _howToPay;

  Booking_meta({
      dynamic duration, 
      int basePrice, 
      String salePrice, 
      String extraPrice, 
      String locale,
      String howToPay}){
    _duration = duration;
    _basePrice = basePrice;
    _salePrice = salePrice;
    _extraPrice = extraPrice;
    _locale = locale;
    _howToPay = howToPay;
}

  Booking_meta.fromJson(dynamic json) {
    _duration = json["duration"];
    _basePrice = json["base_price"];
    _salePrice = json["sale_price"];
    _extraPrice = json["extra_price"];
    _locale = json["locale"];
    _howToPay = json["how_to_pay"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["duration"] = _duration;
    map["base_price"] = _basePrice;
    map["sale_price"] = _salePrice;
    map["extra_price"] = _extraPrice;
    map["locale"] = _locale;
    map["how_to_pay"] = _howToPay;
    return map;
  }

}

/// number : 4
/// price : 350
/// status : 1

/// title : "Vinfast Lux A2.0 Plus"

class Service {
  String _title;

  String get title => _title;

  Service({
      String title}){
    _title = title;
}

  Service.fromJson(dynamic json) {
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    return map;
  }

}

/// name : "Equipment fee"
/// desc : "One-time fee charged by host to cover the cost of cleaning their space."
/// name_ja : "クリーニング代"
/// desc_ja : "スペースを掃除する費用をホストが請求する1回限りの料金。"
/// price : "100"
/// type : "one_time"

class Buyer_fees {
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

  Buyer_fees({
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

  Buyer_fees.fromJson(dynamic json) {
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

/// amount : "10"
/// type : "percent"

class Commission_type {
  String _amount;
  String _type;

  String get amount => _amount;
  String get type => _type;

  Commission_type({
      String amount, 
      String type}){
    _amount = amount;
    _type = type;
}

  Commission_type.fromJson(dynamic json) {
    _amount = json["amount"];
    _type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["amount"] = _amount;
    map["type"] = _type;
    return map;
  }

}