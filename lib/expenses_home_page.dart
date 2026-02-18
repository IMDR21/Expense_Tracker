import 'package:flutter/material.dart';
import 'add_expense_page.dart';

class ExpensesHomePage extends StatefulWidget {
  const ExpensesHomePage({super.key});

  @override
  State<ExpensesHomePage> createState() => _ExpensesHomePageState();
}

class _ExpensesHomePageState extends State<ExpensesHomePage> {
  final List<String> _expenses = [];

  Future<void> _navigateToAddExpense() async {
    final title = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExpensePage()),
    );

    if (!mounted) return;

    if (title != null) {
      setState(() {
        _expenses.add(title);
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Added: $title")));
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
          ? const Center(child: Text("No expenses yet"))
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(_expenses[index]));
              },
            ),
    );
  }
}
