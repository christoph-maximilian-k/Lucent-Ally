import 'package:isar/isar.dart';

part 'db_exchange_rate.g.dart';

@collection
class DbExchangeRate {
  @Index()
  final String exchangeRateId;

  // This is the recommended way of using string ids.
  Id get isarId => fastHash(exchangeRateId);

  @Index(unique: true, composite: [CompositeIndex('exchangeRateKey')])
  final int exchangeRateDateInUtc;

  final String fromCurrencyCode;

  final String toCurrencyCode;

  final double exchangeRate;

  const DbExchangeRate({
    required this.exchangeRateId,
    required this.exchangeRateDateInUtc,
    required this.fromCurrencyCode,
    required this.toCurrencyCode,
    required this.exchangeRate,
  });

  /// The name of this collection: ```exchange_rates```
  static const String collectionName = 'exchange_rates';

  /// Create a standardized key for the exchange rate based on sorted currency codes.
  /// * This is done to also be able to efficiently query reciprocal exchange rates.
  String get exchangeRateKey => (fromCurrencyCode.compareTo(toCurrencyCode) < 0) ? '$fromCurrencyCode-$toCurrencyCode' : '$toCurrencyCode-$fromCurrencyCode';

  /// FNV-1a 64bit hash algorithm optimized for Dart Strings.
  static int fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}
