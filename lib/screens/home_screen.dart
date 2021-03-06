import 'package:bill_calc/screens/saved_readings.dart';
import 'package:bill_calc/utils/database.dart';
import 'package:flutter/material.dart';
import '../models/reading.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController initialReadingController = new TextEditingController();
  TextEditingController finalReadingController = new TextEditingController();
  TextEditingController rateController = new TextEditingController();
  DateTime _eventDate = null;

  var nowdate;
  var dateToUse;

  double billAmount = 0;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Reading Saved'),
        action: SnackBarAction(
            label: 'OK',
            textColor: Colors.amber,
            onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _eventDate = datePicked;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    formKey.currentState.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Bill o\' Meter'),
        backgroundColor: Color(0xff007EF4),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.89,
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
                  child: Image.asset('assets/images/app1.png'),
                ),
                Container(
                  // decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
                  alignment: Alignment.center,
                  padding: billAmount > 0
                      ? EdgeInsets.fromLTRB(15, 9, 15, 0)
                      : EdgeInsets.fromLTRB(15, 29, 15, 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: initialReadingController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.length < 1) {
                              return "Please enter a valid number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Initial Reading',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.white),
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
                            if (val.length < 1) {
                              return "Please enter a valid number";
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          controller: finalReadingController,
                          decoration: InputDecoration(
                            labelText: 'Final Reading',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.white),
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
                          controller: rateController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.length < 1) {
                              return "Please enter a valid number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Rate',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.white),
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
                        Row(
                          mainAxisAlignment: _eventDate == null
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                _openDatePicker();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.33,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff007EF4),
                                    Color(0xff2A75BC)
                                  ]),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Pick Date',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _eventDate != null
                                ? Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                      child: Center(
                                        child: SelectableText(
                                          "${DateFormat.yMMMd().format(_eventDate).toString()}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),

                        billAmount > 0
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                  child: Center(
                                    child: SelectableText(
                                      "Bill Amount: ${billAmount.toString()}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: billAmount > 0
                                  ? const EdgeInsets.fromLTRB(0, 20, 0, 20)
                                  : const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    billAmount = ((double.parse(
                                                finalReadingController.text) -
                                            double.parse(
                                                initialReadingController.text) +
                                            1) *
                                        double.parse(rateController.text));
                                  });
                                },
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                enableFeedback: true,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff007EF4),
                                        Color(0xff2A75BC)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Calculate',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: billAmount > 0
                                  ? const EdgeInsets.all(0)
                                  : const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ReadingsScreen()));
                                },
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                enableFeedback: true,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff007EF4),
                                        Color(0xff2A75BC)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'View Saved Reading',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('pressed here 2');
                                  nowdate = DateTime.now();
                                  dateToUse =
                                      DateFormat.yMMMMEEEEd().format(nowdate);
                                  var newReading = Reading(
                                    final_reading:
                                        finalReadingController.text.toString(),
                                    date: DateFormat.yMMMd()
                                        .format(_eventDate)
                                        .toString(),
                                    id: DateTime.now().toString(),
                                    initial_reading: initialReadingController
                                        .text
                                        .toString(),
                                    billAmount: billAmount.toString(),
                                  );
                                  DBProvider.db.newEntry(newReading);
                                  _showToast(context);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height *
                                      0.075,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff007EF4),
                                        Color(0xff2A75BC)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Save Reading',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
