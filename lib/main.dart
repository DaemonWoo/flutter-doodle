import 'package:flutter/material.dart';

import '/ui/screens/battery.dart';
import '/theme.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BatteryScreen(),
    theme: darkTheme,
  ),
);
