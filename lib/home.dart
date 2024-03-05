import 'package:flutter/material.dart';
import 'package:currency_converter_1/api/api.dart';
import 'package:currency_converter_1/widgets/appbutton.dart';
import 'package:currency_converter_1/widgets/appdropdown.dart';
import 'package:currency_converter_1/widgets/apptextfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  List<dynamic>? dataList;

  List<String> items = [];
  String firstItem = 'USD';
  String nextItem = 'AZN';
  double _result = 0.0;
  String convertedCurrency = '';

  Future<void> fetchExchangeRates() async {
    try {
      final rates = await ExchangeApi.fetchExchangeRates();
      items = rates.keys.toList();
      calculateCurrency(rates);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void calculateCurrency(Map<String, dynamic> exchangeRates) {
    double inputValue = double.tryParse(textController.text) ?? 0.0;
    double rate = exchangeRates[nextItem]! / exchangeRates[firstItem]!;
    _result = inputValue * rate;
    convertedCurrency = nextItem;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212936),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 200,
                    child: Text(
                      "Currency Converter",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 3,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  AppTextField(
                    controller: textController,
                    text: 'Input value to convert',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AppDropdown(
                    value: firstItem,
                    items: items,
                    onChanged: (newValue) {
                      setState(() {
                        firstItem = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        String temp = firstItem;
                        firstItem = nextItem;
                        nextItem = temp;
                      });
                    },
                    tooltip: 'Swap',
                    backgroundColor: const Color(0xFF2849E5),
                    child: const Icon(
                      Icons.swap_vert_outlined,
                      color: Colors.white,
                    ),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  AppDropdown(
                    value: nextItem,
                    items: items,
                    onChanged: (newValue) {
                      setState(() {
                        nextItem = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  AppButton(
                    text: 'Change',
                    onPressed: () {
                      setState(() {
                        fetchExchangeRates();
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: Text(
                      "Result: ${_result.toStringAsFixed(1)} $convertedCurrency",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
