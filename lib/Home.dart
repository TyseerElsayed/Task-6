// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormate = DateFormat('yyyy/MM/dd  HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Date',
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  )),
              SizedBox(
                width: 3,
              ),
              Icon(
                Icons.access_time,
                size: 35.0,
                color: Colors.lime,
              ),
              SizedBox(
                width: 3,
              ),
              Text('Time',
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  )),
            ],
          ),
          backgroundColor: Colors.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 240,
                    margin: EdgeInsets.only(bottom: 120),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.lightBlue.withOpacity(0.4),
                    ),
                    child:
                        Text('Time now:  ${dateFormate.format(selectedDate)}',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            )),
                  ),
                  InkWell(
                    onTap: () async {
                      final selectedDate = await _selectDateTime(context);
                      if (selectedDate == null) return;
                      print(selectedDate);

                      final selectedTime = await _selectTime(context);
                      if (selectedTime == null) return;
                      print(selectedTime);

                      setState(() {
                        this.selectedDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          dateFormate.format(this.selectedDate),
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                          textColor: Colors.orange,
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 8),
                        backgroundColor: Colors.lightBlue.withOpacity(0.3),
                        elevation: 10.5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ));
                    },
                    splashColor: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        height: 60,
                        width: 250,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Icon(Icons.alarm),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Click to Choose new DateTime',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 3)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));

  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
        initialEntryMode: TimePickerEntryMode.dial);
  }
}
