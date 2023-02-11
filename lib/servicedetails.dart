import 'dart:collection';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json, base64, ascii;
//import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/dblite.dart';
import 'package:myapp/models/Blog.dart';
import 'googlemaps.dart';
import 'home.dart';
import 'models/Blog.dart';
import 'dart:convert';

class ServiceDetails extends StatefulWidget {
  ServiceDetails(this.serviceId);
  final BlogModelIdentifier serviceId;
  @override
  _ServiceState createState() => _ServiceState(serviceId);
}

class _ServiceState extends State<ServiceDetails> {
  String fullMessage = '';
 
  _ServiceState(this.serviceId){
        readItemFromDatabase(serviceId);
        }
  
   BlogModelIdentifier serviceId = BlogModelIdentifier(id: '0');
   Future<Position>? _currentPosition;
   Position? _actualPosition;
   String? _currentAddress;
   String? _positionError;
  /*factory HomePage.fromBase64(String jwt) => HomePage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));
*/
  @override
  void initState() {
    super.initState();
    _currentPosition = _determinePosition();
    }
  
  
  final String flightById = """
    query getFlightById(\$flightId:ID) {
        flightById(id:\$flightId){
          id
          flightNumber
          airline{
            id
            iata
            name
          }
        }
    }
  """;
  // final Map<String, dynamic> payload;
  
  //imprime la posicion actual
/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
  
}

//aqui se devuelve la direccion de una forma legible...esto no hay que mandarlo para probar si....
_getAddressFromLatLng(Position _currentPosition) async {
   final Geolocator geolocator = Geolocator();
    try {
      List<Placemark> p = await GeocodingPlatform.instance.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Service Details")),
      body: Column(children: [
          ServiceDetailView(),
          GetPositionBuilder()
      ],)
          
                
  );
  Future<void> readItemFromDatabase(BlogModelIdentifier modelIdentifier) async {
  await Amplify.DataStore.query(Blog.classType, where: Blog.MODEL_IDENTIFIER.eq(modelIdentifier))
    .then((value) {
      print('Blog: $value.name');
      setState(() {
          fullMessage = value[0].name;
        });
    }).onError((error, stackTrace)  {
    print('Query failed: $error');
  });
}
  Container ServiceDetailView() {
    Message msgObj = Message("destino", 0, 0);
    print(fullMessage);
    try {
      msgObj = Message.fromJson(jsonDecode(fullMessage));
    } catch (e) {
      print(e.toString());
    }
    return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
                  onTap: () {
                    print("Click event on Details");
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyMap()));
                  },
                  child: Builder(
                    builder: (context) {
                      return Card(
                          child: ListTile(
                              title: Text("Destino: ${msgObj.Destino}"),
                              subtitle: Text(msgObj.getLatLongAsString()),
                              leading: CircleAvatar(),
                              trailing: Icon(Icons.star)),
                              
                              );
                    }
                  )
                          )
                          );

      }
  FutureBuilder<Position> GetPositionBuilder() {
    return FutureBuilder<Position>(
                                future: _currentPosition,
                                 builder: (
                                    BuildContext context,
                                    AsyncSnapshot<Position> snapshot,
                                    ) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        Visibility(
                                          visible: snapshot.hasData,
                                          child: Text(
                                            "Rcibida la posicion",
                                            style: const TextStyle(color: Colors.black, fontSize: 24),
                                          ),
                                        ),
                                        Text(
                                            "Loading Position",
                                            style: const TextStyle(color: Colors.black, fontSize: 24),
                                          )

                                      ],
                                      
                                    );
                                  } else if (snapshot.connectionState == ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return const Text('Error');
                                    } else if (snapshot.hasData) {
                                      _actualPosition = snapshot.data;
                                      _getAddressFromLatLng(snapshot.data!);
                                      return Column (
                                        children: [
                                          Card(
                                            child: ListTile(
                                              title:  Text(
                                                snapshot.data!.latitude.toString()+","+snapshot.data!.longitude.toString(),
                                                style: const TextStyle(color: Colors.cyan, fontSize: 20)
                                                ),
                                                leading:Icon(Icons.location_on),
                                            ),
                                      ),
                                      if(_actualPosition !=null)
                                        Container( 
                                          height:600,
                                          child: MyGoogleMaps(_actualPosition),
                                          )
                                        
                                     /* if (_currentAddress != null)
                                           Card(
                                            child: ListTile(
                                              title: Text(_currentAddress!,
                                              style:
                                              Theme.of(context).textTheme.bodyText2),
                                              leading:Icon(Icons.location_on),))
                                              // + (_currentPosition!.longitude).toString() +"," +(_currentPosition!.latitude).toString()
                                      else  
                                          Card(
                                            child: ListTile(
                                              title:Text ("Error Gettig Current Address from Position ",
                                                    style:
                                                      Theme.of(context).textTheme.bodyText2
                                                    ),
                                                    leading:Icon(Icons.location_on),))*/
                                       ],
                                      );
                                    } else {
                                      return const Text('Empty data');
                                    }
                                  } else {
                                    return Text('State: ${snapshot.connectionState}');
                                  }
                                },
                              );
  }         

}
class Message {
   final String destino;
   final double longitude;
   final double latitude;

   Message(this.destino,this.latitude,this.longitude);

   String get Destino{
    return destino;
   }

  LatLng getLatLng(){
    return LatLng(latitude,longitude);
   }
  
  String getLatLongAsString(){
    return latitude.toString()+","+longitude.toString();
  }

  Message.fromJson(Map<String, dynamic> jsonMsg)
      : destino = jsonMsg['name'],
        latitude= double.parse(jsonMsg['latitude']),
        longitude = double.parse(jsonMsg['longitude']);
}
  
  /*Container FlightDetailsView() {
    return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Query(
        options: QueryOptions(
          document: gql(flightById),
          variables: {
            'flightId': 35,
          },
          pollInterval: Duration(seconds: 30),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Text("Error Loading Flights");
          }

          if (result.isLoading) {
            CircularProgressIndicator();
            return Text('Loading');
          }

          // it can be either Map or List
          // final map<dynamic> flight =
          var flight = result.data!['flightById'];
          print(flight);
          //print();
          //print(storage.read(key: "jwt"));
          //print(storage.read(key: "userInfo"));
          return GestureDetector(
              onTap: () {
                print("Click event on Details");
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyMap()));
              },
              child: Card(
                  child: ListTile(
                      title: Text((flight['airline']['iata']).toString() +
                          (flight['flightNumber']).toString()),
                      subtitle: Text((flight['airline']['name']).toString()),
                      leading: CircleAvatar(),
                      trailing: Icon(Icons.star))
                      )
                      );
        }
        )
              );*/
  /*  Container FlightDetailsView() {
    return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Query(
        options: QueryOptions(
          document: gql(flightById),
          variables: {
            'flightId': serviceId,
          },
          pollInterval: Duration(seconds: 30),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Text("Error Loading Flights");
          }

          if (result.isLoading) {
            CircularProgressIndicator();
            return Text('Loading');
          }

          // it can be either Map or List
          // final map<dynamic> flight =
          var flight = result.data!['flightById'];
          print(flight);
          //print();
          //print(storage.read(key: "jwt"));
          //print(storage.read(key: "userInfo"));
          return GestureDetector(
              onTap: () {
                print("Click event on Details");
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyMap()));
              },
              child: Card(
                  child: ListTile(
                      title: Text((flight['airline']['iata']).toString() +
                          (flight['flightNumber']).toString()),
                      subtitle: Text((flight['airline']['name']).toString()),
                      leading: CircleAvatar(),
                      trailing: Icon(Icons.star))
                      )
                      );
        }
        )
      );*/
  
              /*Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                      child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (_currentPosition != null &&
                                        _currentAddress != null)
                                      Text(_currentAddress!,
                                          style:
                                              Theme.of(context).textTheme.bodyText2)
                                              // + (_currentPosition!.longitude).toString() +"," +(_currentPosition!.latitude).toString()
                        else          Text ("Error reading gps: ",
                                          style:
                                              Theme.of(context).textTheme.bodyText2)
                                              ],
                      )
              ),
            ]
         )
       ]
     )

    ),*/
       /*       Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                      child:  GetPositionBuilder(),
                      )
                    ],
                  ),
                ]
               )
              ),
            /* Container( 
              height: 500,
              child: GetPositionBuilder(),
             )*/
              
            ]
         );
  }
*/
  

