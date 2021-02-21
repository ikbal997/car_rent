
import 'package:carrent/models/booking_history.dart';

class BookingHistories {
  List<Booking_history> _bookingHistories;

  BookingHistories({List<Booking_history> bookingHistories}) {
    this._bookingHistories = bookingHistories;
    if(bookingHistories==null){
      this._bookingHistories=new List<Booking_history>();
    }
  }
  List<Booking_history> get bookingHistories => _bookingHistories;
  set bookingHistories(List<Booking_history> bookingHistories) => _bookingHistories = bookingHistories;

  factory BookingHistories.fromJson(List<dynamic> json) =>
      BookingHistories(bookingHistories: List<Booking_history>.from(json.map((x) => Booking_history.fromJson(x))));
}