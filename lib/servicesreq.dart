import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dblite.dart';

class ServiceListWidget extends StatefulWidget {
    @override
    _ServiceListWidgetState createState() => _ServiceListWidgetState();
}

class _ServiceListWidgetState extends State<ServiceListWidget> {
   Future<void>? _getServices() async {
        DbLite db = DbLite("myservices");
        var res = await db.getAllServiceMsgs(); 
        setState((){
            _services = res.where((i) => i.service.startsWith("{\"l")).toList();
        });

    }  
    List<ServiceMsg>? _services;
    @override
    initState(){
        super.initState();
        _getServices();
    }

 
    

    @override
    Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          title: Text('List Of Employees'),
          ),
          body: _services==null ? Container():
             requestWidget(services: _services)
      );

    }
}

class requestWidget extends StatelessWidget {
  const requestWidget({
    Key? key,
    required List<ServiceMsg>? services,
  }) : _services = services, super(key: key);

  final List<ServiceMsg>? _services;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
    itemCount: _services!.length,
    itemBuilder: (_, int position) {
    if(_services![position].service.startsWith("{\"l")){
        Map<String, dynamic> serviceMap = jsonDecode(_services![position].service);
        var _service = Service.fromJson(serviceMap);       
        return Card(
        child: ListTile(
            title:
                Text("Service Destination:  ${_service.getName()}"),
                //${context.watch<DbLite>().count}"),
            subtitle:
                Text("Localizacion:  ${_service.toLatLng().latitude.toString()} , ${_service.toLatLng().longitude.toString()}")
        ),
        );
        }
    else
        return Card(
          child: ListTile(
              title:
                  Text("Service Detination:  error, ${_services![position].service} , ${context.watch<DbLite>().dbname}"),
              subtitle:
                  Text("Localizacion:  Not Found , ${_services![position].service}"),
          ),
        );
    }
            );
  }
}