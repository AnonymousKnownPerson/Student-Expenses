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
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.075,
          ),
          FittedBox(
            child: Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$${barAmount.toStringAsFixed(0)}'))),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.025,
          ),
          Container(
            height: constraints.maxHeight * 0.50,
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
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.025,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                label,
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.075,
          ),
        ],
      );
    });
  }
}
