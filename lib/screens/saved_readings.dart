import 'package:bill_calc/utils/database.dart';
import 'package:flutter/material.dart';
import '../models/reading.dart';

class ReadingsScreen extends StatefulWidget {
  @override
  _ReadingsScreenState createState() => _ReadingsScreenState();
}

class _ReadingsScreenState extends State<ReadingsScreen> {
  List<Reading> newReading = [];
  Future<List<Reading>> _readingFuture;

  Future<List<Reading>> getReadings() async {
    final readingData = await DBProvider.db.getAllReadings();
    return readingData;
  }

  Widget getText(String heading, String detail) {
    return Container(
      padding: EdgeInsets.all(6),
      child: Row(children: [
        Text(
          "$heading: ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SelectableText(
          "$detail ",
          enableInteractiveSelection: true,
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
      ]),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _readingFuture = getReadings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Saved Readings'),
        backgroundColor: Color(0xff007EF4),
      ),
      body: FutureBuilder<List<Reading>>(
          future: _readingFuture,
          builder: (context, userData) {
            if (userData.hasData) {
              newReading = userData.data;
              newReading = newReading.reversed.toList();
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          height: 200,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          width: MediaQuery.of(context).size.width * 0.99,
                          child: Card(
                              color: Colors.blue[300],
                              elevation: 3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getText("Date", newReading[index].date),
                                  getText("Initial Reading",
                                      newReading[index].initial_reading),
                                  getText("Final Reading",
                                      newReading[index].final_reading),
                                  getText("Total Amount",
                                      "₹ ${newReading[index].billAmount}"),
                                ],
                              )),
                        )
                      ],
                    ),
                  );
                },
                itemCount: newReading.length,
              );
            }
            return Container();
          }),
    );
  }
}
