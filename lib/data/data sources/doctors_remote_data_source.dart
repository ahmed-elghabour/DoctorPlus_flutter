import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorsRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getRecommendedDoctors(
      {required String patientId}) async {
    try {
      final doctorsCollection = firestore.collection("doctors");
      final QuerySnapshot querySnapshot =
          await doctorsCollection.limit(5).get();

      final List<Map<String, dynamic>> doctors = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return doctors;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> getAllDoctors() async {
    try {
      final doctorsCollection = firestore.collection("doctors");
      final QuerySnapshot querySnapshot = await doctorsCollection.get();

      final List<Map<String, dynamic>> doctors = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return doctors;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> searchDoctors(String query) async {
    try {
      final doctorsCollection =
          FirebaseFirestore.instance.collection('doctors');

      // Fetch documents where fName or lName contains the query string
      final QuerySnapshot fNameSnapshot = await doctorsCollection
          .where('fName', isGreaterThanOrEqualTo: query)
          .where('fName', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      final QuerySnapshot lNameSnapshot = await doctorsCollection
          .where('lName', isGreaterThanOrEqualTo: query)
          .where('lName', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      // Combine the results from both queries
      final List<DocumentSnapshot> allDocs = [
        ...fNameSnapshot.docs,
        ...lNameSnapshot.docs,
      ];

      // Remove duplicates (if any) based on document ID
      final Set<String> docIds = {};
      final List<DocumentSnapshot> uniqueDocs = [];
      for (var doc in allDocs) {
        if (!docIds.contains(doc.id)) {
          docIds.add(doc.id);
          uniqueDocs.add(doc);
        }
      }

      // Further filter the documents on the client side to ensure the query is contained
      final List<DocumentSnapshot> filteredDocs = uniqueDocs.where((doc) {
        final fName = doc.get('fName').toString().toLowerCase();
        final lName = doc.get('lName').toString().toLowerCase();
        return fName.contains(query.toLowerCase()) ||
            lName.contains(query.toLowerCase());
      }).toList();

      final List<Map<String, dynamic>> doctors = filteredDocs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return doctors;
    } catch (e) {
      throw Exception(e);
    }
  }
}
