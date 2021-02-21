import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:carrent/app_locale.dart';
import 'dart:convert';
import '../util/nothing.dart';
import '../util/request_type.dart';
import '../util/request_type_exception.dart';

class network_client {

  static String Url =
      "http://rentalcar.zmnalholol.com";
//   "http://10.0.2.2:8000";
  static String _baseUrl = Url;

  final Client _client;

  network_client(this._client);

  Future<Response> request(
      {@required RequestType requestType, @required String path, dynamic parameter = Nothing}) async {
    switch (requestType) {
      case RequestType.GET:
//        if(AlpharabiLocale().token != null) return
//        _client.get("$_baseUrl/$path",headers:
//        {"Content-Type": "application/json",
//        "locale": AlpharabiLocale().locale.languageCode
//        ,"Authorization":"Bearer " + AlpharabiLocale().token});
//        else
          return _client.get("$_baseUrl/$path"
              ,headers: {
            "Content-Type": "application/json"
//            ,"locale": AppLocale().locale.languageCode
//          ,"Accept": "application/json"
          ,"Authorization":"Bearer " + AppLocale().token
//            ,"Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAwMFwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMjk4NTA3MCwiZXhwIjoxNjEzMDcxNDcwLCJuYmYiOjE2MTI5ODUwNzAsImp0aSI6IjQxaUo3VXA5ZHp1ME8xYzUiLCJzdWIiOjI2LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.MMVlDw5GMvMFrxTLJ1Q7tkUacNc2PxBfTHPQfSyBwzQ"
    }
    );
        break;
      case RequestType.POST:
        return _client.post("$_baseUrl/$path",
            headers: {"Content-Type": "application/json",},
            body: json.encode(parameter));
      case RequestType.DELETE:
        return _client.delete("$_baseUrl/$path");
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request mentioned is not found");
    }
  }
}