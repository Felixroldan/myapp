import 'dart:io';
import 'dart:math';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:dart_amqp/dart_amqp.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/models/ModelProvider.dart';
import 'package:myapp/requests.dart';
import 'package:myapp/servicesreq.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dblite.dart' as db;


//constantes de conexion
const String MQ_HOST = "shrimp.rmq.cloudamqp.com";
const String MQ_VHOST = 'zknwcatx';
const PlainAuthenticator MQ_AUTH = PlainAuthenticator('zknwcatx', 'vZIkCXCN1drpYmY8zZqP9ZboivZnOF2x');
const String MQ_QEUE = "transport_1";
const String MQ_SUBS_EX = "services";
const String MESSAGE_SOURCE = "shrimp.rmq.cloudamqp.com";
class Rabbitmq with ChangeNotifier{
    static ConnectionSettings settings = ConnectionSettings(
      host: MQ_HOST,
      virtualHost: MQ_VHOST,
      authProvider: MQ_AUTH);

//Metodo para subscrirse a un exchange de rabbit     
static Future getDelivery() async {
    print("Connection from shrimp.rmq.cloudamqp.com");//un mensaje de aviso
    Client client = Client(settings: settings);     //instanciamos con la configuracion de alwaysdata.net
    //se Crea el exchange a donde se subscribe este cliente.
    client
        .channel()
        .then((Channel channel) {
            return channel.exchange(MQ_SUBS_EX, ExchangeType.FANOUT, durable: false);
        })
        .then((Exchange exchange) {
            print(" [*] Waiting for messages in logs. To Exit press CTRL+C");
            return exchange.bindPrivateQueueConsumer(null);
        })
        .then((Consumer consumer) {

            consumer.listen((AmqpMessage event) //Se espera por los mensajes provenientes del servidor.
            {
                print(" [x] Received ${event.payloadAsString}");//log to terminal
                
                //ServiceMsg _msg = ServiceMsg(fromwho: "rabbitmq-adriitours.alwaysdata.net", service: event.payloadAsString);
                               
                Rabbitmq()._showNotification(event.payloadAsString,"shrimp.rmq.cloudamqp.com");

                final blog = Blog(name: event.payloadAsString);
                final serviceInfo = db.Message.fromJson(jsonDecode(event.payloadAsString));
                //Amplify.DataStore.save(Position(latitude: serviceInfo.latitude, longitude: serviceInfo.longitude));
                final newService = Service(name: serviceInfo.destino, rbmqchanel: "rbmqchanel", servicelat: serviceInfo.latitude,servicelong: serviceInfo.longitude);
                Amplify.DataStore.save(blog);
                Amplify.DataStore.save(newService);
                
                Rabbitmq._saveServiceRequestToStorage(event.payloadAsString);
            }).onError((e,s){
              print("Listen Error: ${e.toString()}");
              sleep((const Duration(seconds: 5)));
              getDelivery();
            });
            }).onError((error, stackTrace) {
              print("Rabbit Error: ${error.toString()}");
              sleep((const Duration(seconds: 5)));
              getDelivery();

            });
        }
  


  Future<void> _showNotification(String text, String from) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    FlutterLocalNotificationsPlugin().initialize(initializationSettings);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin
        .show(0, from, text, platformChannelSpecifics, payload: 'item x');
  }
   
  static void _saveServiceRequestToStorage( String payloadAsString) async  {
      final storage = FlutterSecureStorage();
      var serviceList = await storage.read(key: "serviceList");

      await storage.write(key: "serviceList", value: payloadAsString);

  }
  
  
  }