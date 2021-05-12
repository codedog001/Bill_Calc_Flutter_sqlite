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
      body: FutureBuilder<List<Reading>>(
          future: _readingFuture,
          builder: (context, userData) {
            if (userData.hasData) {
              newReading = userData.data;
              return ListView.builder(
                itemBuilder: (context, index) {
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
                                newReading[index].id,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                newReading[index].initial_reading,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                newReading[index].final_reading,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                newReading[index].billAmount,
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
                },
                reverse: true,
                itemCount: newReading.length,
              );
            }
            return Container();
          }),
    );
  }
}
