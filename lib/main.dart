import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DataClass.dart';
import 'appointmentdata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'In App Calender'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _focusedDay = DateTime.now();

  var isSelected;
  List<Widget> isdayList = <Widget>[
    Text('Day'),
    Text('Week'),
  ];
  final List<bool> _selectedisday = <bool>[true, false];
  bool vertical = false;

  @override
  void initState() {
    Data.createData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedisday.length; i++) {
                    _selectedisday[i] = i == index;
                  }

                  if (_selectedisday[0] == true) {
                    _rangeSelectionMode = RangeSelectionMode.toggledOff;
                  } else {
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              selectedBorderColor: Colors.blue[700],
              borderColor: Colors.blue[700],
              selectedColor: Colors.white,
              fillColor: Colors.blue[700],
              color: Colors.blue[400],
              constraints: const BoxConstraints(
                minHeight: 30.0,
                minWidth: 50.0,
              ),
              isSelected: _selectedisday,
              children: isdayList,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: Center(
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: _rangeSelectionMode,
            onDaySelected: (selectedDay, focusedDay) {
              print("onDaySelected");
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
                _rangeStart = null; // Important to clean those
                _rangeEnd = null;
                _rangeSelectionMode = RangeSelectionMode.toggledOff;
              });

              showModalBottomSheet(
                context: context,
                // color is applied to main screen when modal bottom screen is displayed
                //barrierColor: Colors.greenAccent,
                //background color for modal bottom screen
                backgroundColor: Colors.white,
                //elevates modal bottom screen
                elevation: 10,
                // gives rounded corner to modal bottom screen
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                builder: (BuildContext context) {
                  // UDE : SizedBox instead of Container for whitespaces
                  return bListView();
                },
              );
            },
            onRangeSelected: (start, end, focusedDay) {
              print("onRangeSelected");
              print(start);
              print(end);

              setState(() {
                _selectedDay = null;
                _focusedDay = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                if (end == null) {
                  _rangeEnd = start;
                }
                _rangeSelectionMode = RangeSelectionMode.toggledOn;

                showModalBottomSheet(
                  context: context,
                  // color is applied to main screen when modal bottom screen is displayed
                  //barrierColor: Colors.greenAccent,
                  //background color for modal bottom screen
                  backgroundColor: Colors.white,
                  //elevates modal bottom screen
                  elevation: 10,
                  // gives rounded corner to modal bottom screen
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  builder: (BuildContext context) {
                    return rangeListView(_rangeStart!, _rangeEnd!);
                  },
                );
              });
            },
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class bListView extends StatefulWidget {
  const bListView({super.key});

  @override
  State<bListView> createState() => _bListViewState();
}

class _bListViewState extends State<bListView> {
  List<AppointmentData> mainData = Data.allData;

  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: 80,
              height: 5,
              color: Colors.grey.shade300,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter = 1;
                    //mainData.clear();
                    mainData = Data.allData;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "All (${Data.allData.length})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    counter == 1
                        ? Container(
                            height: 3,
                            width: 80,
                            color: Colors.blue,
                          )
                        : Container(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter = 2;
                    //mainData.clear();
                    mainData = Data.hrdData;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "HRD (${Data.hrdData.length})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    counter == 2
                        ? Container(
                            height: 3,
                            width: 80,
                            color: Colors.blue,
                          )
                        : Container(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter = 3;
                    //mainData.clear();
                    mainData = Data.techData;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Tech (${Data.techData.length})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    counter == 3
                        ? Container(
                            height: 3,
                            width: 80,
                            color: Colors.blue,
                          )
                        : Container(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter = 4;
                    //mainData.clear();
                    mainData = Data.followupData;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Follow up (${Data.followupData.length})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    counter == 4
                        ? Container(
                            height: 3,
                            width: 80,
                            color: Colors.blue,
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: mainData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // height: 50,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mainData[index].name!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                _makePhoneCall(mainData[index].phoneNumber!);
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade500,
                                          blurRadius: 5)
                                    ]),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.blue.shade300,
                                  size: 24.0,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "ID: ${mainData[index].id}",
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Offered : '),
                              TextSpan(
                                  text: '${mainData[index].offered}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Current : '),
                              TextSpan(
                                  text: '${mainData[index].current}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Text(
                          "\u2022 ${Data.allData[index].priority}",
                          style: mainData[index]
                                  .priority!
                                  .contains("Medium Priority")
                              ? TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("due Date\n${mainData[index].dueDate}"),
                            Text("Level\n${mainData[index].level}"),
                            Text("Days Left\n${mainData[index].daysLeft}"),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

class rangeListView extends StatefulWidget {
  DateTime rangeStart, rangeEnd;
  rangeListView(this.rangeStart, this.rangeEnd, {super.key});
  List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  @override
  State<rangeListView> createState() => _rangeListViewState();
}

class _rangeListViewState extends State<rangeListView> {
  List<AppointmentData> mainData = Data.allData;

  int counter = 1;
  List<int> days = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: 80,
              height: 5,
              color: Colors.grey.shade300,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter = 1;
                    //mainData.clear();
                    mainData = Data.allData;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "All (${Data.allData.length})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    counter == 1
                        ? Container(
                            height: 3,
                            width: 80,
                            color: Colors.blue,
                          )
                        : Container(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter = 2;
                    //mainData.clear();
                    mainData = Data.hrdData;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "HRD (${Data.hrdData.length})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    counter == 2
                        ? Container(
                            height: 3,
                            width: 80,
                            color: Colors.blue,
                          )
                        : Container(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter = 3;
                    //mainData.clear();
                    mainData = Data.techData;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Tech (${Data.techData.length})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    counter == 3
                        ? Container(
                            height: 3,
                            width: 80,
                            color: Colors.blue,
                          )
                        : Container(),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter = 4;
                    //mainData.clear();
                    mainData = Data.followupData;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Follow up (${Data.followupData.length})",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    counter == 4
                        ? Container(
                            height: 3,
                            width: 80,
                            color: Colors.blue,
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: mainData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // height: 50,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 5,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.red),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget.rangeStart.day.toString() + "\n",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              TextSpan(
                                text:
                                    '${widget.months[widget.rangeStart.month - 1]}',
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade500,
                                        blurRadius: 1)
                                  ]),
                              child: Center(
                                child: Text(Data.hrdData.length.toString()),
                              ),
                            ),
                            Text("HRD")
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade500,
                                        blurRadius: 1)
                                  ]),
                              child: Center(
                                child: Text(Data.techData.length.toString()),
                              ),
                            ),
                            Text("Tech")
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade500,
                                        blurRadius: 1)
                                  ]),
                              child: Center(
                                child:
                                    Text(Data.followupData.length.toString()),
                              ),
                            ),
                            Text("Follow Up")
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade600,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          //color: Colors.grey.shade500,
                                          blurRadius: 1)
                                    ]),
                                child: Center(
                                  child: Text(
                                    Data.allData.length.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Text("Total")
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
