import 'dart:io';

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/Blog.dart';
import 'myservices.dart';
import 'screens/camera.dart';
import 'servicedetails.dart';
import 'package:workmanager/workmanager.dart';
import 'servicesreq.dart';

class TabBarDemo extends StatefulWidget {
  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  late List<CameraDescription > cameras = []; 
    
  @override
  void initState(){
    super.initState();

    // Obtain a list of the available cameras on the device.
    // Get a specific camera from the list of available cameras.
   // initFirstCamera();
  }

  Future<void> initFirstCamera() async {
    // Obtain a list of the available cameras on the device.
    //final cameras = await availableCameras();
    if(cameras.length ==0)
      {
        await availableCameras().then((value) {
        setState(() {
          cameras = value;
        }); 
    });
  }
}
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.flight_takeoff)),
                Tab(icon: Icon(Icons.flight_takeoff)),
                Tab(icon: Icon(Icons.camera_alt)),
              ],
            ),
            title: Text('Service Request'),
            actions: [
              IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final blog = Blog(name: "Test Blog");
                Amplify.DataStore.save(blog);
              },
              ),
              ],
          ),
          body: TabBarView(
            children: [
              MyServiceList(),
              Container(
                   child:
                      ServiceListWidget(),
                      //SignOutButton(),
                    
                  ),
              FutureBuilder(
                    future: initFirstCamera(),
                    builder: (context,snapshot){
                      if(snapshot != null){
                        CameraDescription firstCamera = cameras.first;
                        return DisplayListPictureScreen(camera: firstCamera);
                        
                       /* TakePictureScreen(
                                    // Pass the appropriate camera to the TakePictureScreen widget.
                                  camera: firstCamera,
                                );*/
                      }
                      else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );

                  }
                }
                )
              
                 
              
            ],
          ),
        ),
      ),
    );
  }
}


