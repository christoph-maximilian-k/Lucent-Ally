// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_username_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbUsernameDataSchema = Schema(
  name: r'DbUsernameData',
  id: -528677323668037806,
  properties: {
    r'encryptedService': PropertySchema(
      id: 0,
      name: r'encryptedService',
      type: IsarType.byteList,
    ),
    r'encryptedValue': PropertySchema(
      id: 1,
      name: r'encryptedValue',
      type: IsarType.byteList,
    ),
    r'importReferenceOptionalValue': PropertySchema(
      id: 2,
      name: r'importReferenceOptionalValue',
      type: IsarType.string,
    ),
    r'importReferenceValue': PropertySchema(
      id: 3,
      name: r'importReferenceValue',
      type: IsarType.string,
    ),
    r'service': PropertySchema(
      id: 4,
      name: r'service',
      type: IsarType.string,
    ),
    r'value': PropertySchema(
      id: 5,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _dbUsernameDataEstimateSize,
  serialize: _dbUsernameDataSerialize,
  deserialize: _dbUsernameDataDeserialize,
  deserializeProp: _dbUsernameDataDeserializeProp,
);

int _dbUsernameDataEstimateSize(
  DbUsernameData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.encryptedService;
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
    final value = object.importReferenceOptionalValue;
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
    final value = object.service;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.value;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dbUsernameDataSerialize(
  DbUsernameData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(offsets[0], object.encryptedService);
  writer.writeByteList(offsets[1], object.encryptedValue);
  writer.writeString(offsets[2], object.importReferenceOptionalValue);
  writer.writeString(offsets[3], object.importReferenceValue);
  writer.writeString(offsets[4], object.service);
  writer.writeString(offsets[5], object.value);
}

DbUsernameData _dbUsernameDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbUsernameData(
    encryptedService: reader.readByteList(offsets[0]),
    encryptedValue: reader.readByteList(offsets[1]),
    importReferenceOptionalValue: reader.readStringOrNull(offsets[2]),
    importReferenceValue: reader.readStringOrNull(offsets[3]),
    service: reader.readStringOrNull(offsets[4]),
    value: reader.readStringOrNull(offsets[5]),
  );
  return object;
}

P _dbUsernameDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readByteList(offset)) as P;
    case 1:
      return (reader.readByteList(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbUsernameDataQueryFilter
    on QueryBuilder<DbUsernameData, DbUsernameData, QFilterCondition> {
  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedService',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedService',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedService',
        value: value,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedService',
        value: value,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedService',
        value: value,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedService',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedService',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedService',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedService',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedService',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedService',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedServiceLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedService',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      encryptedValueElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceOptionalValue',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceOptionalValue',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceOptionalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceOptionalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceOptionalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceOptionalValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceOptionalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceOptionalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceOptionalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceOptionalValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceOptionalValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceOptionalValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceOptionalValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceValue',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceValue',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
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

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      importReferenceValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'service',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'service',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'service',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'service',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'service',
        value: '',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      serviceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'service',
        value: '',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<DbUsernameData, DbUsernameData, QAfterFilterCondition>
      valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension DbUsernameDataQueryObject
    on QueryBuilder<DbUsernameData, DbUsernameData, QFilterCondition> {}
