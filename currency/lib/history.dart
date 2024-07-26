import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List historyData = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  Future<void> getHistory() async {
    String uri = "http://localhost/practice_api/get_history.php";

    try {
      var response = await http.get(Uri.parse(uri));
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("Decoded data: $data");

        if (data is List) {
          setState(() {
            historyData = data;
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
        title: Text("History"),
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: Colors.blueGrey[900],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isError
          ? Center(child: Text("Error fetching data", style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueGrey[800],
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                "${historyData[index]['from_currency']} to ${historyData[index]['to_currency']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rate: ${historyData[index]['rate']}",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Amount: ${historyData[index]['amount']}",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Converted: ${historyData[index]['converted_amount']}",
                    style: TextStyle(
                      color: Colors.white70,
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
