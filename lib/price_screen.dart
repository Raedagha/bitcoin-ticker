import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'widget/coins_widget.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  int coinBTC = 0;
  int coinETH = 0;
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getCoins();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getCoins();
        });
      },
      children: pickerItems,
    );
  }

  Future getCoins() async {
    const String apikey = 'C1ADA194-81C0-4FE7-8D04-4B44B261E257';
    const String url = 'https://rest.coinapi.io/v1/exchangerate';

    coinsData btc = coinsData('$url/BTC/$selectedCurrency?apikey=$apikey');
    coinsData eth = coinsData('$url/ETH/$selectedCurrency?apikey=$apikey');
    var coinBtc = await btc.getData();
    var coinEth = await eth.getData();

    // print(coins['rate']);
    coinBTC = coinBtc['rate'].toInt();
    coinETH = coinEth['rate'].toInt();
  }

  @override
  void initState() {
    super.initState();
    getCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CoinsWidget(
                coinData: coinBTC,
                selectedCurrency: selectedCurrency,
                coins: 'BTC',
              ),
              CoinsWidget(
                coinData: coinETH,
                selectedCurrency: selectedCurrency,
                coins: 'ETH',
              ),
            ],
          ),
          Container(
              height: 120.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropdown()),
        ],
      ),
    );
  }
}
