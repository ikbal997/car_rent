import 'package:flutter/material.dart';
import 'package:carrent/config.dart';
import 'package:easy_localization/easy_localization.dart';


class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    TextEditingController emailTextEditingController = new TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          backgroundColor: primaryColor5,
          elevation: 0.0,
//          leading: Icon(
//            Icons.arrow_back,
//            color: Colors.white,
//          ),
//          actions: [
//            Icon(
//              Icons.favorite_border,
//              color: Colors.black,
//            )
//          ],

          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.png"),
                  fit: BoxFit.cover)),
          child:  SingleChildScrollView(
            child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
//                  Padding(padding: EdgeInsets.only(top: 20)),
                    Image.asset(
                      'images/forgot.png',
                      width: 140,
                    ),
                        Container(
                        margin: EdgeInsets.only(bottom: 10, top: 60),
                        child: Text(
                          "forgotpassword",
                          style: TextStyle(
                              color: primaryColor5,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ).tr(),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'forgetpa',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ).tr(),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                           left: 50, right: 50),
                      padding: EdgeInsets.only(left: 30,right: 30),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: TextFormField(
//                      controller: emailTextEditingController,
                        keyboardType: TextInputType.number,
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
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10, top: 60, left: 50, right: 50),
//                    padding: EdgeInsets.only(left: 30),
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryColor5,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: FlatButton(
//                  minWidth: double.infinity,
//                  padding: EdgeInsets.symmetric(vertical: 10),
//                  color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        onPressed: ()
//                      async
                            {
//                      FocusScope.of(context).unfocus();
//                      setState(() {
//                        error = false;
//                      });
//                      if (_formKey.currentState.validate()) {
//                        var res = await saveMeal("api/client/forgotpassword", emailTextEditingController.text);
//                        print(res.statusCode);
//                        if (res.statusCode == 200) {
//                          SharedPreferences prefs = await SharedPreferences.getInstance();
//                          await prefs.setString('token', json.decode(res.body)['data']['token']);
//                          Phoenix.rebirth(context);
//                        } else {
//                          setState(() {
//                            error = true;
//                          });
//                        }
//                      }
                        },


                          child: Center(
                            child: Text(
                              "sendrequest",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ).tr(),
                          ),
//                      ),
                      ),
                    ),
//              ),
                  ],
                ),
              ),
          ),
//          ),
        ));
  }
}
