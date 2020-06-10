import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class FormatNumber {

  FlutterMoneyFormatter format(double amount){
    FlutterMoneyFormatter priceFormated = FlutterMoneyFormatter(
        amount: amount,
        settings: MoneyFormatterSettings(
        symbol: 'AKZ',
        thousandSeparator: '.',
        decimalSeparator: ',',
        fractionDigits: 2
     )
    );
    return priceFormated;
  }
}
