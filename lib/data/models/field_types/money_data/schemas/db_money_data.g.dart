// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_money_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbMoneyDataSchema = Schema(
  name: r'DbMoneyData',
  id: 2219498887897016833,
  properties: {
    r'createdAtDefaultDate': PropertySchema(
      id: 0,
      name: r'createdAtDefaultDate',
      type: IsarType.string,
    ),
    r'createdAtDefaultTime': PropertySchema(
      id: 1,
      name: r'createdAtDefaultTime',
      type: IsarType.string,
    ),
    r'createdAtInUtc': PropertySchema(
      id: 2,
      name: r'createdAtInUtc',
      type: IsarType.long,
    ),
    r'createdAtTimezone': PropertySchema(
      id: 3,
      name: r'createdAtTimezone',
      type: IsarType.string,
    ),
    r'currencyCode': PropertySchema(
      id: 4,
      name: r'currencyCode',
      type: IsarType.string,
    ),
    r'customExchangeRates': PropertySchema(
      id: 5,
      name: r'customExchangeRates',
      type: IsarType.string,
    ),
    r'encryptedCurrency': PropertySchema(
      id: 6,
      name: r'encryptedCurrency',
      type: IsarType.byteList,
    ),
    r'encryptedValue': PropertySchema(
      id: 7,
      name: r'encryptedValue',
      type: IsarType.byteList,
    ),
    r'importReferenceCurrency': PropertySchema(
      id: 8,
      name: r'importReferenceCurrency',
      type: IsarType.string,
    ),
    r'importReferenceDate': PropertySchema(
      id: 9,
      name: r'importReferenceDate',
      type: IsarType.string,
    ),
    r'importReferenceExchangeRate': PropertySchema(
      id: 10,
      name: r'importReferenceExchangeRate',
      type: IsarType.string,
    ),
    r'importReferenceTags': PropertySchema(
      id: 11,
      name: r'importReferenceTags',
      type: IsarType.string,
    ),
    r'importReferenceValue': PropertySchema(
      id: 12,
      name: r'importReferenceValue',
      type: IsarType.string,
    ),
    r'tagsData': PropertySchema(
      id: 13,
      name: r'tagsData',
      type: IsarType.object,
      target: r'DbTagsData',
    ),
    r'value': PropertySchema(
      id: 14,
      name: r'value',
      type: IsarType.double,
    )
  },
  estimateSize: _dbMoneyDataEstimateSize,
  serialize: _dbMoneyDataSerialize,
  deserialize: _dbMoneyDataDeserialize,
  deserializeProp: _dbMoneyDataDeserializeProp,
);

int _dbMoneyDataEstimateSize(
  DbMoneyData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.defaultDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.defaultTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.timezone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.currencyCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.customExchangeRates;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.encryptedCurrency;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.encryptedValue;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.importReferenceCurrency;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceExchangeRate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceTags;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceValue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tagsData;
    if (value != null) {
      bytesCount += 3 +
          DbTagsDataSchema.estimateSize(
              value, allOffsets[DbTagsData]!, allOffsets);
    }
  }
  return bytesCount;
}

void _dbMoneyDataSerialize(
  DbMoneyData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.defaultDate);
  writer.writeString(offsets[1], object.defaultTime);
  writer.writeLong(offsets[2], object.createdAtInUtc);
  writer.writeString(offsets[3], object.timezone);
  writer.writeString(offsets[4], object.currencyCode);
  writer.writeString(offsets[5], object.customExchangeRates);
  writer.writeByteList(offsets[6], object.encryptedCurrency);
  writer.writeByteList(offsets[7], object.encryptedValue);
  writer.writeString(offsets[8], object.importReferenceCurrency);
  writer.writeString(offsets[9], object.importReferenceDate);
  writer.writeString(offsets[10], object.importReferenceExchangeRate);
  writer.writeString(offsets[11], object.importReferenceTags);
  writer.writeString(offsets[12], object.importReferenceValue);
  writer.writeObject<DbTagsData>(
    offsets[13],
    allOffsets,
    DbTagsDataSchema.serialize,
    object.tagsData,
  );
  writer.writeDouble(offsets[14], object.value);
}

DbMoneyData _dbMoneyDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbMoneyData(
    defaultDate: reader.readStringOrNull(offsets[0]),
    defaultTime: reader.readStringOrNull(offsets[1]),
    createdAtInUtc: reader.readLongOrNull(offsets[2]),
    timezone: reader.readStringOrNull(offsets[3]),
    currencyCode: reader.readStringOrNull(offsets[4]),
    customExchangeRates: reader.readStringOrNull(offsets[5]),
    encryptedCurrency: reader.readByteList(offsets[6]),
    encryptedValue: reader.readByteList(offsets[7]),
    importReferenceCurrency: reader.readStringOrNull(offsets[8]),
    importReferenceDate: reader.readStringOrNull(offsets[9]),
    importReferenceExchangeRate: reader.readStringOrNull(offsets[10]),
    importReferenceTags: reader.readStringOrNull(offsets[11]),
    importReferenceValue: reader.readStringOrNull(offsets[12]),
    tagsData: reader.readObjectOrNull<DbTagsData>(
      offsets[13],
      DbTagsDataSchema.deserialize,
      allOffsets,
    ),
    value: reader.readDoubleOrNull(offsets[14]),
  );
  return object;
}

P _dbMoneyDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readByteList(offset)) as P;
    case 7:
      return (reader.readByteList(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readObjectOrNull<DbTagsData>(
        offset,
        DbTagsDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 14:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbMoneyDataQueryFilter
    on QueryBuilder<DbMoneyData, DbMoneyData, QFilterCondition> {
  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtDefaultDate',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtDefaultDate',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtDefaultDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAtDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAtDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtDefaultDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtDefaultDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtDefaultDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtDefaultTime',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtDefaultTime',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtDefaultTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAtDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAtDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtDefaultTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtDefaultTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtDefaultTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtDefaultTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtInUtcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtInUtc',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtInUtcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtInUtc',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtInUtcEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtInUtcGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtInUtcLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtInUtcBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtInUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtTimezone',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtTimezone',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtTimezone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAtTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAtTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtTimezone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtTimezone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      createdAtTimezoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtTimezone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currencyCode',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currencyCode',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currencyCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currencyCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currencyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      currencyCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currencyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customExchangeRates',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customExchangeRates',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customExchangeRates',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customExchangeRates',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customExchangeRates',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      customExchangeRatesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customExchangeRates',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedCurrency',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedCurrency',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedCurrency',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedCurrency',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedCurrency',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedCurrencyLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedValue',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedValue',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedValue',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedValue',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedValue',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      encryptedValueLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedValue',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceCurrency',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceCurrency',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceDate',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceDate',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceExchangeRate',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceExchangeRate',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceExchangeRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceExchangeRate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceExchangeRate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceExchangeRateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceExchangeRate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceTags',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceTags',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceTags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceTags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceTags',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceTags',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceValue',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceValue',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      importReferenceValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      tagsDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagsData',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      tagsDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagsData',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition> valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      valueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition> valueEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition>
      valueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition> valueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition> valueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension DbMoneyDataQueryObject
    on QueryBuilder<DbMoneyData, DbMoneyData, QFilterCondition> {
  QueryBuilder<DbMoneyData, DbMoneyData, QAfterFilterCondition> tagsData(
      FilterQuery<DbTagsData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'tagsData');
    });
  }
}
