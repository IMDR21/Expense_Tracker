import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expense_item.dart';
import 'add_expense_page.dart';

class ExpensesHomePage extends StatefulWidget {
  const ExpensesHomePage({super.key});

  @override
  State<ExpensesHomePage> createState() => _ExpensesHomePageState();
}

class _ExpensesHomePageState extends State<ExpensesHomePage> {
  final List<Expense> _expenses = [
    Expense(
      title: "Groceries",
      amount: 1200,
      date: DateTime.now(),
    ),
    Expense(
      title: "Coffee",
      amount: 150,
      date: DateTime.now(),
    ),
    Expense(
      title: "Transport",
      amount: 300,
      date: DateTime.now(),
    ),
  ];

  // ======================
  // ADD EXPENSE
  // ======================
  Future<void> _navigateToAddExpense() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddExpensePage(),
      ),
    );

    if (!mounted) return;

    if (result != null && result is Expense) {
      setState(() {
        _expenses.add(result);
      });
    }
  }

  // ======================
  // EDIT EXPENSE
  // ======================
  Future<void> _navigateToEditExpense(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddExpensePage(expense: _expenses[index]),
      ),
    );

    if (!mounted) return;

    if (result != null && result is Expense) {
      setState(() {
        _expenses[index] = result;
      });
    }
  }

  // ======================
  // UI
  // ======================
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
                  Icon(
                    Icons.receipt_long,
                    size: 64,
                    color: Colors.grey,
                  ),
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
              padding: const EdgeInsets.all(8),
              itemCount: _expenses.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 4),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _navigateToEditExpense(index),
                  child: ExpenseItem(
                    expense: _expenses[index],
                  ),
                );
              },
            ),
    );
  }
}