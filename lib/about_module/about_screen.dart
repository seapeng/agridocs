import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../app_module/main_app.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const MainApp(),
            ),
          );
          // Navigator.pop(context); // This navigates back to the previous screen
        },
      ),
      title: Text(
        "អំពីបណ្ណាល័យ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Moul',
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subtitle / Introduction
          Text(
            "The Agriculture Library is a digital knowledge hub providing farmers, researchers, and students with valuable resources on modern and traditional agricultural practices.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),

          // Mission Section
          Text(
            "🌾 Our Mission",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "To empower farmers and agricultural enthusiasts with reliable knowledge, innovative techniques, and research-based solutions for sustainable farming.",
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 20),

          // Mission Section
          Text(
            "🌍 Our Vision",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "To create a world where every farmer has access to the right knowledge, leading to improved food security, innovation, and sustainable farming practices.",
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
