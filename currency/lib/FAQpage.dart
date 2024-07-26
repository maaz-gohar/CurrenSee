import 'package:flutter/material.dart';

class FAQsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'FAQs',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blueGrey[900], // Set background color
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FAQItem(
            question: 'What currencies are supported?',
            answer:
            'We support a wide range of currencies, including USD, EUR, GBP, JPY, and many more.',
          ),
          FAQItem(
            question: 'How often are exchange rates updated?',
            answer:
            'Exchange rates are updated every hour to provide you with accurate information.',
          ),
          FAQItem(
            question: 'Is there a fee for using the currency converter?',
            answer:
            'Our currency converter app is completely free to use. No hidden charges.',
          ),
          FAQItem(
            question: 'Can I use the app offline?',
            answer:
            'You need an internet connection to fetch the latest exchange rates. Once rates are fetched, you can use the app offline for conversions.',
          ),
          FAQItem(
            question: 'How accurate are the exchange rates?',
            answer:
            'Our exchange rates are sourced from reputable providers and are updated frequently to ensure accuracy.',
          ),
          FAQItem(
            question: 'Can I save my favorite conversions?',
            answer:
            'Yes, you can save your favorite conversions for quick access in the future.',
          ),
          FAQItem(
            question: 'Is my data secure?',
            answer:
            'We prioritize the security and privacy of your data. Your information is encrypted and protected.',
          ),
          FAQItem(
            question: 'How do I report an issue or give feedback?',
            answer:
            'You can send us your feedback or report any issues through the app\'s settings or contact us directly via email at support@example.com.',
          ),
          FAQItem(
            question: 'Do you have a privacy policy?',
            answer:
            'Yes, we have a detailed privacy policy that outlines how we collect, use, and protect your data. You can find it in the app settings or on our website.',
          ),
          FAQItem(
            question: 'Can I change the app\'s settings or preferences?',
            answer:
            'Yes, you can customize settings such as default currencies, language preferences, and notification settings in the app\'s settings menu.',
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white, // Set text color to white
        ),
      ),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          child: Text(
            answer,
            style: TextStyle(
              color: Colors.white, // Set text color to white
            ),
          ),
        ),
      ],
    );
  }
}
