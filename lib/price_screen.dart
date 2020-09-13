import 'package:bitcoin_ticker/constants.dart';
import 'package:bitcoin_ticker/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'coin_data.dart';
import 'coin_data.dart';
import 'coin_data.dart';
import 'coin_data.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = "AUD";
  String bitCoinRate = 'fetching';
  String ltcCoinRate = 'fetching';
  String ethCoinRate = 'fetching';


  @override
  initState(){
    super.initState();
    setRateValues();
  }

// this function is used to get the currency rate when app is start
  setRateValues() async {
    String  tempBTCRate = await getRate(currentCurrency, "BTC");
    String tempLTCRate = await getRate(currentCurrency, "LTC");
    String tempETHRate = await getRate(currentCurrency, "ETH");
    setState(() {
      bitCoinRate = tempBTCRate;
      ltcCoinRate = tempLTCRate;
      ethCoinRate = tempETHRate;
    });
  }

  // it will return currencies as a list of Text widget
  List<Text> getCurrencies() {

    List<Text> currenciesText = [];
    for (String currency in currenciesList) {
      currenciesText.add(Text(currency,style: TextStyle(color:pickerTextColor),));
    }

    return currenciesText;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Coin Now'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: cardColor,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Column(
                  children: <Widget>[
                    ShowText(cryptoCurName: "BTC",rate: bitCoinRate, currencyName: currentCurrency,),
                    ShowText(cryptoCurName: "ETH",rate: ethCoinRate, currencyName: currentCurrency,),
                    ShowText(cryptoCurName: "LTC",rate: ltcCoinRate, currencyName: currentCurrency,),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: pickerColor,
            child: CupertinoPicker(
              children: getCurrencies(),
              itemExtent: 32,
              onSelectedItemChanged: (value) async {
                String tempBitRate = await getRate(currenciesList[value], "BTC");
                String tempLTCRate = await getRate(currenciesList[value], "LTC");
                String tempETHRate = await getRate(currenciesList[value], "ETH");
                setState(()  {
                  bitCoinRate =  tempBitRate;
                  ltcCoinRate = tempLTCRate;
                  ethCoinRate = tempETHRate;
                  currentCurrency = currenciesList[value];
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShowText extends StatelessWidget {

  ShowText({this.cryptoCurName, this.rate, this.currencyName});

  final String cryptoCurName;
  final String rate;
  final String currencyName;

  @override
  Widget build(BuildContext context) {
    return Text(
      '1 $cryptoCurName = $rate $currencyName',
      textAlign: TextAlign.center,
      style: textStyleInCard,

    );
  }
}
