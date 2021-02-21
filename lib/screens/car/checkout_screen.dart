import 'dart:convert';

import 'package:carrent/app_locale.dart';
import 'package:carrent/config.dart';
import 'package:carrent/models/user_profile.dart';
import 'package:carrent/network/network_client.dart';
import 'package:carrent/network/network_connection.dart';
import 'package:carrent/network/requests.dart';
import 'package:carrent/screens/CongratulationsScreen.dart';
import 'package:carrent/screens/car/PayPalScreen.dart';
import 'package:carrent/screens/network/no_internet_connection.dart';
import 'package:carrent/screens/network/server_error.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  final String bookingcode;
  CheckoutScreen(this.bookingcode);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var optionMap = {
    "option0": "offline_payment",
    "option1": 'paypal_payment',
  };
  var dropdownValue = "option0";
  bool error = false;
  TextEditingController firstnameTextEditingController =
      new TextEditingController();
  TextEditingController lastnameTextEditingController =
      new TextEditingController();
  TextEditingController phone_numberTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool serverError = false, connectedToNetwork = true;
  UserProfile model = new UserProfile();
  var mapCountry = {
    "AF": "Afghanistan",
    "AX": "Aland Islands",
    "AL": "Albania",
    "DZ": "Algeria",
    "AS": "American Samoa",
    "AD": "Andorra",
    "AO": "Angola",
    "AI": "Anguilla",
    "AQ": "Antarctica",
    "AG": "Antigua And Barbuda",
    "AR": "Argentina",
    "AM": "Armenia",
    "AW": "Aruba",
    "AU": "Australia",
    "AT": "Austria",
    "AZ": "Azerbaijan",
    "BS": "Bahamas",
    "BH": "Bahrain",
    "BD": "Bangladesh",
    "BB": "Barbados",
    "BY": "Belarus",
    "BE": "Belgium",
    "BZ": "Belize",
    "BJ": "Benin",
    "BM": "Bermuda",
    "BT": "Bhutan",
    "BO": "Bolivia",
    "BA": "Bosnia And Herzegovina",
    "BW": "Botswana",
    "BV": "Bouvet Island",
    "BR": "Brazil",
    "IO": "British Indian Ocean Territory",
    "BN": "Brunei Darussalam",
    "BG": "Bulgaria",
    "BF": "Burkina Faso",
    "BI": "Burundi",
    "KH": "Cambodia",
    "CM": "Cameroon",
    "CA": "Canada",
    "CV": "Cape Verde",
    "KY": "Cayman Islands",
    "CF": "Central African Republic",
    "TD": "Chad",
    "CL": "Chile",
    "CN": "China",
    "CX": "Christmas Island",
    "CC": "Cocos (Keeling) Islands",
    "CO": "Colombia",
    "KM": "Comoros",
    "CG": "Congo",
    "CD": "Congo, Democratic Republic",
    "CK": "Cook Islands",
    "CR": "Costa Rica",
    "CI": "Cote D'Ivoire",
    "HR": "Croatia",
    "CU": "Cuba",
    "CY": "Cyprus",
    "CZ": "Czech Republic",
    "DK": "Denmark",
    "DJ": "Djibouti",
    "DM": "Dominica",
    "DO": "Dominican Republic",
    "EC": "Ecuador",
    "EG": "Egypt",
    "SV": "El Salvador",
    "GQ": "Equatorial Guinea",
    "ER": "Eritrea",
    "EE": "Estonia",
    "ET": "Ethiopia",
    "FK": "Falkland Islands (Malvinas)",
    "FO": "Faroe Islands",
    "FJ": "Fiji",
    "FI": "Finland",
    "FR": "France",
    "GF": "French Guiana",
    "PF": "French Polynesia",
    "TF": "French Southern Territories",
    "GA": "Gabon",
    "GM": "Gambia",
    "GE": "Georgia",
    "DE": "Germany",
    "GH": "Ghana",
    "GI": "Gibraltar",
    "GR": "Greece",
    "GL": "Greenland",
    "GD": "Grenada",
    "GP": "Guadeloupe",
    "GU": "Guam",
    "GT": "Guatemala",
    "GG": "Guernsey",
    "GN": "Guinea",
    "GW": "Guinea-Bissau",
    "GY": "Guyana",
    "HT": "Haiti",
    "HM": "Heard Island & Mcdonald Islands",
    "VA": "Holy See (Vatican City State)",
    "HN": "Honduras",
    "HK": "Hong Kong",
    "HU": "Hungary",
    "IS": "Iceland",
    "IN": "India",
    "ID": "Indonesia",
    "IR": "Iran, Islamic Republic Of",
    "IQ": "Iraq",
    "IE": "Ireland",
    "IM": "Isle Of Man",
    "IL": "Israel",
    "IT": "Italy",
    "JM": "Jamaica",
    "JP": "Japan",
    "JE": "Jersey",
    "JO": "Jordan",
    "KZ": "Kazakhstan",
    "KE": "Kenya",
    "KI": "Kiribati",
    "KR": "Korea",
    "KW": "Kuwait",
    "KG": "Kyrgyzstan",
    "LA": "Lao People's Democratic Republic",
    "LV": "Latvia",
    "LB": "Lebanon",
    "LS": "Lesotho",
    "LR": "Liberia",
    "LY": "Libyan Arab Jamahiriya",
    "LI": "Liechtenstein",
    "LT": "Lithuania",
    "LU": "Luxembourg",
    "MO": "Macao",
    "MK": "Macedonia",
    "MG": "Madagascar",
    "MW": "Malawi",
    "MY": "Malaysia",
    "MV": "Maldives",
    "ML": "Mali",
    "MT": "Malta",
    "MH": "Marshall Islands",
    "MQ": "Martinique",
    "MR": "Mauritania",
    "MU": "Mauritius",
    "YT": "Mayotte",
    "MX": "Mexico",
    "FM": "Micronesia, Federated States Of",
    "MD": "Moldova",
    "MC": "Monaco",
    "MN": "Mongolia",
    "ME": "Montenegro",
    "MS": "Montserrat",
    "MA": "Morocco",
    "MZ": "Mozambique",
    "MM": "Myanmar",
    "NA": "Namibia",
    "NR": "Nauru",
    "NP": "Nepal",
    "NL": "Netherlands",
    "AN": "Netherlands Antilles",
    "NC": "New Caledonia",
    "NZ": "New Zealand",
    "NI": "Nicaragua",
    "NE": "Niger",
    "NG": "Nigeria",
    "NU": "Niue",
    "NF": "Norfolk Island",
    "MP": "Northern Mariana Islands",
    "NO": "Norway",
    "OM": "Oman",
    "PK": "Pakistan",
    "PW": "Palau",
    "PS": "Palestinian Territory, Occupied",
    "PA": "Panama",
    "PG": "Papua New Guinea",
    "PY": "Paraguay",
    "PE": "Peru",
    "PH": "Philippines",
    "PN": "Pitcairn",
    "PL": "Poland",
    "PT": "Portugal",
    "PR": "Puerto Rico",
    "QA": "Qatar",
    "RE": "Reunion",
    "RO": "Romania",
    "RU": "Russian Federation",
    "RW": "Rwanda",
    "BL": "Saint Barthelemy",
    "SH": "Saint Helena",
    "KN": "Saint Kitts And Nevis",
    "LC": "Saint Lucia",
    "MF": "Saint Martin",
    "PM": "Saint Pierre And Miquelon",
    "VC": "Saint Vincent And Grenadines",
    "WS": "Samoa",
    "SM": "San Marino",
    "ST": "Sao Tome And Principe",
    "SA": "Saudi Arabia",
    "SN": "Senegal",
    "RS": "Serbia",
    "SC": "Seychelles",
    "SL": "Sierra Leone",
    "SG": "Singapore",
    "SK": "Slovakia",
    "SI": "Slovenia",
    "SB": "Solomon Islands",
    "SO": "Somalia",
    "ZA": "South Africa",
    "GS": "South Georgia And Sandwich Isl.",
    "ES": "Spain",
    "LK": "Sri Lanka",
    "SD": "Sudan",
    "SR": "Suriname",
    "SJ": "Svalbard And Jan Mayen",
    "SZ": "Swaziland",
    "SE": "Sweden",
    "CH": "Switzerland",
    "SY": "Syrian Arab Republic",
    "TW": "Taiwan",
    "TJ": "Tajikistan",
    "TZ": "Tanzania",
    "TH": "Thailand",
    "TL": "Timor-Leste",
    "TG": "Togo",
    "TK": "Tokelau",
    "TO": "Tonga",
    "TT": "Trinidad And Tobago",
    "TN": "Tunisia",
    "TR": "Turkey",
    "TM": "Turkmenistan",
    "TC": "Turks And Caicos Islands",
    "TV": "Tuvalu",
    "UG": "Uganda",
    "UA": "Ukraine",
    "AE": "United Arab Emirates",
    "GB": "United Kingdom",
    "US": "United States",
    "UM": "United States Outlying Islands",
    "UY": "Uruguay",
    "UZ": "Uzbekistan",
    "VU": "Vanuatu",
    "VE": "Venezuela",
    "VN": "Viet Nam",
    "VG": "Virgin Islands, British",
    "VI": "Virgin Islands, U.S.",
    "WF": "Wallis And Futuna",
    "EH": "Western Sahara",
    "YE": "Yemen",
    "ZM": "Zambia",
    "ZW": "Zimbabwe"
  };
  var dropdownCountry = "AF";

//  "code":"4fffbb3f26a4c7d725d846cee885266d",
//    "first_name": "ikbal",
//    "last_name": "zaidan",
//    "email":"ikb@gmail.com",
//    "phone": "0909090909",
//    "country":"Algeria",
//    "term_conditions": "Term",
//    "payment_gateway": "offline_payment"
  Future<http.Response> checkOut(url, code, first_name, last_name, email, phone,
      country, term_conditions, payment_gateway) async {
    var baseUrl = network_client.Url;
    print("#################"+code);
//    print(code+" "+first_name+" "+last_name+" "+email+" "+phone+" "+country+" "+term_conditions+" "+payment_gateway);
    return http.post(
      "$baseUrl/$url",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer " + AppLocale().token
      },
      body: jsonEncode(<String, String>{
        'code': code,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'phone': phone,
        'country': country,
        'term_conditions': term_conditions,
        'payment_gateway': payment_gateway,
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

//
  void initialize() {
    NetworkConnection.isConnected().then((connected) {
      setState(() {
        serverError = false;
        if (connected) {
          AppRequests.fetchProfile().then((value) {
            model = value;
            print(model.toJson());
            firstnameTextEditingController.text = model.firstname;
            lastnameTextEditingController.text = model.lastname;
            phone_numberTextEditingController.text = model.phoneNumber;
            emailTextEditingController.text = model.email;
          }).catchError((error, stackTrace) {
            setState(() {
              print("error server");
              serverError = true;
            });
          });
        }
        connectedToNetwork = connected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor5,
          elevation: 0.0,
          title: Text(
            "checkout",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
          ).tr(),
          centerTitle: true,
        ),
//        extendBodyBehindAppBar: true,
        body:
//        Builder(builder: (context) {
//          if (connectedToNetwork == false) {
//            return NoInternetConnection(voidCallback: initialize);
//          } else {
//            if (serverError) {
//              return ServerError(voidCallback: initialize);
//            } else {
//              return FutureBuilder<Car>(
//                  future: model,
//                  builder: (context, snapshot) {
//                    if (snapshot.hasData) {
//                      print(snapshot.data);
//                      return
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//            Container(
//                constraints: BoxConstraints.expand(),
//                decoration: BoxDecoration(
//                    image: DecorationImage(
//                        image: AssetImage("images/background.png"),
//                        fit: BoxFit.cover
//                    )),
//                child:
//                SingleChildScrollView(
//                  child: Center(
//                    child: Container(
//                      padding: EdgeInsets.only(top: 40),
//                      width: 380,
//                      height: 500,
////            padding: EdgeInsets.all(10),
//                      child: Card(
//                        shadowColor: Colors.grey,
//                        elevation: 10.0,
//                        child:
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: TextFormField(
                        controller: firstnameTextEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "firstname".tr(),
                            icon: Icon(Icons.edit)),
                        validator: (String value) {
                          if (value.isEmpty || value.length < 1) {
                            return "validfirstname".tr();
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: TextFormField(
                        controller: lastnameTextEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "lastname".tr(),
                            icon: Icon(Icons.edit)),
                        validator: (String value) {
                          if (value.isEmpty || value.length < 1) {
                            return "validlastname".tr();
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: TextFormField(
                        controller: phone_numberTextEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "phonenumber".tr(),
                            icon: Icon(Icons.phone)),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "validphone".tr();
                          }
                          if (value.length < 10 || value.length > 10) {
                            return "validphonelength".tr();
                          }
                          if (value[0] != '0' || value[1] != '9') {
                            return "validphonestart".tr();
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: TextFormField(
                        controller: emailTextEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "email".tr(),
                            icon: Icon(Icons.email)),
                        validator: (String value) {
                          if (value.isEmpty ||
                              value.indexOf(".") == -1 ||
                              value.indexOf("@") == -1) {
                            return "validemail".tr();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
//                      ),
//                      //),
//                    ),
//                  ),
//                )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "country",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor5),
                  textAlign: TextAlign.start,
                ).tr(),
              ),
              Container(
//              width: 220,
//              height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Colors.grey.withOpacity(0.3),
//                                      spreadRadius: 6,
//                                      blurRadius: 15,
//                                      offset: Offset(0, 3))
//                                ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: dropdownCountry,
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 18,
                    onChanged: (value) {
                      setState(() {
                        dropdownCountry = value;
                        print("***********"+mapCountry[dropdownCountry]);
                      });
//                          reloadData();
                    },
                    items: <String>[
                      "AF",
                      "AX",
                      "AL",
                      "DZ",
                      "AS",
                      "AD",
                      "AO",
                      "AI",
                      "AQ",
                      "AG",
                      "AR",
                      "AM",
                      "AW",
                      "AU",
                      "AT",
                      "AZ",
                      "BS",
                      "BH",
                      "BD",
                      "BB",
                      "BY",
                      "BE",
                      "BZ",
                      "BJ",
                      "BM",
                      "BT",
                      "BO",
                      "BA",
                      "BW",
                      "BV",
                      "BR",
                      "IO",
                      "BN",
                      "BG",
                      "BF",
                      "BI",
                      "KH",
                      "CM",
                      "CA",
                      "CV",
                      "KY",
                      "CF",
                      "TD",
                      "CL",
                      "CN",
                      "CX",
                      "CC",
                      "CO",
                      "KM",
                      "CG",
                      "CD",
                      "CK",
                      "CR",
                      "CI",
                      "HR",
                      "CU",
                      "CY",
                      "CZ",
                      "DK",
                      "DJ",
                      "DM",
                      "DO",
                      "EC",
                      "EG",
                      "SV",
                      "GQ",
                      "ER",
                      "EE",
                      "ET",
                      "FK",
                      "FO",
                      "FJ",
                      "FI",
                      "FR",
                      "GF",
                      "PF",
                      "TF",
                      "GA",
                      "GM",
                      "GE",
                      "DE",
                      "GH",
                      "GI",
                      "GR",
                      "GL",
                      "GD",
                      "GP",
                      "GU",
                      "GT",
                      "GG",
                      "GN",
                      "GW",
                      "GY",
                      "HT",
                      "HM",
                      "VA",
                      "HN",
                      "HK",
                      "HU",
                      "IS",
                      "IN",
                      "ID",
                      "IR",
                      "IQ",
                      "IE",
                      "IM",
                      "IL",
                      "IT",
                      "JM",
                      "JP",
                      "JE",
                      "JO",
                      "KZ",
                      "KE",
                      "KI",
                      "KR",
                      "KW",
                      "KG",
                      "LA",
                      "LV",
                      "LB",
                      "LS",
                      "LR",
                      "LY",
                      "LI",
                      "LT",
                      "LU",
                      "MO",
                      "MK",
                      "MG",
                      "MW",
                      "MY",
                      "MV",
                      "ML",
                      "MT",
                      "MH",
                      "MQ",
                      "MR",
                      "MU",
                      "YT",
                      "MX",
                      "FM",
                      "MD",
                      "MC",
                      "MN",
                      "ME",
                      "MS",
                      "MA",
                      "MZ",
                      "MM",
                      "NA",
                      "NR",
                      "NP",
                      "NL",
                      "AN",
                      "NC",
                      "NZ",
                      "NI",
                      "NE",
                      "NG",
                      "NU",
                      "NF",
                      "MP",
                      "NO",
                      "OM",
                      "PK",
                      "PW",
                      "PS",
                      "PA",
                      "PG",
                      "PY",
                      "PE",
                      "PH",
                      "PN",
                      "PL",
                      "PT",
                      "PR",
                      "QA",
                      "RE",
                      "RO",
                      "RU",
                      "RW",
                      "BL",
                      "SH",
                      "KN",
                      "LC",
                      "MF",
                      "PM",
                      "VC",
                      "WS",
                      "SM",
                      "ST",
                      "SA",
                      "SN",
                      "RS",
                      "SC",
                      "SL",
                      "SG",
                      "SK",
                      "SI",
                      "SB",
                      "SO",
                      "ZA",
                      "GS",
                      "ES",
                      "LK",
                      "SD",
                      "SR",
                      "SJ",
                      "SZ",
                      "SE",
                      "CH",
                      "SY",
                      "TW",
                      "TJ",
                      "TZ",
                      "TH",
                      "TL",
                      "TG",
                      "TK",
                      "TO",
                      "TT",
                      "TN",
                      "TR",
                      "TM",
                      "TC",
                      "TV",
                      "UG",
                      "UA",
                      "AE",
                      "GB",
                      "US",
                      "UM",
                      "UY",
                      "UZ",
                      "VU",
                      "VE",
                      "VN",
                      "VG",
                      "VI",
                      "WF",
                      "EH",
                      "YE",
                      "ZM",
                      "ZW"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(mapCountry[value]),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "paymentmethod",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor5),
                  textAlign: TextAlign.start,
                ).tr(),
              ),
              Container(
//              width: 220,
//              height: 40,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Colors.grey.withOpacity(0.3),
//                                      spreadRadius: 6,
//                                      blurRadius: 15,
//                                      offset: Offset(0, 3))
//                                ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: dropdownValue,
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 18,
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value;
                        print("******************"+optionMap[dropdownValue]);
                      });
//                          reloadData();
                    },
                    items: <String>[
                      'option0',
                      'option1',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(optionMap[value]),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                        height: 24,
                        width: 24,
                      ),
                    );
                    error = false;
                  });
//                print(widget.bookingcode+
//                    " "+
//                    firstnameTextEditingController.text+
//                    " "+
//                    lastnameTextEditingController.text+
//                    " "+
//                    emailTextEditingController.text+
//                    " "+
//                    phone_numberTextEditingController.text+
//                    " "+
//                    mapCountry[dropdownCountry]+
//                    " "+
//                    "true"+
//                    " "+
//                    optionMap[dropdownValue]);

                  var res = await checkOut(
                      "api/booking/doCheckout",
                      widget.bookingcode,
                      firstnameTextEditingController.text,
                      lastnameTextEditingController.text,
                      emailTextEditingController.text,
                      phone_numberTextEditingController.text,
                      mapCountry[dropdownCountry],
                      "true",
                      optionMap[dropdownValue]);


                  print(res.statusCode);

                  if (res.statusCode == 200) {
                    print(json.decode(res.body));
                    if (dropdownValue == "option1") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PayPalScreen()));
                    } else if (dropdownValue == "option0") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CongratulationsScreen()));
                    }
                  } else {
                    setState(() {
                      error = true;
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  height: 50,
                  decoration: BoxDecoration(
//              color: primaryColor5.withOpacity(0.7),
                    gradient: LinearGradient(
                        colors: [primaryColor5, primaryColor6],
                        begin: FractionalOffset.centerRight,
                        end: FractionalOffset.centerLeft,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
//              border: Border.all(color: primaryColor5, width: 2)
                  ),
                  child: Center(
                    child: Text(
                      "confirm&pay",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ).tr(),
                  ),
                ),
              ),
          ],
        ),
            )
//                    }
//                    return Center(child: CircularProgressIndicator());
//                  }
//                  );
//            }
//          }
//        }
//        )
        );
  }
}
