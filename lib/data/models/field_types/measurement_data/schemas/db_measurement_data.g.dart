// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_measurement_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbMeasurementDataSchema = Schema(
  name: r'DbMeasurementData',
  id: -6180380769232762139,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'createdAtDefaultDate': PropertySchema(
      id: 1,
      name: r'createdAtDefaultDate',
      type: IsarType.string,
    ),
    r'createdAtDefaultTime': PropertySchema(
      id: 2,
      name: r'createdAtDefaultTime',
      type: IsarType.string,
    ),
    r'createdAtInUtc': PropertySchema(
      id: 3,
      name: r'createdAtInUtc',
      type: IsarType.long,
    ),
    r'createdAtTimezone': PropertySchema(
      id: 4,
      name: r'createdAtTimezone',
      type: IsarType.string,
    ),
    r'encryptedCategory': PropertySchema(
      id: 5,
      name: r'encryptedCategory',
      type: IsarType.byteList,
    ),
    r'encryptedUnit': PropertySchema(
      id: 6,
      name: r'encryptedUnit',
      type: IsarType.byteList,
    ),
    r'encryptedValue': PropertySchema(
      id: 7,
      name: r'encryptedValue',
      type: IsarType.byteList,
    ),
    r'importReferenceCategory': PropertySchema(
      id: 8,
      name: r'importReferenceCategory',
      type: IsarType.string,
    ),
    r'importReferenceDate': PropertySchema(
      id: 9,
      name: r'importReferenceDate',
      type: IsarType.string,
    ),
    r'importReferenceUnit': PropertySchema(
      id: 10,
      name: r'importReferenceUnit',
      type: IsarType.string,
    ),
    r'importReferenceValue': PropertySchema(
      id: 11,
      name: r'importReferenceValue',
      type: IsarType.string,
    ),
    r'unit': PropertySchema(
      id: 12,
      name: r'unit',
      type: IsarType.string,
    ),
    r'value': PropertySchema(
      id: 13,
      name: r'value',
      type: IsarType.double,
    )
  },
  estimateSize: _dbMeasurementDataEstimateSize,
  serialize: _dbMeasurementDataSerialize,
  deserialize: _dbMeasurementDataDeserialize,
  deserializeProp: _dbMeasurementDataDeserializeProp,
);

int _dbMeasurementDataEstimateSize(
  DbMeasurementData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createdAtDefaultDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createdAtDefaultTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createdAtTimezone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.encryptedCategory;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.encryptedUnit;
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
    final value = object.importReferenceCategory;
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
    final value = object.importReferenceUnit;
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
    final value = object.unit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dbMeasurementDataSerialize(
  DbMeasurementData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeString(offsets[1], object.createdAtDefaultDate);
  writer.writeString(offsets[2], object.createdAtDefaultTime);
  writer.writeLong(offsets[3], object.createdAtInUtc);
  writer.writeString(offsets[4], object.createdAtTimezone);
  writer.writeByteList(offsets[5], object.encryptedCategory);
  writer.writeByteList(offsets[6], object.encryptedUnit);
  writer.writeByteList(offsets[7], object.encryptedValue);
  writer.writeString(offsets[8], object.importReferenceCategory);
  writer.writeString(offsets[9], object.importReferenceDate);
  writer.writeString(offsets[10], object.importReferenceUnit);
  writer.writeString(offsets[11], object.importReferenceValue);
  writer.writeString(offsets[12], object.unit);
  writer.writeDouble(offsets[13], object.value);
}

DbMeasurementData _dbMeasurementDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbMeasurementData(
    category: reader.readStringOrNull(offsets[0]),
    createdAtDefaultDate: reader.readStringOrNull(offsets[1]),
    createdAtDefaultTime: reader.readStringOrNull(offsets[2]),
    createdAtInUtc: reader.readLongOrNull(offsets[3]),
    createdAtTimezone: reader.readStringOrNull(offsets[4]),
    encryptedCategory: reader.readByteList(offsets[5]),
    encryptedUnit: reader.readByteList(offsets[6]),
    encryptedValue: reader.readByteList(offsets[7]),
    importReferenceCategory: reader.readStringOrNull(offsets[8]),
    importReferenceDate: reader.readStringOrNull(offsets[9]),
    importReferenceUnit: reader.readStringOrNull(offsets[10]),
    importReferenceValue: reader.readStringOrNull(offsets[11]),
    unit: reader.readStringOrNull(offsets[12]),
    value: reader.readDoubleOrNull(offsets[13]),
  );
  return object;
}

P _dbMeasurementDataDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readByteList(offset)) as P;
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
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbMeasurementDataQueryFilter
    on QueryBuilder<DbMeasurementData, DbMeasurementData, QFilterCondition> {
  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtDefaultDate',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtDefaultDate',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtDefaultDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtDefaultDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtDefaultDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtDefaultTime',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtDefaultTime',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtDefaultTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtDefaultTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtDefaultTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtDefaultTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtInUtcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtInUtc',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtInUtcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtInUtc',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtInUtcEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtTimezoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtTimezone',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtTimezoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtTimezone',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtTimezoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtTimezoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtTimezone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtTimezoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtTimezone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      createdAtTimezoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtTimezone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedCategory',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedCategory',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCategory',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCategory',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCategory',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCategory',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCategory',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedCategoryLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCategory',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedUnit',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedUnit',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedUnit',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedUnit',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedUnit',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedUnit',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedUnit',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedUnitLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedUnit',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      encryptedValueElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceCategory',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceCategory',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceCategory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceDate',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceDate',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceUnit',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceUnit',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceValue',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceValue',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      importReferenceValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unit',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unit',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      valueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      valueEqualTo(
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      valueLessThan(
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

  QueryBuilder<DbMeasurementData, DbMeasurementData, QAfterFilterCondition>
      valueBetween(
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

extension DbMeasurementDataQueryObject
    on QueryBuilder<DbMeasurementData, DbMeasurementData, QFilterCondition> {}
