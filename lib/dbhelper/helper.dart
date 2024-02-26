import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, uni;

  Future<void> start() async {
    db = await Db.create(
        "mongodb+srv://debjitfirstname:Debjit2635@cluster0.9sj6ekf.mongodb.net/uni");
    await db.open();
    uni = db.collection("uni");
    print("Connection to MongoDB established");
    print(await uni.find().toList());
  }

  Future<List<Map<String, dynamic>>> getQueryData(String searchString) async {
    // Build the $or conditions dynamically based on the existing fields
    final orConditions = [];
    for (int i = 1; i <= 8; i++) {
      final field = 'a$i';
      final condition = {
        field: searchString
      }; // Check if field equals the specified name
      orConditions.add(condition);
    }

    // Construct the query with the $or conditions
    final query = {
      'authors': {
        r'$elemMatch': {r'$or': orConditions}
      }
    };
    final List<Map<String, dynamic>> data = await uni.find(query).toList();
    print(data);
    return data;
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final data = await uni.find().toList();
    return data;
  }

  Future<void> close() async {
    await db.close();
    print("Connection to MongoDB closed");
  }
}
