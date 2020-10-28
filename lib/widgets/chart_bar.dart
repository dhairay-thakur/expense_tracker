import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double expenditure;
  final double percentage;
  ChartBar(this.day, this.expenditure, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: expenditure < 1000
                ? Text("₹${expenditure.toStringAsFixed(0)}")
                : Text("₹${(expenditure / 1000.00).toStringAsFixed(2)} K"),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 80,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: 1 - percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: percentage == 0
                        ? BorderRadius.circular(10)
                        : BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(day),
      ],
    );
  }
}
