import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitalSeconds = "00", digitalMinutes = "00", digitalHours = "00";
  Timer? timer;
  bool started = false;

  List laps = [];
//stop
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

//reset
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitalSeconds = "00";
      digitalMinutes = "00";
      digitalHours = "00";

      started = false;
    });
  }

  void addLaps() {
    String lap = "$digitalHours:$digitalMinutes:$digitalSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  //start function
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      //  else {
      //   localSeconds++;
      // }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitalSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitalMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitalHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.00),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'StopWatch App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "$digitalSeconds:$digitalMinutes:$digitalHours",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 82.00,
                  ),
                ),
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap n${index + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.00,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.00,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      child: Text(
                        (!started) ? "Run" : "Pause",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      addLaps();
                    },
                    icon: Icon(Icons.flag),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      child: Text(
                        'Stop',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
