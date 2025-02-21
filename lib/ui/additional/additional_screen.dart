import 'package:absensiapp/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class AdditionalDetailsScreen extends StatefulWidget {
  const AdditionalDetailsScreen({super.key, required String documentId, required Map<String, dynamic> data});

  @override
  _AdditionalDetailsScreenState createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  // Collection reference untuk additional details
  final CollectionReference additionalCollection =
      FirebaseFirestore.instance.collection('additional_details');

  // Controllers untuk form input
  final TextEditingController detailedReasonController = TextEditingController();
  final TextEditingController supervisorNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController attachmentController = TextEditingController();
  final TextEditingController additionalNotesController = TextEditingController();

  // Menampilkan loader dialog
  void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: const Text("Please Wait..."),
          ),
        ],
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => alert,
    );
  }

  // Fungsi untuk submit data ke Firebase
  Future<void> submitAdditionalDetails() async {
    if (detailedReasonController.text.isEmpty ||
        supervisorNameController.text.isEmpty ||
        locationController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty ||
        attachmentController.text.isEmpty ||
        additionalNotesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    showLoaderDialog(context);

    try {
      await additionalCollection.add({
        'detailed_reason': detailedReasonController.text,
        'supervisor_name': supervisorNameController.text,
        'location': locationController.text,
        'start_time': startTimeController.text,
        'end_time': endTimeController.text,
        'attachment': attachmentController.text,
        'additional_notes': additionalNotesController.text,
        'created_at': FieldValue.serverTimestamp(),
      });
      Navigator.of(context).pop(); // Menutup loader

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data submitted successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      // Bersihkan inputan
      detailedReasonController.clear();
      supervisorNameController.clear();
      locationController.clear();
      startTimeController.clear();
      endTimeController.clear();
      attachmentController.clear();
      additionalNotesController.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      Navigator.of(context).pop(); // Menutup loader jika terjadi error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    
  }

  

  // Fungsi untuk memilih waktu menggunakan time picker
  Future<void> selectTime(TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
      });
    }
  }

  // Fungsi untuk memilih file attachment
  Future<void> pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        // Misalnya, hanya menampilkan nama file
        attachmentController.text = result.files.single.name;
      });
    }
  }

  @override
  void dispose() {
    detailedReasonController.dispose();
    supervisorNameController.dispose();
    locationController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    attachmentController.dispose();
    additionalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Additional Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar keempat dari asset lokal
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  'assets/images/ic_4.webp',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              // Form input
              TextField(
                controller: detailedReasonController,
                decoration: const InputDecoration(
                  labelText: "Detailed Reason",
                  hintText: "Enter detailed reason",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: supervisorNameController,
                decoration: const InputDecoration(
                  labelText: "Supervisor Name",
                  hintText: "Enter your supervisor's name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: "Location",
                  hintText: "Enter location (e.g., WFH, Branch Office)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Start Time dengan ikon jam
              TextField(
                controller: startTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Start Time",
                  hintText: "Select start time",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () => selectTime(startTimeController),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // End Time dengan ikon jam
              TextField(
                controller: endTimeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "End Time",
                  hintText: "Select end time",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () => selectTime(endTimeController),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Attachment dengan ikon lampiran untuk memilih file
              TextField(
                controller: attachmentController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Attachment",
                  hintText: "Select attachment file",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: pickAttachment,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: additionalNotesController,
                decoration: const InputDecoration(
                  labelText: "Additional Notes",
                  hintText: "Enter any additional notes",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitAdditionalDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Submit Additional Details",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
