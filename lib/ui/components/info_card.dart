import 'package:flutter/material.dart';

import '/theme.dart';


class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).styles;

    return Container(
      decoration: BoxDecoration(
        color: styles.colors.accent,
        borderRadius: .circular(16),
      ),
      padding: .all(16),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text(title, style: styles.font.header),
          SizedBox(height: 8),
          Text(value, style: styles.font.basic),
        ],
      ),
    );
  }
}
