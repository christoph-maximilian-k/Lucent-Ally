// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_exchange_rate.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbExchangeRateCollection on Isar {
  IsarCollection<DbExchangeRate> get dbExchangeRates => this.collection();
}

const DbExchangeRateSchema = CollectionSchema(
  name: r'DbExchangeRate',
  id: 2060905571577365415,
  properties: {
    r'exchangeRate': PropertySchema(
      id: 0,
      name: r'exchangeRate',
      type: IsarType.double,
    ),
    r'exchangeRateDateInUtc': PropertySchema(
      id: 1,
      name: r'exchangeRateDateInUtc',
      type: IsarType.long,
    ),
    r'exchangeRateId': PropertySchema(
      id: 2,
      name: r'exchangeRateId',
      type: IsarType.string,
    ),
    r'exchangeRateKey': PropertySchema(
      id: 3,
      name: r'exchangeRateKey',
      type: IsarType.string,
    ),
    r'fromCurrencyCode': PropertySchema(
      id: 4,
      name: r'fromCurrencyCode',
      type: IsarType.string,
    ),
    r'toCurrencyCode': PropertySchema(
      id: 5,
      name: r'toCurrencyCode',
      type: IsarType.string,
    )
  },
  estimateSize: _dbExchangeRateEstimateSize,
  serialize: _dbExchangeRateSerialize,
  deserialize: _dbExchangeRateDeserialize,
  deserializeProp: _dbExchangeRateDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'exchangeRateId': IndexSchema(
      id: 6143584837580462113,
      name: r'exchangeRateId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'exchangeRateId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'exchangeRateDateInUtc_exchangeRateKey': IndexSchema(
      id: -6290658965984736589,
      name: r'exchangeRateDateInUtc_exchangeRateKey',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'exchangeRateDateInUtc',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'exchangeRateKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dbExchangeRateGetId,
  getLinks: _dbExchangeRateGetLinks,
  attach: _dbExchangeRateAttach,
  version: '3.1.0+1',
);

int _dbExchangeRateEstimateSize(
  DbExchangeRate object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.exchangeRateId.length * 3;
  bytesCount += 3 + object.exchangeRateKey.length * 3;
  bytesCount += 3 + object.fromCurrencyCode.length * 3;
  bytesCount += 3 + object.toCurrencyCode.length * 3;
  return bytesCount;
}

void _dbExchangeRateSerialize(
  DbExchangeRate object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.exchangeRate);
  writer.writeLong(offsets[1], object.exchangeRateDateInUtc);
  writer.writeString(offsets[2], object.exchangeRateId);
  writer.writeString(offsets[3], object.exchangeRateKey);
  writer.writeString(offsets[4], object.fromCurrencyCode);
  writer.writeString(offsets[5], object.toCurrencyCode);
}

DbExchangeRate _dbExchangeRateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbExchangeRate(
    exchangeRate: reader.readDouble(offsets[0]),
    exchangeRateDateInUtc: reader.readLong(offsets[1]),
    exchangeRateId: reader.readString(offsets[2]),
    fromCurrencyCode: reader.readString(offsets[4]),
    toCurrencyCode: reader.readString(offsets[5]),
  );
  return object;
}

P _dbExchangeRateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbExchangeRateGetId(DbExchangeRate object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbExchangeRateGetLinks(DbExchangeRate object) {
  return [];
}

void _dbExchangeRateAttach(
    IsarCollection<dynamic> col, Id id, DbExchangeRate object) {}

extension DbExchangeRateByIndex on IsarCollection<DbExchangeRate> {
  Future<DbExchangeRate?> getByExchangeRateDateInUtcExchangeRateKey(
      int exchangeRateDateInUtc, String exchangeRateKey) {
    return getByIndex(r'exchangeRateDateInUtc_exchangeRateKey',
        [exchangeRateDateInUtc, exchangeRateKey]);
  }

  DbExchangeRate? getByExchangeRateDateInUtcExchangeRateKeySync(
      int exchangeRateDateInUtc, String exchangeRateKey) {
    return getByIndexSync(r'exchangeRateDateInUtc_exchangeRateKey',
        [exchangeRateDateInUtc, exchangeRateKey]);
  }

  Future<bool> deleteByExchangeRateDateInUtcExchangeRateKey(
      int exchangeRateDateInUtc, String exchangeRateKey) {
    return deleteByIndex(r'exchangeRateDateInUtc_exchangeRateKey',
        [exchangeRateDateInUtc, exchangeRateKey]);
  }

  bool deleteByExchangeRateDateInUtcExchangeRateKeySync(
      int exchangeRateDateInUtc, String exchangeRateKey) {
    return deleteByIndexSync(r'exchangeRateDateInUtc_exchangeRateKey',
        [exchangeRateDateInUtc, exchangeRateKey]);
  }

  Future<List<DbExchangeRate?>> getAllByExchangeRateDateInUtcExchangeRateKey(
      List<int> exchangeRateDateInUtcValues,
      List<String> exchangeRateKeyValues) {
    final len = exchangeRateDateInUtcValues.length;
    assert(exchangeRateKeyValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([exchangeRateDateInUtcValues[i], exchangeRateKeyValues[i]]);
    }

    return getAllByIndex(r'exchangeRateDateInUtc_exchangeRateKey', values);
  }

  List<DbExchangeRate?> getAllByExchangeRateDateInUtcExchangeRateKeySync(
      List<int> exchangeRateDateInUtcValues,
      List<String> exchangeRateKeyValues) {
    final len = exchangeRateDateInUtcValues.length;
    assert(exchangeRateKeyValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([exchangeRateDateInUtcValues[i], exchangeRateKeyValues[i]]);
    }

    return getAllByIndexSync(r'exchangeRateDateInUtc_exchangeRateKey', values);
  }

  Future<int> deleteAllByExchangeRateDateInUtcExchangeRateKey(
      List<int> exchangeRateDateInUtcValues,
      List<String> exchangeRateKeyValues) {
    final len = exchangeRateDateInUtcValues.length;
    assert(exchangeRateKeyValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([exchangeRateDateInUtcValues[i], exchangeRateKeyValues[i]]);
    }

    return deleteAllByIndex(r'exchangeRateDateInUtc_exchangeRateKey', values);
  }

  int deleteAllByExchangeRateDateInUtcExchangeRateKeySync(
      List<int> exchangeRateDateInUtcValues,
      List<String> exchangeRateKeyValues) {
    final len = exchangeRateDateInUtcValues.length;
    assert(exchangeRateKeyValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([exchangeRateDateInUtcValues[i], exchangeRateKeyValues[i]]);
    }

    return deleteAllByIndexSync(
        r'exchangeRateDateInUtc_exchangeRateKey', values);
  }

  Future<Id> putByExchangeRateDateInUtcExchangeRateKey(DbExchangeRate object) {
    return putByIndex(r'exchangeRateDateInUtc_exchangeRateKey', object);
  }

  Id putByExchangeRateDateInUtcExchangeRateKeySync(DbExchangeRate object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'exchangeRateDateInUtc_exchangeRateKey', object,
        saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByExchangeRateDateInUtcExchangeRateKey(
      List<DbExchangeRate> objects) {
    return putAllByIndex(r'exchangeRateDateInUtc_exchangeRateKey', objects);
  }

  List<Id> putAllByExchangeRateDateInUtcExchangeRateKeySync(
      List<DbExchangeRate> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'exchangeRateDateInUtc_exchangeRateKey', objects,
        saveLinks: saveLinks);
  }
}

extension DbExchangeRateQueryWhereSort
    on QueryBuilder<DbExchangeRate, DbExchangeRate, QWhere> {
  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DbExchangeRateQueryWhere
    on QueryBuilder<DbExchangeRate, DbExchangeRate, QWhereClause> {
  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      exchangeRateIdEqualTo(String exchangeRateId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'exchangeRateId',
        value: [exchangeRateId],
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      exchangeRateIdNotEqualTo(String exchangeRateId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateId',
              lower: [],
              upper: [exchangeRateId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateId',
              lower: [exchangeRateId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateId',
              lower: [exchangeRateId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateId',
              lower: [],
              upper: [exchangeRateId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      exchangeRateDateInUtcEqualToAnyExchangeRateKey(
          int exchangeRateDateInUtc) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'exchangeRateDateInUtc_exchangeRateKey',
        value: [exchangeRateDateInUtc],
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      exchangeRateDateInUtcNotEqualToAnyExchangeRateKey(
          int exchangeRateDateInUtc) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateDateInUtc_exchangeRateKey',
              lower: [],
              upper: [exchangeRateDateInUtc],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateDateInUtc_exchangeRateKey',
              lower: [exchangeRateDateInUtc],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateDateInUtc_exchangeRateKey',
              lower: [exchangeRateDateInUtc],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateDateInUtc_exchangeRateKey',
              lower: [],
              upper: [exchangeRateDateInUtc],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      exchangeRateDateInUtcGreaterThanAnyExchangeRateKey(
    int exchangeRateDateInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'exchangeRateDateInUtc_exchangeRateKey',
        lower: [exchangeRateDateInUtc],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      exchangeRateDateInUtcLessThanAnyExchangeRateKey(
    int exchangeRateDateInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'exchangeRateDateInUtc_exchangeRateKey',
        lower: [],
        upper: [exchangeRateDateInUtc],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      exchangeRateDateInUtcBetweenAnyExchangeRateKey(
    int lowerExchangeRateDateInUtc,
    int upperExchangeRateDateInUtc, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'exchangeRateDateInUtc_exchangeRateKey',
        lower: [lowerExchangeRateDateInUtc],
        includeLower: includeLower,
        upper: [upperExchangeRateDateInUtc],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      exchangeRateDateInUtcExchangeRateKeyEqualTo(
          int exchangeRateDateInUtc, String exchangeRateKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'exchangeRateDateInUtc_exchangeRateKey',
        value: [exchangeRateDateInUtc, exchangeRateKey],
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterWhereClause>
      exchangeRateDateInUtcEqualToExchangeRateKeyNotEqualTo(
          int exchangeRateDateInUtc, String exchangeRateKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateDateInUtc_exchangeRateKey',
              lower: [exchangeRateDateInUtc],
              upper: [exchangeRateDateInUtc, exchangeRateKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateDateInUtc_exchangeRateKey',
              lower: [exchangeRateDateInUtc, exchangeRateKey],
              includeLower: false,
              upper: [exchangeRateDateInUtc],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateDateInUtc_exchangeRateKey',
              lower: [exchangeRateDateInUtc, exchangeRateKey],
              includeLower: false,
              upper: [exchangeRateDateInUtc],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'exchangeRateDateInUtc_exchangeRateKey',
              lower: [exchangeRateDateInUtc],
              upper: [exchangeRateDateInUtc, exchangeRateKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbExchangeRateQueryFilter
    on QueryBuilder<DbExchangeRate, DbExchangeRate, QFilterCondition> {
  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exchangeRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exchangeRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exchangeRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateDateInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeRateDateInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateDateInUtcGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exchangeRateDateInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateDateInUtcLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exchangeRateDateInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateDateInUtcBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exchangeRateDateInUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeRateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exchangeRateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exchangeRateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exchangeRateId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exchangeRateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exchangeRateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exchangeRateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exchangeRateId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeRateId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exchangeRateId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeRateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exchangeRateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exchangeRateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exchangeRateKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exchangeRateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exchangeRateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exchangeRateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exchangeRateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exchangeRateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      exchangeRateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exchangeRateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromCurrencyCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fromCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fromCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromCurrencyCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromCurrencyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      fromCurrencyCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromCurrencyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toCurrencyCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toCurrencyCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toCurrencyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterFilterCondition>
      toCurrencyCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toCurrencyCode',
        value: '',
      ));
    });
  }
}

extension DbExchangeRateQueryObject
    on QueryBuilder<DbExchangeRate, DbExchangeRate, QFilterCondition> {}

extension DbExchangeRateQueryLinks
    on QueryBuilder<DbExchangeRate, DbExchangeRate, QFilterCondition> {}

extension DbExchangeRateQuerySortBy
    on QueryBuilder<DbExchangeRate, DbExchangeRate, QSortBy> {
  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByExchangeRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRate', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByExchangeRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRate', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByExchangeRateDateInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateDateInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByExchangeRateDateInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateDateInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByExchangeRateId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateId', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByExchangeRateIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateId', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByExchangeRateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateKey', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByExchangeRateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateKey', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByFromCurrencyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrencyCode', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByFromCurrencyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrencyCode', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByToCurrencyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrencyCode', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      sortByToCurrencyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrencyCode', Sort.desc);
    });
  }
}

extension DbExchangeRateQuerySortThenBy
    on QueryBuilder<DbExchangeRate, DbExchangeRate, QSortThenBy> {
  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByExchangeRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRate', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByExchangeRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRate', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByExchangeRateDateInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateDateInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByExchangeRateDateInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateDateInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByExchangeRateId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateId', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByExchangeRateIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateId', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByExchangeRateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateKey', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByExchangeRateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exchangeRateKey', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByFromCurrencyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrencyCode', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByFromCurrencyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromCurrencyCode', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByToCurrencyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrencyCode', Sort.asc);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QAfterSortBy>
      thenByToCurrencyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toCurrencyCode', Sort.desc);
    });
  }
}

extension DbExchangeRateQueryWhereDistinct
    on QueryBuilder<DbExchangeRate, DbExchangeRate, QDistinct> {
  QueryBuilder<DbExchangeRate, DbExchangeRate, QDistinct>
      distinctByExchangeRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exchangeRate');
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QDistinct>
      distinctByExchangeRateDateInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exchangeRateDateInUtc');
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QDistinct>
      distinctByExchangeRateId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exchangeRateId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QDistinct>
      distinctByExchangeRateKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exchangeRateKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QDistinct>
      distinctByFromCurrencyCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromCurrencyCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbExchangeRate, DbExchangeRate, QDistinct>
      distinctByToCurrencyCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toCurrencyCode',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbExchangeRateQueryProperty
    on QueryBuilder<DbExchangeRate, DbExchangeRate, QQueryProperty> {
  QueryBuilder<DbExchangeRate, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbExchangeRate, double, QQueryOperations>
      exchangeRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exchangeRate');
    });
  }

  QueryBuilder<DbExchangeRate, int, QQueryOperations>
      exchangeRateDateInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exchangeRateDateInUtc');
    });
  }

  QueryBuilder<DbExchangeRate, String, QQueryOperations>
      exchangeRateIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exchangeRateId');
    });
  }

  QueryBuilder<DbExchangeRate, String, QQueryOperations>
      exchangeRateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exchangeRateKey');
    });
  }

  QueryBuilder<DbExchangeRate, String, QQueryOperations>
      fromCurrencyCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromCurrencyCode');
    });
  }

  QueryBuilder<DbExchangeRate, String, QQueryOperations>
      toCurrencyCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toCurrencyCode');
    });
  }
}
