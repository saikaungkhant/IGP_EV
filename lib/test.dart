import 'package:mongo_dart/mongo_dart.dart';

Future<void> main() async {
  var connectionString = 'mongodb+srv://sai_app_connection:sai@igpelectricalvehiclepro.2ftpj5l.mongodb.net/IgpElectricalVehicleProject?retryWrites=true&w=majority'; // Replace with your actual connection string
  var db = await Db.create(connectionString);
  await db.open();
  
  print('Connected to the MongoDB Atlas database.');

  var collection = db.collection('Stations');

  // Fetching specific fields: 'ChargeDeviceName', 'Latitude', and 'Longitude'
  await collection.find(
    where.exists('ChargeDeviceName')
    .fields([
      'ChargeDeviceName', 
      'ChargeDeviceLocation.Latitude', 
      'ChargeDeviceLocation.Longitude'
    ])
  ).forEach((document) {
    print('ChargeDeviceName: ${document['ChargeDeviceName']}');
    print('Latitude: ${document['ChargeDeviceLocation']['Latitude']}');
    print('Longitude: ${document['ChargeDeviceLocation']['Longitude']}');
    print('---'); // Separator for readability
  });

  await db.close();
}
