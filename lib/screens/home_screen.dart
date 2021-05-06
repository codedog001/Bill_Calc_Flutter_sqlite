import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController phoneController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController unitController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Bill o \'Meter'),
        backgroundColor: Color(0xff007EF4),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.87,
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: nameController,
                    validator: (val) {
                      if (val.length < 2) {
                        return "Please enter a valid number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Initial Reading',
                      labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    validator: (val) {
                      if (val.isNotEmpty) {
                        return null;
                      }
                      return "Please enter a valid number.";
                    },
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Final Reading',
                      labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: unitController,
                    validator: (val) {
                      if (val.length < 1) {
                        return "Please enter a valid number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Rate',
                      labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () {
                      //TODO Submit Data & Sign In
                      () {};
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.075,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff007EF4), Color(0xff2A75BC)],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Calculate',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     //TODO Submit Data & Sign Up
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.9,
                  //     height: MediaQuery.of(context).size.height * 0.075,
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //           colors: [Colors.white, Colors.grey[300]]),
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         'Sign Up',
                  //         style: TextStyle(fontSize: 20, color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
