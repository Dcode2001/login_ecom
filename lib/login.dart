import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_ecom/register.dart';

import 'Utils.dart';
import 'homepage.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool pass = true;

  TextEditingController tusername = TextEditingController();
  TextEditingController tpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: AssetImage("myimages/img.png"),
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 55,
                        width: 140,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Colors.purple,
                              Colors.pink,
                              Colors.purpleAccent
                            ])),
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: tusername,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.email),
                        labelText: "Enter Email Or Username",
                        labelStyle: TextStyle(color: Colors.black)
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: tpassword,
                    obscureText: pass,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.password),
                        labelText: "Enter Your Password",
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                pass = !pass;
                              });
                            },
                            icon: pass
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility))),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        String username = tusername.text;
                        String password = tpassword.text;

                        String api = "https://ddevlopment.000webhostapp.com/Ecom/ecom_view.php?username=$username&password=$password"; // ? mukine username ane password check karavi shakay

                        Response response = await Dio().get(api);

                        print(response.data);

                        Map map = jsonDecode(response.data);

                        // print(map);

                        int status = map['status'];

                        if(status==0)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Username or Passwrod")));
                          }
                        else if(status==1)
                          {
                            Map userdata = map['userdata'];

                            User user = User.fromJson(userdata);

                            await Utils.prefs!.setBool('loginstatus', true);

                            await Utils.prefs!.setString('id', user.id!);
                            await Utils.prefs!.setString('name', user.name!);
                            await Utils.prefs!.setString('contact', user.contact!);
                            await Utils.prefs!.setString('email', user.email!);
                            await Utils.prefs!.setString('password', user.password!);

                            Fluttertoast.showToast(
                                msg: "Login Sucessfully...",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return homepage();
                            },));

                          }
                      },
                      child: Text("Submit")),
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Don't Have An Account?",
                          style: TextStyle(fontSize: 15,color: Colors.white),
                        ),
                        SizedBox(width: 7),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) {
                                return register();
                              },
                            ));
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                                decoration: TextDecoration.underline,
                                fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    ), onWillPop: goback);
  }
  Future<bool> goback()
  {
    exit(0);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //   return login();
    // },));
    return Future.value();
  }
}


class User {
  String? id;
  String? name;
  String? contact;
  String? email;
  String? password;
  String? imagepath;

  User(
      {this.id,
        this.name,
        this.contact,
        this.email,
        this.password,
        this.imagepath});

  User.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    email = json['email'];
    password = json['password'];
    imagepath = json['imagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['password'] = this.password;
    data['imagepath'] = this.imagepath;
    return data;
  }
}
