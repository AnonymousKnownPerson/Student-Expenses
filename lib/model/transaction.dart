import 'package:flutter/foundation.dart';

final String tableTransactions = 'transactions';

class TransactionFields {
  static final List<String> values = [id, title, amount, date];
  static const String id = '_id';
  static const String title = 'title';
  static const String amount = 'amount';
  static const String date = 'date';
}

class Transaction {
  int? id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, Object?> toJson() => {
        TransactionFields.id: id,
        TransactionFields.title: title,
        TransactionFields.amount: amount,
        TransactionFields.date: date.toIso8601String(),
      };

  Transaction copy({
    int? id,
    String? title,
    double? amount,
    DateTime? date,
  }) =>
      Transaction(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        date: date ?? this.date,
      );

  static Transaction fromJson(Map<String, Object?> json) => Transaction(
        id: json[TransactionFields.id] as int?,
        title: json[TransactionFields.title] as String,
        amount: json[TransactionFields.amount] as double,
        date: DateTime.parse(json[TransactionFields.date] as String),
      );
}
