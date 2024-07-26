import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyConverter extends StatefulWidget {
   CurrencyConverter({Key? key}) : super(key: key);

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String fromCurrency = "USD";
  String toCurrency = "PKR";
  double rate = 0.0;
  double total = 0.0;
  TextEditingController amountController = TextEditingController();
  List<String> currencies = [];
  int userId = 1; // Replace with actual user ID logic

  @override
  void initState() {
    super.initState();
    _getCurrencies();
  }

  Future<void> _getCurrencies() async {
    try {
      var response =
      await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          currencies = (data['rates'] as Map<String, dynamic>).keys.toList();
          rate = data['rates'][toCurrency];
        });
      } else {
        throw Exception('Failed to load currencies');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getRate() async {
    try {
      var response =
      await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          rate = data['rates'][toCurrency];
        });
      } else {
        throw Exception('Failed to load rate');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _swapCurrencies() {
    setState(() {
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
      _getRate();
    });
  }

  Future<void> addCurrencyToHistory(
      String fromCurrency, String toCurrency, double rate, double amount, double convertedAmount) async {
    try {
      var uri = "http://localhost/practice_api/insert_currency.php"; // Adjust URL as needed

      var response = await http.post(Uri.parse(uri), body: {
        'from_currency': fromCurrency,
        'to_currency': toCurrency,
        'rate': rate.toString(),
        'amount': amount.toString(),
        'converted_amount': convertedAmount.toString(),
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("Response status: ${data['status']}");
        print("Response message: ${data['message']}");
      } else {
        print("Failed to add currency. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  void _saveConversion() {
    double amount = double.tryParse(amountController.text) ?? 0.0;
    double convertedAmount = amount * rate;
    addCurrencyToHistory(fromCurrency, toCurrency, rate, amount, convertedAmount);
    // Optionally, you can reset the amountController or update any other UI state here
    // amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text("Currency Converter"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Image(
                height: 300,
                width: 300,
                image: AssetImage("img/asset/cc1.png"),
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                labelText: "Amount",
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    double amount = double.parse(value);
                    total = amount * rate;
                  });
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: DropdownButton<String>(
                      value: fromCurrency,
                      isExpanded: true,
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                      items: currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          fromCurrency = newValue!;
                          _getRate();
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: _swapCurrencies,
                    icon: const Icon(
                      Icons.swap_horiz,
                      size: 40,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: DropdownButton<String>(
                      value: toCurrency,
                      isExpanded: true,
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                      items: currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          toCurrency = newValue!;
                          _getRate();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Rate $rate",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              total.toStringAsFixed(3),
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 40,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent
              ),
              onPressed: _saveConversion,
              child: const Text('Save Conversion',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

