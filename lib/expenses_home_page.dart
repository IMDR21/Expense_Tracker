import 'package:flutter/material.dart';
import 'expense.dart';
import 'expense_item.dart';
import 'add_expense_page.dart';

class ExpensesHomePage extends StatefulWidget {
  const ExpensesHomePage({super.key});

  @override
  State<ExpensesHomePage> createState() => _ExpensesHomePageState();
}

class _ExpensesHomePageState extends State<ExpensesHomePage> {
  final List<Expense> _expenses = [
    
  ];

  Future<void> _navigateToAddExpense() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExpensePage()),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        _expenses.add(
          Expense(
            title: result['title'],
            amount: result['amount'],
            date: DateTime.now(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddExpense,
          ),
        ],
      ),
      body: _expenses.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No expenses yet",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Tap + to add one",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.separated(
              itemCount: _expenses.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 4),
              itemBuilder: (context, index) {
                return ExpenseItem(expense: _expenses[index]);
              },
            ),
    );
  }
}