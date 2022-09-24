import 'package:flutter/material.dart';
import 'package:login_ecom/Utils.dart';
import 'package:login_ecom/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';


class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {


  @override
  void initState() {

    super.initState();
    gonext();
  }

  gonext()
  async {
    Utils.prefs = await SharedPreferences.getInstance();

    bool loginstatus = Utils.prefs!.getBool('loginstatus')??false;

    if(loginstatus)
      {
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return homepage();
        },));
      }
    else
      {
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return login();
        },));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text("Loading.....")),
    );

  }

}
