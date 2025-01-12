import 'package:equatable/equatable.dart';

// Models.
import 'creditor_debitor.dart';

class CreditorsDebitors extends Equatable {
  final List<CreditorDebitor> items;

  const CreditorsDebitors({
    required this.items,
  });

  /// Initialize a new ```CreditorsDebitors``` object.
  factory CreditorsDebitors.initial() {
    return const CreditorsDebitors(
      items: [],
    );
  }

  @override
  List<Object> get props => [items];

  /// This method can be used to access a ```CreditorDebitor``` object specified by its ```id```.
  /// * returns ```null``` if id was not found
  CreditorDebitor? getById({required String id}) {
    // Go through shareReferences.
    for (final CreditorDebitor item in items) {
      if (item.id == id) return item;
    }

    return null;
  }

  /// This method can be used to access a ```CreditorDebitor``` object specified by a ```creditorId```.
  /// * returns ```null``` if id was not found
  CreditorDebitor? getCreditor({required String creditorId}) {
    // Go through shareReferences.
    for (final CreditorDebitor item in items) {
      if (item.creditor.memberId == creditorId) return item;
    }

    return null;
  }

  /// This method can be used to access a ```CreditorDebitor``` object specified by a ```debitorId```.
  /// * returns ```null``` if id was not found
  CreditorDebitor? getDebitor({required String debitorId}) {
    // Go through shareReferences.
    for (final CreditorDebitor item in items) {
      if (item.debitor.memberId == debitorId) return item;
    }

    return null;
  }

  /// This method can be used to access a ```CreditorDebitor``` object specified by a ```creditorId``` and a ```debitorId```.
  /// * returns ```null``` if ids were not found
  CreditorDebitor? getCreditorDebitor({required String creditorId, required String debitorId}) {
    // Go through shareReferences.
    for (final CreditorDebitor item in items) {
      if (item.creditor.memberId == creditorId && item.debitor.memberId == debitorId) return item;
    }

    return null;
  }

  /// This method can be used to add a ```CreditorDebitor``` object to ```items```.
  CreditorsDebitors add({required CreditorDebitor creditorDebitor}) {
    return CreditorsDebitors(
      items: [...items, creditorDebitor],
    );
  }

  /// This method can be used to remove a ```CreditorDebitor``` from ```items```.
  CreditorsDebitors remove({required CreditorDebitor creditorDebitor}) {
    // Init helper list.
    List<CreditorDebitor> list = [];

    // Go through references and remove relevant data.
    for (final CreditorDebitor item in items) {
      // * exclude specified object.
      if (item.id == creditorDebitor.id) continue;

      list.add(item);
    }

    return CreditorsDebitors(
      items: list,
    );
  }

  /// This method can be used to update a ```CreditorDebitor``` in ```items```.
  CreditorsDebitors update({required CreditorDebitor creditorDebitor}) {
    // Init helper list.
    List<CreditorDebitor> list = [];

    // Go through references and add relevant data.
    for (final CreditorDebitor item in items) {
      // * insert specified object.
      if (item.id == creditorDebitor.id) {
        list.add(creditorDebitor);
        continue;
      }

      list.add(item);
    }

    return CreditorsDebitors(
      items: list,
    );
  }

  /// This method can be used to settle pairs.
  CreditorsDebitors settlePairs() {
    // Init helper.
    CreditorsDebitors helper = CreditorsDebitors.initial();
    List<String> tracker = [];

    for (final CreditorDebitor creditorDebitor in items) {
      // Check if current CreditorDebitor should be ignored.
      if (tracker.contains(creditorDebitor.id)) continue;

      // Get opposing pair.
      final CreditorDebitor? opposingPair = getCreditorDebitor(
        creditorId: creditorDebitor.debitor.memberId,
        debitorId: creditorDebitor.creditor.memberId,
      );

      // No opposing pair not found. Add current creditorDebitor to list.
      if (opposingPair == null) {
        helper = helper.add(creditorDebitor: creditorDebitor);
        continue;
      }

      // * Opposing pair found. Check if it is still relevant and in that case level them.

      // Check if found CreditorDebitor should be ignored.
      if (tracker.contains(opposingPair.id)) continue;

      // Check if values cancle each other out.
      final bool cancleOut = creditorDebitor.value == opposingPair.value;

      // Values cancle each other. Exclude and ignore from now on.
      if (cancleOut) {
        tracker.add(creditorDebitor.id);
        tracker.add(opposingPair.id);
        continue;
      }

      // Check which item has the a higher value.
      final bool creditorDebitorIsHigher = creditorDebitor.value > opposingPair.value;

      // Create updated item.
      final CreditorDebitor updatedItem = creditorDebitorIsHigher
          ? creditorDebitor.copyWith(
              value: creditorDebitor.value - opposingPair.value,
            )
          : opposingPair.copyWith(
              value: opposingPair.value - creditorDebitor.value,
            );

      // Depending on which of the two objects remains add to tracker.
      creditorDebitorIsHigher ? tracker.add(opposingPair.id) : tracker.add(creditorDebitor.id);

      // Add to helper.
      helper = helper.add(creditorDebitor: updatedItem);
    }

    return helper;
  }

  /// This method can be used to optimize the settlement by finding the minimum amount of transactions needed.
  CreditorsDebitors optimizedSettlement() {
    // Calculate net balance for each member
    Map<String, double> balanceMap = {};

    for (final CreditorDebitor transaction in items) {
      final String creditorId = transaction.creditor.memberId;
      final String debitorId = transaction.debitor.memberId;

      // Initialize balance for creditor if not already present
      balanceMap.putIfAbsent(creditorId, () => 0);

      // Initialize balance for debitor if not already present
      balanceMap.putIfAbsent(debitorId, () => 0);

      // Update balances
      balanceMap[creditorId] = (balanceMap[creditorId] ?? 0) - transaction.value;
      balanceMap[debitorId] = (balanceMap[debitorId] ?? 0) + transaction.value;
    }

    // Sort members based on net balances
    List<MapEntry<String, double>> balances = balanceMap.entries.toList();
    balances.sort((a, b) => a.value.compareTo(b.value));

    // Balance accounts with the least number of transactions
    int i = 0;
    int j = balances.length - 1;

    List<MapEntry<String, double>> updatedBalances = List.from(balances);

    // Init helper.
    CreditorsDebitors helper = CreditorsDebitors.initial();

    while (i < j) {
      double balanceI = updatedBalances[i].value;
      double balanceJ = updatedBalances[j].value;

      if (balanceI.abs() < 0.01) {
        i++;
        continue;
      }

      if (balanceJ.abs() < 0.01) {
        j--;
        continue;
      }

      // Get the amount to that should be transfered.
      final double amountToTransfer = balanceI.abs() < balanceJ.abs() ? balanceI.abs() : balanceJ.abs();

      // Get Creditor.
      final CreditorDebitor creditor = getCreditor(creditorId: updatedBalances[i].key)!;

      // Get Debitor.
      final CreditorDebitor debitor = getDebitor(debitorId: updatedBalances[j].key)!;

      // Create new object.
      final CreditorDebitor newObject = CreditorDebitor.initial().copyWith(
        creditor: creditor.creditor,
        debitor: debitor.debitor,
        value: amountToTransfer,
      );

      // Add creditorDebitor to helper.
      helper = helper.add(creditorDebitor: newObject);

      // Create updated MapEntry with adjusted values
      updatedBalances[i] = MapEntry(updatedBalances[i].key, updatedBalances[i].value + amountToTransfer);
      updatedBalances[j] = MapEntry(updatedBalances[j].key, updatedBalances[j].value - amountToTransfer);

      if (updatedBalances[i].value.abs() < 0.01) i++;
      if (updatedBalances[j].value.abs() < 0.01) j--;
    }

    return helper;
  }

  // #####################################
  // # Cloud
  // #####################################

  /// This method can be used to decode ```CreditorsDebitors``` from request JSON.
  static CreditorsDebitors fromCloudObject(data) {
    // Init helper.
    List<CreditorDebitor> items = [];

    // Go through returned objects and convert them to local objects.
    for (final dynamic item in data) {
      // Create the object.
      final CreditorDebitor converted = CreditorDebitor.fromCloudObject(item);

      items.add(converted);
    }

    return CreditorsDebitors(
      items: items,
    );
  }

  CreditorsDebitors copyWith({
    List<CreditorDebitor>? items,
  }) {
    return CreditorsDebitors(
      items: items ?? this.items,
    );
  }
}
