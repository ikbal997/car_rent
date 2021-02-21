import 'package:carrent/models/car.dart';

class Cars {
  List<Car> _cars;

  Cars({List<Car> cars}) {
    this._cars = cars;
    if(cars==null){
      this._cars=new List<Car>();
    }
  }
  List<Car> get cars => _cars;
  set cars(List<Car> cars) => _cars = cars;

  factory Cars.fromJson(List<dynamic> json) =>
      Cars(cars: List<Car>.from(json.map((x) => Car.fromJson(x))));
}