import 'package:flutter/material.dart';
import 'package:live_location_component/Tracker.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LocationTracker loc1;
  LocationData TrackedLocation;

  @override
  void initState() {
    // TODO: implement initState
    loc1 = LocationTracker(
      LocationCallback: (result) {
        TrackedLocation = result;
        print("LocationTracked:${TrackedLocation}");
      },
    );
    loc1.Start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  RaisedButton(onPressed: () {
                    loc1.Start();
                    setState(() {

                    });
                  }),
                ],
              ),
            ),
            TrackedLocation == null
                ? Text("data1")
                : Text("Speed:${TrackedLocation.speed}")
          ],
        ),
      ),
    );
  }
}
