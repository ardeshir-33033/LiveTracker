import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationTracker with ChangeNotifier {
  Function(LocationData result) LocationCallback;
  LocationAccuracy accuracy;
  int interval;
  double distanceFilter;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();

  LocationTracker(
      {this.LocationCallback,
      this.accuracy,
      this.distanceFilter,
      this.interval}) {
    if (interval == null) {
      interval = 1000;
    }
    if (distanceFilter == null) {
      distanceFilter = 1;
    }
  }

  void Start() {
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    try {
      var location = await _locationTracker.getLocation();
      _locationTracker.changeSettings(
          accuracy: accuracy ?? LocationAccuracy.low,
          interval: interval,
          distanceFilter: distanceFilter);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (LocationCallback != null) {
          LocationCallback(
            newLocalData,
          );
        }
        print("speed:${newLocalData.speed}");
        print("height:${newLocalData.altitude}");
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }
}
