import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  String operator = '';
  double firstNum = 0;
  double secondNum = 0;

  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TextField to display the current input
            TextFormField(
              textDirection: TextDirection.rtl,
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              readOnly: true, // Prevent direct editing
            ),
            const SizedBox(
              height: 8,
            ),
            // Grid of buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  String buttonText = lstSymbols[index];

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        // Handle the button actions
                        if (buttonText == "C") {
                          // Clear the text field and reset all variables
                          _textController.clear();
                          firstNum = 0;
                          secondNum = 0;
                          operator = '';
                        } else if (buttonText == "<-") {
                          // Backspace, remove the last character
                          String currentText = _textController.text;
                          if (currentText.isNotEmpty) {
                            _textController.text = currentText.substring(
                                0, currentText.length - 1);
                          }
                        } else if (buttonText == "=") {
                          // Calculate the result
                          if (operator.isNotEmpty) {
                            secondNum =
                                double.tryParse(_textController.text) ?? 0;
                            double result = 0;

                            // Perform the calculation based on the operator
                            switch (operator) {
                              case "+":
                                result = firstNum + secondNum;
                                break;
                              case "-":
                                result = firstNum - secondNum;
                                break;
                              case "*":
                                result = firstNum * secondNum;
                                break;
                              case "/":
                                if (secondNum != 0) {
                                  result = firstNum / secondNum;
                                } else {
                                  result =
                                      double.nan; // Handle division by zero
                                }
                                break;
                              default:
                                result = 0;
                            }

                            // Show the result in the text field
                            _textController.text = result.toString();
                            // Reset the variables for a new calculation
                            firstNum = result;
                            operator = '';
                          }
                        } else if (buttonText == "+" ||
                            buttonText == "-" ||
                            buttonText == "*" ||
                            buttonText == "/") {
                          // Store the first number and operator, then clear the text field for the second number
                          firstNum = double.tryParse(_textController.text) ?? 0;
                          operator = buttonText;
                          _textController.clear();
                        } else {
                          // Append the number or symbol to the text field
                          _textController.text += buttonText;
                        }
                      });
                    },
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CalculatorView(),
  ));
}
