import 'package:flutter/material.dart';
import 'package:expenses_tracker/chart/chart_bar.dart';
import 'package:expenses_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});
  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(category: Category.food, allExpenses: expenses),
      ExpenseBucket.forCategory(
          category: Category.leisure, allExpenses: expenses),
      ExpenseBucket.forCategory(
          category: Category.travel, allExpenses: expenses),
      ExpenseBucket.forCategory(category: Category.work, allExpenses: expenses),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (var element in buckets) {
      if (element.totalExpenses > maxTotalExpense) {
        maxTotalExpense = element.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(builder: (ctx, constraint) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        width: double.infinity,
        height: constraint.maxHeight * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final ele in buckets)
                    ChartBar(
                        fill: ele.totalExpenses == 0
                            ? 0
                            : ele.totalExpenses / maxTotalExpense),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: buckets
                  .map((e) => Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          categoryIcons[e.category],
                          color: isDarkMode
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7),
                        ),
                      )))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
