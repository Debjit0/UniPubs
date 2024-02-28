import 'package:mongo_dart/mongo_dart.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:uni/pages/globalData.dart';

class MongoDatabase {
  static var db, uni;

  Future<List<Map<String, dynamic>>> start() async {
    db = await Db.create(
        "mongodb+srv://debjitfirstname:Debjit2635@cluster0.9sj6ekf.mongodb.net/uni");
    await db.open();
    uni = db.collection("uni");
    print("Connection to MongoDB established");
    allData = await uni.find().toList();
    print(allData);
    return allData;
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
    return await uni.find().toList();
  }

  Future<void> close() async {
    await db.close();
    print("Connection to MongoDB closed");
  }

  Future<List<Map<String, dynamic>>> searchTitleInUni() async {
    final text = "RNA"; // Check if field equals the specified name

    final List<Map<String, dynamic>> results = [];
    for (var doc in allData) {
      final String title = doc['Title'] ?? '';
      final double similarity = title.similarityTo(text);
      if (similarity > 0.01) {
        results.add(doc);
      }
    }

    return results;
  }

  Future<List<Map<String, dynamic>>> searchAuthorsInUni() async {
    String searchText = "Lakshmi";

    final List<Map<String, dynamic>> results = [];
    for (var doc in allData) {
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
    String searchText = "Padegal";
    // Perform fuzzy matching on each document's authors
    final List<Map<String, dynamic>> results = [];
    for (var doc in allData) {
      final Map<String, dynamic> authorsMap =
          Map<String, dynamic>.from(doc['Authors'] ?? {});
      for (var author in authorsMap.values) {
        final double similarity = author.toString().similarityTo(searchText);
        if (similarity > 0.2) {
          results.add(doc);
          break;
        }
      }
    }

    return results;
  }

  //graph
  Future<List<Map<String, dynamic>>> getDataFromMongoDB() async {
    // Process the data to count publications yearly
    allData = await uni.find().toList();
    Map<int, int> yearlyCounts = {};
    for (final publication in allData) {
      final int year = publication['Year'];
      yearlyCounts.update(year, (value) => value + 1, ifAbsent: () => 1);
    }

    // Prepare data for graph
    List<Map<String, dynamic>> yearlyData = [];
    yearlyCounts.forEach((year, count) {
      yearlyData.add({'year': year, 'count': count});
    });
    return yearlyData;
  }
}
