import 'package:flutter/material.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:myapp/requests.dart';
class AWSAuth extends StatelessWidget {
  const AWSAuth({super.key, } );
  @override
  Widget build(BuildContext context) {
    return  Authenticator(
       child: MaterialApp(
          builder: Authenticator.builder(),
          //title: 'Material App',
          home: TabBarDemo()
        ),
      );
  
  }
}