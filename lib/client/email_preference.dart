import 'package:booksharing_service_app/constants.dart';
import 'package:flutter/material.dart';

class EmailPreferencesPage extends StatefulWidget {
  const EmailPreferencesPage({Key? key}) : super(key: key);

  @override
  _EmailPreferencesPageState createState() => _EmailPreferencesPageState();
}

class _EmailPreferencesPageState extends State<EmailPreferencesPage> {
  bool _newBookArrivals = true;
  bool _bookRecommendations = false;
  bool _upcomingEvents = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Email Preferences',
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose which types of emails you would like to receive:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              activeColor: textColor,
              title: const Text('New Book Arrivals'),
              value: _newBookArrivals,
              onChanged: (value) {
                setState(() {
                  _newBookArrivals = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              activeColor: textColor,
              title: const Text('Book Recommendations'),
              value: _bookRecommendations,
              onChanged: (value) {
                setState(() {
                  _bookRecommendations = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              activeColor: textColor,
              title: const Text('Upcoming Events'),
              value: _upcomingEvents,
              onChanged: (value) {
                setState(() {
                  _upcomingEvents = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(textColor),
              ),
              onPressed: () {
                // Save email preferences to database
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save Preferences',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
