import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class LineDot extends Equatable {
  final String id;

  final double xAxisValue;
  final double yAxisValue;

  const LineDot({
    required this.id,
    required this.xAxisValue,
    required this.yAxisValue,
  });

  @override
  List<Object> get props => [
        id,
        xAxisValue,
        yAxisValue,
      ];

  /// Initialize a new ```LineDot``` object.
  factory LineDot.initial() {
    return LineDot(
      id: const Uuid().v4(),
      xAxisValue: 0.0,
      yAxisValue: 0.0,
    );
  }

  // #####################################
  // # Cloud
  // #####################################

  /// This method can be used to decode a ```LineDot``` from request JSON.
  static LineDot fromCloudObject(data) {
    return LineDot.initial().copyWith(
      xAxisValue: data['x_axis_value'],
      yAxisValue: data['y_axis_value'],
    );
  }

  LineDot copyWith({
    String? id,
    double? xAxisValue,
    double? yAxisValue,
  }) {
    return LineDot(
      id: id ?? this.id,
      xAxisValue: xAxisValue ?? this.xAxisValue,
      yAxisValue: yAxisValue ?? this.yAxisValue,
    );
  }
}
