import 'package:currency/history.dart';
import 'package:currency/reviews.dart';
import 'package:flutter/material.dart';
import 'package:currency/CurrencyConverter.dart';
import 'package:currency/FAQpage.dart';
import 'package:currency/feedback.dart';
import 'package:currency/login.dart';

class DrawerNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey[900]!, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                accountName: Text(
                  'WelCome to CurrenSee',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                ),
                accountEmail: Text(
                  'Where Every Exchange Feels Like A Win-Win.',
                  style: TextStyle(color: Colors.white70),
                ),
                // currentAccountPicture: CircleAvatar(
                //   backgroundImage: AssetImage('assets/profile_picture.png'),
                // ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    _createDrawerItem(
                      icon: Icons.monetization_on,
                      text: 'Currency Converter',
                      onTap: () => _navigateTo(context, CurrencyConverter()),
                    ),
                    _createDrawerItem(
                      icon: Icons.history,
                      text: 'History',
                      onTap: () => _navigateTo(context, HistoryPage()),
                    ),
                    _createDrawerItem(
                      icon: Icons.question_answer,
                      text: 'FAQs',
                      onTap: () => _navigateTo(context, FAQsPage()),
                    ),
                    _createDrawerItem(
                      icon: Icons.feedback,
                      text: 'Feedback',
                      onTap: () => _navigateTo(context, FeedbackPage()),
                    ),_createDrawerItem(
                      icon: Icons.reviews,
                      text: 'See Reviews',
                      onTap: () => _navigateTo(context, ReviewsPage()),
                    ),
                    _createDrawerItem(
                      icon: Icons.exit_to_app,
                      text: 'Logout',
                      onTap: () => _navigateTo(context, Login()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createDrawerItem({required IconData icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      tileColor: Colors.blueGrey[800]?.withOpacity(0.7),
      hoverColor: Colors.blueGrey[700],
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
