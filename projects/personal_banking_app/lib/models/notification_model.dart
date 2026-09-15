import 'package:flutter/material.dart';

class BankNotification {
  final String id;
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;
  bool isRead;

  BankNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
    this.isRead = false,
  });
}
