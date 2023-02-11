import 'package:flutter/material.dart';
import "dart:io";
import "package:dart_amqp/dart_amqp.dart";

class ConsumeRMQ extends StatelessWidget {
  ConsumeRMQ();

  Future<void> consume() async {
    ConnectionSettings settings = ConnectionSettings(
        host: "rabbitmq-adriitours.alwaysdata.net",
        virtualHost: 'adriitours_rabbit',
        authProvider: PlainAuthenticator('adriitours', 'adriiadmin'));
    Client client = Client(settings: settings);
    Channel channel = await client.channel();
    Exchange exchange = await channel.exchange("services", ExchangeType.FANOUT);
    Consumer consumer = await exchange.bindPrivateQueueConsumer(null);
    print(
        " [*] Waiting for logs on private queue ${consumer.queue.name}. To exit, press CTRL+C");
    consumer.listen((message) {
      print(" [x] ${message.payloadAsString}");
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Service Details")),
      body: GestureDetector(
          onTap: () {
            print("Click event on Container");
            const snackBar = SnackBar(content: Text('Tap on New'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServiceDetails(
                      newflights[index]['id'])));*/
          },
          child: Card(
              child: ListTile(
                  title: Text(""),
                  subtitle: Text(""),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                  trailing: Icon(Icons.star)))));
}
