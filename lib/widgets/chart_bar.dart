import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double barAmount;
  final double barAmountPercentage;

  ChartBar({
    required this.label,
    required this.barAmount,
    required this.barAmountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        children: [
          const SizedBox(
            height: 4,
          ),
          FittedBox(child: Text('\$${barAmount.toStringAsFixed(0)}')),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: barAmountPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            label,
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
