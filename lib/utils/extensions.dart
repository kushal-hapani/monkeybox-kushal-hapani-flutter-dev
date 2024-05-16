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

extension AddSpacing on List<Widget> {
  List<Widget> addHSpacing(double spacing) {
    final latestChildren = <Widget>[];

    for (int i = 0; i < length; i++) {
      latestChildren.add(this[i]);
      if (i == length - 1) continue;
      latestChildren.add(SizedBox(
        width: spacing,
      ));
    }

    return latestChildren;
  }

  List<Widget> addVSpacing(double spacing) {
    final latestChildren = <Widget>[];

    for (int i = 0; i < length; i++) {
      latestChildren.add(this[i]);
      if (i == length - 1) continue;
      latestChildren.add(SizedBox(
        height: spacing,
      ));
    }

    return latestChildren;
  }
}

extension StringCapitalize on String {
  String capitalize() {
    return isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  }
}
