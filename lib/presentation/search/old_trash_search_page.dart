// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController searchController = TextEditingController();
//   List<DocumentSnapshot> doctors = [];
//   List<DocumentSnapshot> filteredDoctors = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDoctors();
//   }

//   fetchDoctors() async {
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('doctors').get();
//     setState(() {
//       doctors = snapshot.docs;
//       filteredDoctors = doctors;
//     });
//   }

//   void filterDoctors(String query) {
//     final results = doctors.where((doctor) {
//       final name = doctor['name'].toString().toLowerCase();
//       final department = doctor['department'].toString().toLowerCase();
//       final input = query.toLowerCase();
//       return name.contains(input) || department.contains(input);
//     }).toList();

//     setState(() {
//       filteredDoctors = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Doctors'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: searchController,
//             decoration: const InputDecoration(
//                 labelText: 'Search by Name or Department'),
//             onChanged: filterDoctors,
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredDoctors.length,
//               itemBuilder: (context, index) {
//                 var doctor = filteredDoctors[index];
//                 var name = doctor['name'];
//                 var department = doctor['department'];
//                 var input = searchController.text.toLowerCase();
//                 var matchType = name.toLowerCase().contains(input)
//                     ? 'Doctor'
//                     : 'Department';

//                 return ListTile(
//                   title: Text(name),
//                   subtitle: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(department),
//                       Text(
//                         matchType,
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
