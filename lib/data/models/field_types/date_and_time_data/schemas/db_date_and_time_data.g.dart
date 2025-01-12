// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_date_and_time_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbDateAndTimeDataSchema = Schema(
  name: r'DbDateAndTimeData',
  id: 3743539350956574866,
  properties: {
    r'encryptedValue': PropertySchema(
      id: 0,
      name: r'encryptedValue',
      type: IsarType.byteList,
    ),
    r'importReference': PropertySchema(
      id: 1,
      name: r'importReference',
      type: IsarType.string,
    ),
    r'timezone': PropertySchema(
      id: 2,
      name: r'timezone',
      type: IsarType.string,
    ),
    r'valueDefaultDate': PropertySchema(
      id: 3,
      name: r'valueDefaultDate',
      type: IsarType.string,
    ),
    r'valueDefaultTime': PropertySchema(
      id: 4,
      name: r'valueDefaultTime',
      type: IsarType.string,
    ),
    r'valueInUtc': PropertySchema(
      id: 5,
      name: r'valueInUtc',
      type: IsarType.long,
    )
  },
  estimateSize: _dbDateAndTimeDataEstimateSize,
  serialize: _dbDateAndTimeDataSerialize,
  deserialize: _dbDateAndTimeDataDeserialize,
  deserializeProp: _dbDateAndTimeDataDeserializeProp,
);

int _dbDateAndTimeDataEstimateSize(
  DbDateAndTimeData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.encryptedValue;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.importReference;
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
    final value = object.valueDefaultDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.valueDefaultTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dbDateAndTimeDataSerialize(
  DbDateAndTimeData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(offsets[0], object.encryptedValue);
  writer.writeString(offsets[1], object.importReference);
  writer.writeString(offsets[2], object.timezone);
  writer.writeString(offsets[3], object.valueDefaultDate);
  writer.writeString(offsets[4], object.valueDefaultTime);
  writer.writeLong(offsets[5], object.valueInUtc);
}

DbDateAndTimeData _dbDateAndTimeDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbDateAndTimeData(
    encryptedValue: reader.readByteList(offsets[0]),
    importReference: reader.readStringOrNull(offsets[1]),
    timezone: reader.readStringOrNull(offsets[2]),
    valueDefaultDate: reader.readStringOrNull(offsets[3]),
    valueDefaultTime: reader.readStringOrNull(offsets[4]),
    valueInUtc: reader.readLongOrNull(offsets[5]),
  );
  return object;
}

P _dbDateAndTimeDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readByteList(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbDateAndTimeDataQueryFilter
    on QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QFilterCondition> {
  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      encryptedValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      encryptedValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      encryptedValueElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
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

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
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

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
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

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
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

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
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

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
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

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
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

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
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

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
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

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReference',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReference',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      importReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timezone',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timezone',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timezone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timezone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timezone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      timezoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timezone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'valueDefaultDate',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'valueDefaultDate',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valueDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valueDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valueDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valueDefaultDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'valueDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'valueDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'valueDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'valueDefaultDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valueDefaultDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'valueDefaultDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'valueDefaultTime',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'valueDefaultTime',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valueDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valueDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valueDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valueDefaultTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'valueDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'valueDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'valueDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'valueDefaultTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valueDefaultTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueDefaultTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'valueDefaultTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueInUtcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'valueInUtc',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueInUtcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'valueInUtc',
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueInUtcEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valueInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueInUtcGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valueInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueInUtcLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valueInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QAfterFilterCondition>
      valueInUtcBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valueInUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DbDateAndTimeDataQueryObject
    on QueryBuilder<DbDateAndTimeData, DbDateAndTimeData, QFilterCondition> {}
