import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdditionalHistoryScreen extends StatefulWidget {
  const AdditionalHistoryScreen({super.key});

  @override
  _AdditionalHistoryScreenState createState() =>
      _AdditionalHistoryScreenState();
}

class _AdditionalHistoryScreenState extends State<AdditionalHistoryScreen> {
  // Collection reference untuk additional details
  final CollectionReference additionalCollection =
      FirebaseFirestore.instance.collection('additional_details');

  // Fungsi untuk menghapus data
  Future<void> deleteData(String docId) async {
    try {
      await additionalCollection.doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data deleted successfully!"),
          backgroundColor: Colors.redAccent,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Additional Details History"),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: additionalCollection.orderBy('created_at', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(data['detailed_reason'] ?? 'No Reason'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Supervisor: ${data['supervisor_name'] ?? '-'}"),
                      Text("Location: ${data['location'] ?? '-'}"),
                      Text("Start Time: ${data['start_time'] ?? '-'}"),
                      Text("End Time: ${data['end_time'] ?? '-'}"),
                      Text("Attachment: ${data['attachment'] ?? '-'}"),
                      Text("Notes: ${data['additional_notes'] ?? '-'}"),
                      Text(
                        "Created At: ${data['created_at'] != null ? (data['created_at'] as Timestamp).toDate().toString() : '-'}",
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      deleteData(doc.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
