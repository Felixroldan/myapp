import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/*Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}
*/
// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [];
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            imagePaths.add(image.path); 
            if (!mounted) return;
            //if the picture was taken return to previous list and send the image.path to back
            Navigator.pop(context,image.path);
            // If the picture was taken, display it on a new screen.
            /*await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );*/
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)
      )
      );
  }

// A widget that displays the list of picture taken by the user.

    
}

class DisplayListPictureScreen extends StatefulWidget {
   
   CameraDescription camera;
  DisplayListPictureScreen({super.key, required this.camera});
  @override
  DisplayListPictureScreenState createState() => DisplayListPictureScreenState();
}

class DisplayListPictureScreenState extends State<DisplayListPictureScreen> {
  List<String> imagePaths = [];
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display Pictures')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: 
           ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
            GestureDetector(
              
              onTap: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
              try {
                final String result = await Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) =>  TakePictureScreen(camera: widget.camera)),
                );

                  // When a BuildContext is used from a StatefulWidget, the mounted property
                  // must be checked after an asynchronous gap.
                if (!mounted) return;
                setState(() {
                  if(imagePaths.isEmpty)
                    {
                      imagePaths.add("");
                     }
                  imagePaths[0] = result;
                });

              }
              catch(e){
                    print(e.toString());
              }
              },
              onDoubleTap: () {
                Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) =>  DisplayPictureScreen(imagePath: imagePaths[0])));
              },
              child: 
                ListTile(
                title: Text("Battery Full"),
                subtitle: Text("The battery is full."),
                leading:  CircleAvatar(radius: 50, backgroundImage: imagePaths.length > 0 ?Image.file(File( imagePaths[0])).image : null) ,
                trailing: Icon(Icons.star)),
            ),
            
                        GestureDetector(
              
              onTap: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
              try {
                final String result = await Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) =>  TakePictureScreen(camera: widget.camera)),
                );

                  // When a BuildContext is used from a StatefulWidget, the mounted property
                  // must be checked after an asynchronous gap.
                if (!mounted) return;
                setState(() {
                  if(imagePaths.length < 2)
                    {
                      imagePaths.add("");
                     }
                  imagePaths[1] = result;
                });

              }
              catch(e){
                    print(e.toString());
              }
              },
              onDoubleTap: () {
                Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) =>  DisplayPictureScreen(imagePath: imagePaths[1])));
              },
              child: 
                ListTile(
                title: Text("Battery Full"),
                subtitle: Text("The battery is full."),
                leading:  CircleAvatar(radius: 50, backgroundImage: imagePaths.length > 1 ?Image.file(File( imagePaths[1])).image : null) ,
                trailing: Icon(Icons.star)),
            ),
                        GestureDetector(
              
              onTap: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
              try {
                final String result = await Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) =>  TakePictureScreen(camera: widget.camera)),
                );

                  // When a BuildContext is used from a StatefulWidget, the mounted property
                  // must be checked after an asynchronous gap.
                if (!mounted) return;
                setState(() {
                  if(imagePaths.length < 3)//Esto asi no me gusta 
                    {
                      imagePaths.add("");
                     }
                  if(imagePaths.length < 3)
                    {
                      imagePaths.add("");
                     }
                  imagePaths[2] = result;
                });

              }
              catch(e){
                    print(e.toString());
              }
              },
              onDoubleTap: () {
                Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) =>  DisplayPictureScreen(imagePath: imagePaths[2])));
              },
              child: 
                ListTile(
                title: Text("Battery Full"),
                subtitle: Text("The battery is full."),
                leading:  CircleAvatar(radius: 50, backgroundImage: imagePaths.length > 2 ?Image.file(File( imagePaths[2])).image : null) ,
                trailing: Icon(Icons.star)),
            )          
          
           ],
      )
      );
  }
}