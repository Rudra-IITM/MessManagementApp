import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Mess_menu.dart';
import 'thankyou.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tiny_alert/tiny_alert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class FeedbackForm extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  var _token;
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    String? token = await storage.read(key: 'token');
    setState(() {
      _token = token;
    });
    print(_token);
  }

  String? _feedbackType = null;

  String _description = '';

  @override
  int _rating = 0;
  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  Future<void> sendFeedback() async {
    // final url = Uri.parse('http://192.168.11.166:8080/api/v1/users/login');
    final url = Uri.parse('http://192.168.121.166:3000/api/test');
    final body = {
      'feedbackType': _feedbackType,
      '_description': _description,
      'rating': _rating,
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Authorization': _token},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        TinyAlert.success(
          context,
          title: "Success!",
          message: "Feedback Submitted successfully!",
        );
        print('Feedback submitted successfully');
      } else {
        TinyAlert.error(
          context,
          title: "Error!",
          message: "Unable to submit feedback, try again",
        );
        print('Failed to submit preferences. Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/background.png',
          ), // Adjust the path to your background image
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  'Feedback Type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: DropdownButton<String>(
                  value: _feedbackType,
                  onChanged: (value) {
                    setState(() {
                      _feedbackType = value as String;
                    });
                  },
                  items: <String>['Food Hygiene', 'Food Quality', 'Food Taste']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: const Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 300,
                child: Center(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter description',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                    maxLines: null, // Allow multiple lines for description
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: const Text(
                  'Rating:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () => _setRating(i),
                      child: _buildSmileyIcon(i),
                    ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'You rated: $_rating stars',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // Here you can handle the submission of the feedback form
                    sendFeedback();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const thankyou();
                    }));
                  },
                  child: const Text('Submit',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ),
            ],
          ),
        )),
      ),
    ));
  }

  Widget _buildSmileyIcon(int index) {
    IconData iconData;
    switch (index) {
      case 1:
        iconData = Icons.sentiment_very_dissatisfied;
        break;
      case 2:
        iconData = Icons.sentiment_dissatisfied;
        break;
      case 3:
        iconData = Icons.sentiment_neutral;
        break;
      case 4:
        iconData = Icons.sentiment_satisfied;
        break;
      case 5:
        iconData = Icons.sentiment_very_satisfied;
        break;
      default:
        iconData = Icons.sentiment_neutral;
    }

    return Icon(
      iconData,
      size: 40.0,
      color: index <= _rating ? Colors.amber : Colors.grey,
    );
  }
}
