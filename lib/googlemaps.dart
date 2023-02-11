import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/gestures.dart';
class MyGoogleMaps extends StatefulWidget {
  final Position? _initialPosition;
  const MyGoogleMaps(this._initialPosition);

  @override
  State<MyGoogleMaps> createState() => _MyGoogleMapsState();
}

class _MyGoogleMapsState extends State<MyGoogleMaps> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
   
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
 
  // list of locations to display polylines
  List<LatLng> latLen = [
    LatLng(19.0759837, 72.8776559),
    LatLng(28.679079, 77.069710),
    LatLng(26.850000, 80.949997),
    LatLng(24.879999, 74.629997),
    LatLng(16.166700, 74.833298),
    LatLng(12.971599, 77.594563),
  ];
   CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  
  @override
  Widget build(BuildContext context) {
    if(widget._initialPosition!=null){
     _markers.add(Marker(
        markerId: const MarkerId("actualPosition"),
        position: LatLng(widget._initialPosition!.latitude,widget._initialPosition!.longitude)));
    _cameraPosition = CameraPosition(target: LatLng(widget._initialPosition!.latitude,widget._initialPosition!.longitude),zoom: 14);
    }
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
    }
  
    
    

    
       
  

    Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}