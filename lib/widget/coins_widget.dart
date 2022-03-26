import 'package:flutter/material.dart';


class CoinsWidget extends StatelessWidget {
  const CoinsWidget({
    Key? key,
    required this.coinData,
    required this.selectedCurrency,
    required this.coins,
  }) : super(key: key);

  final int coinData;
  final String selectedCurrency;
  final String coins;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coins = $coinData $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
