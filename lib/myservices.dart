import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:myapp/googlemaps.dart';
import 'package:myapp/models/Blog.dart';
import 'package:myapp/servicedetails.dart';

class MyServiceList extends StatelessWidget {
  const MyServiceList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Welcome to AWS s3'),
          ),
          //
          Expanded(
            child: StreamBuilder<QuerySnapshot<Blog>>(
              stream: Amplify.DataStore.observeQuery(Blog.classType),
              builder:((context, snapshot) {
                if(snapshot.data == null){
                return const Center(
                  child: CircularProgressIndicator(),
                );
                }else {
                  return ListView.builder(
                      itemCount: snapshot.data!.items.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                             print("Click event on Container");
                                const snackBar =
                                    SnackBar(content: Text('Tap on New'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ServiceDetails(
                                            snapshot.data!.items[index].modelIdentifier)));
                          },
                          child: ListTile(
                              title: Text(snapshot.data!.items[index].name),
                            ),
                        );
                      }
                      )
                     );
                      }
              })
              ),
            ),
          const Padding(padding: EdgeInsets.all(8.0),
          child:SignOutButton(),
          ),
       ],
    );
  }
}