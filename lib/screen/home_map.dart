import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:location/location.dart';

class HomeMapScreen extends StatefulWidget {
  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  final Set<Marker> _markers = {};
  late GoogleMapController mapController;
  late mongo.Db db;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _fetchChargingStations();
  }

  void _checkLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 14,
      )));
    });
  }

  void _fetchChargingStations() async {
    db = mongo.Db('mongodb+srv://sai_app_connection:sai@igpelectricalvehiclepro.2ftpj5l.mongodb.net/IgpElectricalVehicleProject?retryWrites=true&w=majority');
    await db.open();
    var collection = db.collection('Stations');
    var chargingStations = await collection.find(mongo.where.exists('ChargeDeviceName').fields([
      'ChargeDeviceName',
      'ChargeDeviceLocation.Latitude',
      'ChargeDeviceLocation.Longitude',
    ])).toList();

    setState(() {
      _markers.clear();
      for (var station in chargingStations) {
        final marker = Marker(
          markerId: MarkerId(station['_id'].toString()),
          position: LatLng(
            station['ChargeDeviceLocation']['Latitude'],
            station['ChargeDeviceLocation']['Longitude'],
          ),
          infoWindow: InfoWindow(title: station['ChargeDeviceName']),
        );
        _markers.add(marker);
      }
    });

    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //... (the rest of your Scaffold code)
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0), // Default location, will update to current location upon retrieval
          zoom: 11.0,
        ),
        markers: _markers,
      ),
      //... (the rest of your Scaffold code)
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    location.onLocationChanged.listen((LocationData currentLocation) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
            zoom: 14.0,
          ),
        ),
      );
    });
  }
}
