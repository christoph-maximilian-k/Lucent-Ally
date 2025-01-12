import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ColorItem extends Equatable {
  final String id;
  final String label;
  final Color color;

  const ColorItem({
    required this.id,
    required this.label,
    required this.color,
  });

  @override
  List<Object> get props => [id, label, color];

  ColorItem copyWith({
    String? id,
    String? label,
    Color? color,
  }) {
    return ColorItem(
      id: id ?? this.id,
      label: label ?? this.label,
      color: color ?? this.color,
    );
  }
}
