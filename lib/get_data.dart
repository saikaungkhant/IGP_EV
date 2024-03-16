import 'package:mongo_dart/mongo_dart.dart';

void main() async {
  var connectionString = 'mongodb+srv://sai_app_connection:sai@igpelectricalvehiclepro.2ftpj5l.mongodb.net/IgpElectricalVehicleProject?retryWrites=true&w=majority'; // mongodb+srv://<username>:<password>@igpelectricalvehiclepro.2ftpj5l.mongodb.net/

  try {
    var db = await Db.create(connectionString);
    await db.open();

    print('Connected to MongoDB!');

    var collection = db.collection('user_info'); // Ensure 'stations' is the correct collection name.

    // Attempt to count documents in the collection
    int documentCount = await collection.count();
    if (documentCount > 0) {
      print('Found $documentCount documents in the collection. Displaying them:');
    } else {
      print('No documents found in the collection.');
      // No documents found, close the database connection.
      await db.close();
      return;
    }

    // Fetch and print each document sorted by '_id'.
    var cursor = collection.find(where.sortBy('_id'));
    await cursor.forEach((document) {
      print(document); // Print each document.
    });

    await db.close();
  } catch (e) {
    print('Error connecting to MongoDB: $e');
  }
}
