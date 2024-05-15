import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';

extension Log on Object {
  void log() => devtools.log('$this');
}

extension DoubleExtension on double {
  /// Vertical Spaced SizedBox
  Widget toVSB(BuildContext context) {
    return SizedBox(
        height: (this * ((MediaQuery.of(context).size.height))) / 100);
  }

  /// Horizontal Spaced SizedBox
  Widget toHSB(BuildContext context) {
    return SizedBox(width: (this * (MediaQuery.of(context).size.width)) / 100);
  }
}
