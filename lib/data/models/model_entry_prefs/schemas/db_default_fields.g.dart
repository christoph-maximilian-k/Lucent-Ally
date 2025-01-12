// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_default_fields.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbDefaultFieldsSchema = Schema(
  name: r'DbDefaultFields',
  id: 4997555460763359719,
  properties: {
    r'defaultEntryName': PropertySchema(
      id: 0,
      name: r'defaultEntryName',
      type: IsarType.string,
    ),
    r'fields': PropertySchema(
      id: 1,
      name: r'fields',
      type: IsarType.object,
      target: r'DbFields',
    )
  },
  estimateSize: _dbDefaultFieldsEstimateSize,
  serialize: _dbDefaultFieldsSerialize,
  deserialize: _dbDefaultFieldsDeserialize,
  deserializeProp: _dbDefaultFieldsDeserializeProp,
);

int _dbDefaultFieldsEstimateSize(
  DbDefaultFields object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.defaultEntryName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fields;
    if (value != null) {
      bytesCount += 3 +
          DbFieldsSchema.estimateSize(value, allOffsets[DbFields]!, allOffsets);
    }
  }
  return bytesCount;
}

void _dbDefaultFieldsSerialize(
  DbDefaultFields object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.defaultEntryName);
  writer.writeObject<DbFields>(
    offsets[1],
    allOffsets,
    DbFieldsSchema.serialize,
    object.fields,
  );
}

DbDefaultFields _dbDefaultFieldsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbDefaultFields(
    defaultEntryName: reader.readStringOrNull(offsets[0]),
    fields: reader.readObjectOrNull<DbFields>(
      offsets[1],
      DbFieldsSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _dbDefaultFieldsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<DbFields>(
        offset,
        DbFieldsSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbDefaultFieldsQueryFilter
    on QueryBuilder<DbDefaultFields, DbDefaultFields, QFilterCondition> {
  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defaultEntryName',
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defaultEntryName',
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultEntryName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultEntryName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultEntryName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      defaultEntryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultEntryName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      fieldsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fields',
      ));
    });
  }

  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition>
      fieldsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fields',
      ));
    });
  }
}

extension DbDefaultFieldsQueryObject
    on QueryBuilder<DbDefaultFields, DbDefaultFields, QFilterCondition> {
  QueryBuilder<DbDefaultFields, DbDefaultFields, QAfterFilterCondition> fields(
      FilterQuery<DbFields> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fields');
    });
  }
}
