import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  List feedbackData = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getFeedback();
  }

  Future<void> getFeedback() async {
    String uri = "http://localhost/practice_api/review.php"; // Update the URL to your actual API endpoint

    try {
      var response = await http.get(Uri.parse(uri));
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("Decoded data: $data");

        if (data is List) {
          setState(() {
            feedbackData = data;
            isLoading = false;
            isError = false;
          });
        } else {
          print("Unexpected response format: ${response.body}");
          setState(() {
            isError = true;
            isLoading = false;
          });
        }
      } else {
        print("Server error: ${response.statusCode}");
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Reviews"),
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: Colors.blueGrey[900], // Set the background color of the scaffold
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isError
          ? Center(child: Text("Error fetching data", style: TextStyle(color: Colors.white))) // Error text color
          : ListView.builder(
        itemCount: feedbackData.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueGrey[800], // Set the card color
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                feedbackData[index]["name"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white, // Text color for better contrast
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feedbackData[index]["email"],
                    style: TextStyle(
                      color: Colors.white70, // Subtitle text color
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    feedbackData[index]["review"],
                    style: TextStyle(
                      color: Colors.white, // Review text color
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
