// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_number_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbNumberDataSchema = Schema(
  name: r'DbNumberData',
  id: 7801389836078995720,
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
    r'quickActionValue': PropertySchema(
      id: 2,
      name: r'quickActionValue',
      type: IsarType.double,
    ),
    r'value': PropertySchema(
      id: 3,
      name: r'value',
      type: IsarType.double,
    )
  },
  estimateSize: _dbNumberDataEstimateSize,
  serialize: _dbNumberDataSerialize,
  deserialize: _dbNumberDataDeserialize,
  deserializeProp: _dbNumberDataDeserializeProp,
);

int _dbNumberDataEstimateSize(
  DbNumberData object,
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
  return bytesCount;
}

void _dbNumberDataSerialize(
  DbNumberData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(offsets[0], object.encryptedValue);
  writer.writeString(offsets[1], object.importReference);
  writer.writeDouble(offsets[2], object.quickActionValue);
  writer.writeDouble(offsets[3], object.value);
}

DbNumberData _dbNumberDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbNumberData(
    encryptedValue: reader.readByteList(offsets[0]),
    importReference: reader.readStringOrNull(offsets[1]),
    quickActionValue: reader.readDoubleOrNull(offsets[2]),
    value: reader.readDoubleOrNull(offsets[3]),
  );
  return object;
}

P _dbNumberDataDeserializeProp<P>(
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
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbNumberDataQueryFilter
    on QueryBuilder<DbNumberData, DbNumberData, QFilterCondition> {
  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      encryptedValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      encryptedValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedValue',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      encryptedValueElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedValue',
        value: value,
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      importReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReference',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      importReferenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReference',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      importReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      importReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      importReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      importReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      quickActionValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quickActionValue',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      quickActionValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quickActionValue',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      quickActionValueEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quickActionValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      quickActionValueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quickActionValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      quickActionValueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quickActionValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      quickActionValueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quickActionValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
      valueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition> valueEqualTo(
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition>
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition> valueLessThan(
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

  QueryBuilder<DbNumberData, DbNumberData, QAfterFilterCondition> valueBetween(
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

extension DbNumberDataQueryObject
    on QueryBuilder<DbNumberData, DbNumberData, QFilterCondition> {}
