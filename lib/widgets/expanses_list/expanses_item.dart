import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

class ExpansesItem extends StatelessWidget {
  const ExpansesItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(children: [
            Text('\$${expense.amount.toStringAsFixed(2)}'),
            const Spacer(),
            Row(
              children: [
                Icon(categoryIcons[expense.category]),
                const SizedBox(
                  width: 4,
                ),
                Text(expense.formattedDate())
              ],
            )
          ]),
        ],
      ),
    ));
  }
}
