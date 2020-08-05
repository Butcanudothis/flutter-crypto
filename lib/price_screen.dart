
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    getCoinData();
  }

  void getCoinData() async {
    CoinData coinData = CoinData();
    var coinJson = await coinData.getCoinInfo('BTC', SelectedCurrency);
    updateUI(coinJson);
  }

  String exRate;
  void updateUI(dynamic coin) {
    setState(() {
      exRate = coin['rate'].toStringAsFixed(2);
      print(exRate);
    });
  }
  //  DropdownButton getDropdownButton() {
//    List<DropdownMenuItem<String>> dropdownItems = [];
//    for (String currency in currenciesList) {
//      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
//      dropdownItems.add(newItem);
//    }
//
//    return DropdownButton(
//      items: dropdownItems,
//      onChanged: (value) {
//        setState(
//          () {
//            SelectedCurrency = value;
//          },
//        );
//      },
//      value: SelectedCurrency,
//    );
//  }

  CupertinoPicker getIOSPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      var newItem = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      pickerList.add(newItem);
    }
    return CupertinoPicker(
      offAxisFraction: 0.0,
      diameterRatio: 0.77,
      itemExtent: 35.0,
      onSelectedItemChanged: (value) {
        setState(() {
          print(currenciesList[value]);
          SelectedCurrency = currenciesList[value];
          getCoinData();
        });
      },
      children: pickerList,
    );
  }

  String SelectedCurrency = 'USD';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $exRate $SelectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getIOSPicker()
              // (Platform.isIOS) ? getIOSPicker() : getDropdownButton(),
              ),
        ],
      ),
    );
  }
}
