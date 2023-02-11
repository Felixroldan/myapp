import 'dart:convert';

import 'package:flutter/material.dart';
import 'home.dart';
import 'requests.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
String addStar = """
  mutation (\$username: String!, \$password: String!) {
    tokenAuth(username:\$username, password:\$password) {
		token
    user{
      id
      username
    }
    }
  }
  """;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String _title = 'My App2';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Bad Credentials'),
                Text('If You this is wrong then contact your admin?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> saveTokenInfo(String token, String user) async {
    await storage.write(key: "jwt", value: token);
    await storage.write(key: "userInfo", value: user);
    //await storage.write(key: "isAuth", value: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'PROBANDO GRAPHQL',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Mutation(
                  options: MutationOptions(
                    document: gql(
                        addStar), // this is the mutation string you just created
                    // you can update the cache based on results
                    update: (GraphQLDataProxy cache, QueryResult? result) {
                      return cache;
                    },
                    // or do something with the result.data on completion
                    onCompleted: (dynamic resultData) {
                      print(resultData);
                      if (resultData != null) {
                        final token = resultData['tokenAuth']['token'];
                        final user = (resultData['tokenAuth']['user']).toString();
                        print(token);
                        print(user);
                        //print(resultData['tokenAuth']['user']['username']);
                        //String userinfo = json.toString(resultData['tokenAuth']['user']);
                        saveTokenInfo(token,user);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabBarDemo()));
                      } else {
                        _showMyDialog();
                      }
                    },
                  ),
                  builder: (
                    RunMutation Login,
                    QueryResult? result,
                  ) {
                    return ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        Login({
                          'username': nameController.text,
                          'password': passwordController.text,
                        });
                        print(nameController.text);
                        print(passwordController.text);
                        //print(result);
                      },
                    );
                  }),
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}

class MyHomePage extends StatelessWidget {
  final String readCounters = """
    query getFlights {
        allFlights{
          id
          flightNumber
        }
    }
""";
  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      home: Scaffold(
        appBar: AppBar(title: const Text("")),
        body: const MyStatefulWidget(),
      ),
    );
  }
}*/
  @override
  Widget build(BuildContext) {
    return Query(
        options: QueryOptions(
          document: gql(readCounters),
          /*  variables: {
          'counterId': 23,
        },*/
          pollInterval: Duration(seconds: 10),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return Text('Loading');
          }

          // it can be either Map or List
          final List<dynamic> flights =
              result.data!["allFlights"] as List<dynamic>;
          print(flights.length);
          //print(storage.read(key: "jwt"));
          //print(storage.read(key: "userInfo"));
          return ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final repository = flights[index];

                return Text((flights[index]['flightNumber']).toString());
              });
        });
  }
}
