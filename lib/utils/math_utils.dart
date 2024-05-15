import 'package:flutter/material.dart';

double getSizeWidth(BuildContext context, double percentage) {
  return (percentage * ((MediaQuery.of(context).size.width))) / 100;
}

double getSizeHeight(BuildContext context, double percentage) {
  return (percentage * ((MediaQuery.of(context).size.height))) / 100;
}

double getFontSize(BuildContext context, double percentage) {
  return (percentage * ((MediaQuery.of(context).size.width) / 3)) / 100;
}

String getRoundOff(String value, {int fractionCount = 2}) {
  try {
    var number = double.tryParse(value);
    return (number?.toStringAsFixed(fractionCount)) ??
        0.toStringAsFixed(fractionCount);
  } catch (e) {
    return 0.toStringAsFixed(fractionCount);
  }
}
