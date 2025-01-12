// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_tags_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbTagsDataSchema = Schema(
  name: r'DbTagsData',
  id: -10893204105074746,
  properties: {
    r'importReference': PropertySchema(
      id: 0,
      name: r'importReference',
      type: IsarType.string,
    ),
    r'tagReferences': PropertySchema(
      id: 1,
      name: r'tagReferences',
      type: IsarType.stringList,
    )
  },
  estimateSize: _dbTagsDataEstimateSize,
  serialize: _dbTagsDataSerialize,
  deserialize: _dbTagsDataDeserialize,
  deserializeProp: _dbTagsDataDeserializeProp,
);

int _dbTagsDataEstimateSize(
  DbTagsData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.importReference;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.tagReferences;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  return bytesCount;
}

void _dbTagsDataSerialize(
  DbTagsData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.importReference);
  writer.writeStringList(offsets[1], object.tagReferences);
}

DbTagsData _dbTagsDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbTagsData(
    importReference: reader.readStringOrNull(offsets[0]),
    tagReferences: reader.readStringList(offsets[1]),
  );
  return object;
}

P _dbTagsDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbTagsDataQueryFilter
    on QueryBuilder<DbTagsData, DbTagsData, QFilterCondition> {
  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      importReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReference',
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      importReferenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReference',
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
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

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
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

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
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

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
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

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
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

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
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

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      importReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      importReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      importReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      importReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagReferences',
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagReferences',
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagReferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagReferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagReferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagReferences',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagReferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagReferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagReferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagReferences',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagReferences',
        value: '',
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagReferences',
        value: '',
      ));
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagReferences',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagReferences',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagReferences',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagReferences',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagReferences',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbTagsData, DbTagsData, QAfterFilterCondition>
      tagReferencesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagReferences',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension DbTagsDataQueryObject
    on QueryBuilder<DbTagsData, DbTagsData, QFilterCondition> {}
