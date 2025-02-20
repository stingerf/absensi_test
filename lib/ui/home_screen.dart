import 'package:absensiapp/ui/absent/absent_screen.dart';
import 'package:absensiapp/ui/additional/additional_screen.dart';
import 'package:absensiapp/ui/attend/attend_screen.dart';
import 'package:absensiapp/ui/attendence_history/attendence_history_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          SizedBox(
            height: 50,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueAccent,
                centerTitle: true,
                title: const Text(
                  "Attendance - Flutter App Admin",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            child: Column(
              children: [
                Expanded(
                  // Attendance Record
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AbsentScreen()));
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/ic_absen.png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          "Attendance Record",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // Permission
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AttendScreen()));
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/ic_leave (1).png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          "Permission",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // Attendance History
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AttendanceHistoryScreen()));
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image:
                              AssetImage('assets/images/ic_history (1).png'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          "Attendance History",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // Additional Details (gambar keempat + form)
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AdditionalDetailsScreen()));
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/ic_4.webp'),
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          "Additional Details",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Footer
          SizedBox(
            height: 50,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueAccent,
                centerTitle: true,
                title: const Text(
                  "IDN Boarding School Solo",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
