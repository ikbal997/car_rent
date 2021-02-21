import 'package:carrent/models/car.dart';
import 'package:carrent/models/terms_filter.dart';

class AllTerms {
  List<Terms> _terms;

  AllTerms({List<Terms> terms}) {
    this._terms = terms;
    if(terms==null){
      this._terms=new List<Terms>();
    }
  }
  List<Terms> get terms => _terms;
  set terms(List<Terms> terms) => _terms = terms;

  factory AllTerms.fromJson(List<dynamic> json) =>
      AllTerms(terms: List<Terms>.from(json.map((x) => Terms.fromJson(x))));
}