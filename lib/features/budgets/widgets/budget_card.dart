import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/budget_provider.dart';
import '../../../core/constants/ride_types.dart';
import '../../../data/models/budget_model.dart';

class BudgetCard extends StatelessWidget {
  final RideType rideType;

  const BudgetCard({super.key, required this.rideType});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BudgetProvider>();

    BudgetModel? budget = provider.budgets
        .where((b) => b.rideType == rideType)
        .cast<BudgetModel?>()
        .firstWhere((b) => b != null, orElse: () => null);

    final spent = budget?.spentAmount ?? 0;
    final limit = budget?.monthlyLimit ?? 0;

   final double percent = limit == 0 ? 0.0 : (spent / limit).clamp(0.0, 1.0).toDouble();


    final Color barColor;
    if (limit == 0) {
      barColor = Colors.grey;
    } else if (spent > limit) {
      barColor = Colors.red;
    } else if (percent > 0.75) {
      barColor = Colors.orange;
    } else {
      barColor = Colors.green;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: spent > limit ? Colors.red : Colors.white12,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                rideType.label,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (spent > limit)
                const Text(
                  'Over limit',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),

          const SizedBox(height: 12),

          /// Progress bar
          LinearProgressIndicator(
            value: percent,
            color: barColor,
            backgroundColor: Colors.white12,
            minHeight: 6,
          ),

          const SizedBox(height: 12),

          /// Amounts
          Text(
            '₹${spent.toStringAsFixed(0)} spent'
            '${limit > 0 ? ' / ₹${limit.toStringAsFixed(0)}' : ''}',
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 12),

          /// Set / Update limit
          _LimitInput(
            initialValue: limit > 0 ? limit.toStringAsFixed(0) : '',
            onSubmit: (value) {
              context.read<BudgetProvider>().setLimit(rideType, value);
            },
          ),
        ],
      ),
    );
  }
}

class _LimitInput extends StatefulWidget {
  final String initialValue;
  final ValueChanged<double> onSubmit;

  const _LimitInput({
    required this.initialValue,
    required this.onSubmit,
  });

  @override
  State<_LimitInput> createState() => _LimitInputState();
}

class _LimitInputState extends State<_LimitInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Set monthly limit',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.check, color: Colors.greenAccent),
          onPressed: () {
            final value = double.tryParse(_controller.text);
            if (value != null && value > 0) {
              widget.onSubmit(value);
            }
          },
        ),
      ),
    );
  }
}
