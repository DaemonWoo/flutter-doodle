import 'package:flutter/material.dart';

import '/theme.dart';
import '/ui/screens/main.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  
    home: MainScreen(),
    theme: darkTheme,
  ));
}
