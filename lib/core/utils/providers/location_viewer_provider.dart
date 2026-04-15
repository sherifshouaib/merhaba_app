import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class LocationViewerProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final MapController _mapcontroller = MapController.withUserPosition(
    trackUserLocation: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );

  MapController get mapController => _mapcontroller;

  GeoPoint _currentLocation = GeoPoint(latitude: 0, longitude: 0);
  GeoPoint get currentLocation => _currentLocation;

  setCurrentLocation() async {
    try {
      _currentLocation = await _mapcontroller.myLocation();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
