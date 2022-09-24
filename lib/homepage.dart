import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_ecom/login.dart';

import 'Utils.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Utils.prefs!.setBool("loginstatus", false);
                Fluttertoast.showToast(
                    msg: "Log Out!!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return login();
                  },
                ));
              },
              child: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Container(
          child: Text("Hello... Welcome"),
        ),
      ),
    );
  }
}
