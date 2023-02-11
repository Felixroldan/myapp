import 'dart:async';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DbLite with ChangeNotifier{ 

   DbLite(this.dbname) {
    database = _openDB();
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
   
  }

  final String dbname;
  Future<Database>? database; 
  int count = 0;
  
  Future<Database> _openDB () async {
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  return await openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), dbname),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE servicemsgs (id INTEGER PRIMARY KEY AUTOINCREMENT, fromwho TEXT, service TEXT, readed BOOLEAN, denied BOOLEAN, accepted BOOLEAN)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1
    );
    }
  // Define a function that inserts dogs into the database
  Future<void> insertServiceMsg(ServiceMsg msg) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db!.insert(
      'servicemsgs',
      msg.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    count++;
    notifyListeners();
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<ServiceMsg>> getAllServiceMsgs() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db!.query('servicemsgs');
    print("Solicitudes:, ${maps.length}");
    // Convert the List<Map<String, dynamic> into a List<Services>.
    return List.generate(maps.length, (i) {
      return ServiceMsg(
        id: maps[i]['id'],
        fromwho: maps[i]['fromwho'],
        service: maps[i]['service'],
        readed: maps[i]['readed'],
        denied: maps[i]['denied'],
        accepted: maps[i]['accepted'],
      );
    });

      
  }

  Future<void> updateService(ServiceMsg msg) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db!.update(
      'servicemsg',
      msg.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [msg.id],
    );
  }

  Future<void> deleteService(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db!.delete(
      'servicemsg',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
  // Create a Dog and add it to the dogs table
  /*var fido = const Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertDog(fido);

  // Now, use the method above to retrieve all the dogs.
  print(await dogs()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await updateDog(fido);

  // Print the updated results.
  print(await dogs()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await deleteDog(fido.id);

  // Print the list of dogs (empty).
  print(await dogs());
}
//        'CREATE TABLE serviceMsgs (id INTEGER PRIMARY KEY AUTOINCREMENT, from TEXT, service TEXT, readed BOOLEAN, denied BOOLEAN, accepted BOOLEAN)',
*/
class ServiceMsg {
  int? id;
  final String fromwho;
  final String service;
  final int readed;
  final int denied;
  final int accepted;

  ServiceMsg({
    this.id,
    required this.fromwho,
    required this.service,
    this.readed = 0,
    this.denied = 0,
    this.accepted = 0,
  });
  
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromwho': fromwho,
      'service': service,
      'readed': readed,
      'denied': denied,
      'accepted': accepted,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Service {id: $id, from: $fromwho, service: $service}';
  }
}

class Service {
  final String _destino;
  final double _latitude;
  final double _longitude;

  Service(this._destino, this._longitude, this._latitude);

  Service.fromJson(Map<String, dynamic> json)
      : _destino = json['name'],
        _latitude= double.parse(json['latitude']),
        _longitude = double.parse(json['longitude']);

  Map<String, dynamic> toJson() => {
        'name': _destino,
        'latitude': _latitude,
        'longitude': _longitude,
      };
  LatLng toLatLng(){
    return LatLng(_latitude
    , _longitude);
  }

  String getName(){
    return _destino;
  }
}