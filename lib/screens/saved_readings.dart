import 'package:bill_calc/utils/database.dart';
import 'package:flutter/material.dart';
import '../models/reading.dart';

class ReadingsScreen extends StatefulWidget {
  @override
  _ReadingsScreenState createState() => _ReadingsScreenState();
}

class _ReadingsScreenState extends State<ReadingsScreen> {
  Map<String, String> newReading = {};
  Future _readingFuture;

  getReadings() async {
    final readingData = await DBProvider.db.getAllReadings();
    return readingData;
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
      appBar: AppBar(
        title: Text('Saved Readings'),
        backgroundColor: Color(0xff007EF4),
      ),
      body: FutureBuilder(
          future: _readingFuture,
          builder: (context, userData) {
            switch (userData.connectionState) {
              case ConnectionState.none:
                return Container(
                  child: Text('No records Found'),
                );
              case ConnectionState.active:
                return CircularProgressIndicator();
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (!newReading.containsKey('id')) {
                  newReading = Map<String, String>.from(userData.data);
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Card(
                            child: Column(
                          children: [
                            Text(
                              newReading['id'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              newReading['initial_reading'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              newReading['final_reading'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              newReading['billAmount'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )),
                      )
                    ],
                  ),
                );
            }
            return Container();
          }),
    );
  }
}
