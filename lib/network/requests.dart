import 'dart:convert';
import 'package:carrent/models/booking_histories.dart';
import 'package:carrent/models/location.dart';
import 'package:carrent/models/price_filter.dart';
import 'package:carrent/models/score_filter.dart';
import 'package:carrent/models/terms.dart';
import 'package:carrent/models/terms_filter.dart';
import 'package:carrent/models/user_profile.dart';
import 'package:http/http.dart';
import 'package:carrent/models/cars.dart';
import 'package:carrent/models/car.dart';
import 'package:carrent/network/network_client.dart';
import 'package:carrent/util/request_type.dart';

class AppRequests {
  static network_client client = network_client(Client());
//
////  http://localhost:8000/api/:type/search
  static Future<Cars> fetchCars(page) async {
//    print("this is cars");
    final response = await client.request(
        requestType: RequestType.GET, path: "api/car/search?&page=$page");
//    print("after response");
//    print(response.body);

    if (response.statusCode == 200) {
//      print(json.decode(response.statusCode.toString()));
      // If the server returns an OK response, then parse the JSON.
      return Cars.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

//  http://localhost:8000/api/car/search?terms[]=62&price_range=168;250&review_score[]=4
  static Future<Cars> fetchFilteringCars(page,String terms) async {
    print("this is fetchFilteringCars");

    final response = await client.request(
        requestType: RequestType.GET, path: "api/car/search?page=$page&$terms");
    print(terms);
    print(response.body);
    if (response.statusCode == 200) {
//      print(json.decode(response.statusCode.toString()));
      // If the server returns an OK response, then parse the JSON.
//      print(json.decode(response.body)['data']);
      return Cars.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<int> fetchTotalPagesFilteringCars(page,String terms) async {
    print("this is fetchFilteringCars");

    final response = await client.request(
        requestType: RequestType.GET, path: "api/car/search?page=$page&$terms");
    print(response.body);
    if (response.statusCode == 200) {
//      print("total pages");
//      print(json.decode(response.body)['total_pages']);
      return (json.decode(response.body)['total_pages']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<UserProfile> fetchProfile() async {
    final response = await client.request(requestType: RequestType.GET,
        path: "api/auth/me");
    print("before request");
    print(response.statusCode);
    if (response.statusCode == 200) {
//      print(response.statusCode);

//      print(json.decode(response.body));
      // If the server returns an OK response, then parse the JSON.
      return UserProfile.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<Car> fetchCar(id) async {
    print("this is fetch car");
    final response = await client.request(
        requestType: RequestType.GET, path: "api/car/detail/$id");
    //    print(response.statusCode);
//    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data']);
      // If the server returns an OK response, then parse the JSON.
      return Car.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  //http://localhost:8000/api/car/filters
  static Future<Price_filter> fetchPriceFilters() async {
    final response = await client.request(
        requestType: RequestType.GET, path: "api/car/filters");
//    print("this is price filter");
    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      return Price_filter.fromJson(json.decode(response.body)['data'][0]);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<Score_filter> fetchScoreFilters() async {
    final response = await client.request(
        requestType: RequestType.GET, path: "api/car/filters");
//    print("this is score filter");
//    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      return Score_filter.fromJson(json.decode(response.body)['data'][1]);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<Terms_filter> fetchTermsFilters() async {
    final response = await client.request(
        requestType: RequestType.GET, path: "api/car/filters");
//    print("this is Terms_filter filter");

    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      return Terms_filter.fromJson(json.decode(response.body)['data'][2]);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<AllTerms> fetchAllTermsFilters() async {
    final response = await client.request(requestType: RequestType.GET,
        path: "api/car/filters");
    print("this is AllTerms filter");
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      return AllTerms.fromJson
        (json.decode(response.body)['data'][2]['data'][0]['terms']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<AllTerms> fetchCarTypeTermsFilters() async {
    final response = await client.request(
        requestType: RequestType.GET, path: "api/car/filters");
//    print("this is AllTerms filter");
    print(response.body);
//    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      return AllTerms.fromJson(
          json.decode(response.body)['data'][2]['data'][0]['terms']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<AllTerms> fetchCarFeatureTermsFilters() async {
    final response = await client.request(
        requestType: RequestType.GET, path: "api/car/filters");
//    print("this is AllTerms filter");
//    print(response.body);
//    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.
      return AllTerms.fromJson(
          json.decode(response.body)['data'][2]['data'][1]['terms']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<BookingHistories> fetchBookingHistories() async {
//    print("this is fetchFilteringCars");
    final response = await client.request(
        requestType: RequestType.GET, path: "api/user/booking-history");
    print(response.body);
    if (response.statusCode == 200) {
//      print(json.decode(response.statusCode.toString()));
      // If the server returns an OK response, then parse the JSON.
//      print(json.decode(response.body)['data']);
      return BookingHistories.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }
  static Future<Cars> fetchCarsWithDateAndTime(location,start,end) async {
    print("this is cars");
    final response = await client.request(requestType: RequestType.GET,
        path: "api/car/search?location_id=$location&end=$end&start=$start");

    print("after response");
    print(response.body);

    if (response.statusCode == 200) {
      print(json.decode(response.statusCode.toString()));
      // If the server returns an OK response, then parse the JSON.
      return Cars.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }


  static Future<Locations> fetchLocations() async {
    print("this is location");
    final response = await client.request(requestType: RequestType.GET,
        path: "api/locations");
    print("after response");
    print(response.body);

    if (response.statusCode == 200) {
      print(json.decode(response.statusCode.toString()));
      // If the server returns an OK response, then parse the JSON.
      return Locations.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }


  static Future<Cars> fetchCarByType(id,page) async {
    print("this is cars by type"+id.toString());
    final response = await client.request(requestType: RequestType.GET,
        path: "api/car/search?terms[]=$id&page=$page");
    print("after response");
    print(json.decode(response.body)['total']);

    if (response.statusCode == 200) {
      print(json.decode(response.statusCode.toString()));
      // If the server returns an OK response, then parse the JSON.
      return Cars.fromJson(json.decode(response.body)['data']);
    } else {
      // If the response was umexpected, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
