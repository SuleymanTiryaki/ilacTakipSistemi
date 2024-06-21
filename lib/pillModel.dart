import 'package:flutter/material.dart';

class PillModel{
  final String? pillName;
  final String? pariodOfDay;
  final String? pillType;
  final String? howManyHours;
  final TimeOfDay? startTime;
  PillModel({
    this.pillName,
    this.pariodOfDay,
    this.pillType,
    this.startTime,
    this.howManyHours
  });

}