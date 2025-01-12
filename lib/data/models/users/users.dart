import 'package:equatable/equatable.dart';

// Models.
import '/data/models/users/user.dart';

class Users extends Equatable {
  final List<User> items;

  const Users({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```Users``` object.
  factory Users.initial() {
    return const Users(
      items: [],
    );
  }

  Users copyWith({
    List<User>? items,
  }) {
    return Users(
      items: items ?? this.items,
    );
  }
}
