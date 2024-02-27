import 'package:mongo_dart/mongo_dart.dart';
import 'package:string_similarity/string_similarity.dart';

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
    //print(data);
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

  Future<List<Map<String, dynamic>>> searchTitleInUni() async {
    final text = "RNA"; // Check if field equals the specified name

    final List<Map<String, dynamic>> documents = await uni.find().toList();

    final List<Map<String, dynamic>> results = [];
    for (var doc in documents) {
      final String title = doc['Title'] ?? '';
      final double similarity = title.similarityTo(text);
      if (similarity > 0.01) {
        results.add(doc);
      }
    }

    return results;
  }

  Future<List<Map<String, dynamic>>> searchAuthorsInUni() async {
    
    final List<Map<String, dynamic>> documents = await uni.find().toList();
    String searchText = "Lakshmi";
    
    final List<Map<String, dynamic>> results = [];
    for (var doc in documents) {
      for (int i = 1; i <= 6; i++) {
        final String authorField = 'a$i';
        final String authorName =
            doc[authorField] ?? ''; // Extract the author name from the document
        final double similarity = authorName.similarityTo(
            searchText); // Calculate similarity between author name and searchText
        if (similarity > 0.8) {
          // Adjust this threshold based on your requirements
          results.add(
              doc); // If similarity is above threshold, add the document to results
          break; // Move to the next document after finding a match for any author
        }
      }
    }

    return results;
  }


  //version2
  Future<List<Map<String, dynamic>>> searchAuthors2InUni() async {


  final List<Map<String, dynamic>> documents = await uni.find().toList();
  String searchText = "Padegal";
  // Perform fuzzy matching on each document's authors
  final List<Map<String, dynamic>> results = [];
  for (var doc in documents) {
    final Map<String, dynamic> authorsMap = Map<String, dynamic>.from(doc['Authors'] ?? {}); // Extract the authors field from the document
    for (var author in authorsMap.values) { // Iterate over the values in the authors map
      final double similarity = author.toString().similarityTo(searchText); // Calculate similarity between author name and searchText
      if (similarity > 0.2) { // Adjust this threshold based on your requirements
        results.add(doc); // If similarity is above threshold, add the document to results
        break; // Move to the next document after finding a match for any author
      }
    }
  }


  return results;
}
}
