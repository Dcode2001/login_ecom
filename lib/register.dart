import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  ImagePicker _picker = ImagePicker();

  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();

  bool pass = true;

  String imagepath = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Register Page"),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return login();
                    },
                  ));
                },
                icon: Icon(Icons.arrow_back)),
            centerTitle: true,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: AssetImage("myimages/img_3.png"),
                fit: BoxFit.cover,
                // color: Colors.black.withOpacity(0),
                colorBlendMode: BlendMode.darken,
              ),
              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 55,
                            width: 200,
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
                                "SIGN UP",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Center(
                          child: Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100,
                              ),
                              height: 150,
                              width: 150,
                              child: imagepath.isEmpty
                                  ? Container(
                                      height: 150,
                                      width: 150,
                                      child: Image.asset("myimages/user.png"),
                                    )
                                  : Image.file(
                                      File(imagepath),
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fill,
                                    )),
                          Container(
                            margin: EdgeInsets.only(top: 105, left: 105),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.greenAccent.shade700),
                            child: IconButton(
                                onPressed: () {
                                  // Navigator.pop(context);
                                  showModalBottomSheet(
                                      builder: (context) {
                                        return Container(
                                          height: 140,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  "Profile Photo",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 28,
                                                    )),
                                              ),
                                              // SizedBox(height: 10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                                XFile? image =
                                                                    await _picker.pickImage(
                                                                        source:
                                                                            ImageSource.camera);
                                                                if (image !=
                                                                    null) {
                                                                  setState(
                                                                      () {
                                                                    imagepath =
                                                                        image
                                                                            .path;
                                                                  });
                                                                }
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .camera_alt,
                                                                size: 30,
                                                              )),
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets
                                                                .only(
                                                                    top: 40),
                                                            child: Text(
                                                              "Camera",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16),
                                                            ))
                                                      ],
                                                    ),
                                                    SizedBox(width: 7),
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                                XFile? image =
                                                                    await _picker.pickImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                                if (image !=
                                                                    null) {
                                                                  setState(
                                                                      () {
                                                                    imagepath =
                                                                        image
                                                                            .path;
                                                                  });
                                                                }
                                                              },
                                                              icon: Icon(
                                                                  Icons.photo,
                                                                  size: 30)),
                                                        ),
                                                        Container(
                                                            margin: EdgeInsets
                                                                .only(
                                                                    top: 40,
                                                                    left: 5),
                                                            child: Text(
                                                              "Gallery",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16),
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      context: context);
                                },
                                icon: Icon(Icons.camera_alt)),
                          )
                        ],
                      )),
                      SizedBox(height: 25),
                      TextField(
                        controller: tname,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Enter Your Name",
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: tcontact,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.phone),
                          labelText: "Enter Your Contact No.",
                        ),
                      ),
                      TextField(
                        controller: temail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.email),
                          labelText: "Enter Email",
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: tpassword,
                        obscureText: pass,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(Icons.password),
                            labelText: "Create Your Password",
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            String name = tname.text;
                            String contact = tcontact.text;
                            String email = temail.text;
                            String password = tpassword.text;

                            DateTime dt = DateTime.now();

                            String filename =
                                "$name${dt.year}${dt.month}${dt.day}${dt.hour}${dt.minute}${dt.second}.jpg";

                            var formData = FormData.fromMap({
                              'name': name,
                              'contact': contact,
                              'email': email,
                              'password': password,
                              'file': await MultipartFile.fromFile(imagepath,
                                  filename: filename),
                            });

                            var response = await Dio().post(
                                'https://ddevlopment.000webhostapp.com/Ecom/ecom_insert.php',
                                data: formData);

                            print(response.data);

                            Map m = jsonDecode(response.data);

                            int status = m['status'];

                            if (status == 0) {
                              print("Something Wrong!!!");
                            } else if (status == 1) {
                              Fluttertoast.showToast(
                                  msg: "Insert SucessFully...",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              print("Insert SucessFully...");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Insert Ok..")));
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return login();
                                },
                              ));
                            } else if (status == 2) {
                              print("Already Register!!!!");
                            }
                          },
                          child: Text("Register")),
                      SizedBox(height: 10),
                      SizedBox(height: 20),
                    ]),
              )
            ],
          ),
        ),
        onWillPop: goback);
  }

  Future<bool> goback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return login();
      },
    ));
    return Future.value();
  }
}
