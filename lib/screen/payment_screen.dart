import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
//import 'package:flutter_credit_card/flutter_credit_card.dart';

//import 'package:flutter_credit_card/flutter_credit_card.dart';
class PaymentScreen extends StatefulWidget {
  final VoidCallback onPaymentSuccess;
  PaymentScreen({required this.onPaymentSuccess});
  _paymentPageState createState() => _paymentPageState();
}

class _paymentPageState extends State<PaymentScreen> {
  String CardNumber = '';
  String expirydate = '';
  String cardHolder = '';
  String cvv = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
                cardNumber: CardNumber,
                expiryDate: expirydate,
                cardHolderName: cardHolder,
                cvvCode: cvv,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (CreditCardBrand) {}),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      cardNumber: CardNumber,
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cvvCode: cvv,
                      expiryDate: expirydate,
                      cardHolderName: cardHolder,
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.onPaymentSuccess();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('payment secsseful'),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          print('invalid');
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: Text(
                          'validate',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditcardmodel) {
    setState(() {
      CardNumber = creditcardmodel.cardNumber;
      expirydate = creditcardmodel.expiryDate;
      cardHolder = creditcardmodel.cardHolderName;
      cvv = creditcardmodel.cvvCode;
      isCvvFocused = creditcardmodel.isCvvFocused;
    });
  }
}
