import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_datastore/amplify_datastore_stream_controller.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/AwsWebbinarExample.dart';
import 'package:myapp/amplifyconfiguration.dart';
import 'package:myapp/home.dart';
import 'package:myapp/models/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'dart:convert' show json, base64, ascii;
//import 'login.dart';
import 'requests.dart';
//import "dart:io";
import "package:dart_amqp/dart_amqp.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'rabbit.dart';
import 'package:rxdart/rxdart.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';


final storage = FlutterSecureStorage();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

NotificationAppLaunchDetails? notificationAppLaunchDetails;

Future<void> _configureAmplify() async {
  //falta configurar la app para ios
  try{
    //add Amplify Plugins
    final amplifyDataStore = AmplifyDataStore(modelProvider: ModelProvider.instance);
    final amplifyAuthCognito = AmplifyAuthCognito();
    await Amplify.addPlugins([amplifyAuthCognito,amplifyDataStore]);

    //configure Amplify
    await Amplify.configure(amplifyconfig);
  }catch (e) {
    print('An error ocurred while configuring Amplify: $e');
  }
}

void main() async {

    //Aqui escuchamos los mensajes de la cola....
    Rabbitmq.getDelivery();
    WidgetsFlutterBinding.ensureInitialized();

    await _configureAmplify();
    //runApp(MyMap());
    runApp(AWSAuth());
  
}

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);
  const MyApp();
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();  
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                       TabBarDemo(),
                        //SecondScreen(receivedNotification.payload),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabBarDemo()),//SecondScreen(payload)),
      );
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Authentication Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Text("Hello")
    
    );
  }


}
