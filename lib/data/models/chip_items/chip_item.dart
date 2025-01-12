import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChipItem extends Equatable {
  final String id;
  final String label;
  final IconData? iconData;
  final Function()? onPressed;
  final bool isSelected;

  /// [ChipItem] construtor.
  const ChipItem({
    required this.id,
    required this.label,
    required this.iconData,
    required this.onPressed,
    required this.isSelected,
  });

  /// Initialize a new [ChipItem] object.
  /// ```dart
  /// return const ChipItem(
  ///   id: const Uuid().v4(),
  ///   label: '',
  ///   iconData: null,
  ///   onPressed: null,
  ///   isSelected: false,
  /// );
  /// ```
  factory ChipItem.initial() {
    return ChipItem(
      id: const Uuid().v4(),
      label: '',
      iconData: null,
      onPressed: null,
      isSelected: false,
    );
  }

  @override
  List<Object?> get props => [id, label, iconData, onPressed, isSelected];

  ChipItem copyWith({
    String? id,
    String? label,
    IconData? iconData,
    Function()? onPressed,
    bool? isSelected,
  }) {
    return ChipItem(
      id: id ?? this.id,
      label: label ?? this.label,
      iconData: iconData ?? this.iconData,
      onPressed: onPressed ?? this.onPressed,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
