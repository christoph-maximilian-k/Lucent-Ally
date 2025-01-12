// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_group_prefs.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbGroupPrefsCollection on Isar {
  IsarCollection<DbGroupPrefs> get dbGroupPrefs => this.collection();
}

const DbGroupPrefsSchema = CollectionSchema(
  name: r'DbGroupPrefs',
  id: 9015187951148025859,
  properties: {
    r'createdAtInUtc': PropertySchema(
      id: 0,
      name: r'createdAtInUtc',
      type: IsarType.long,
    ),
    r'editedAtInUtc': PropertySchema(
      id: 1,
      name: r'editedAtInUtc',
      type: IsarType.long,
    ),
    r'entriesSortedBy': PropertySchema(
      id: 2,
      name: r'entriesSortedBy',
      type: IsarType.string,
    ),
    r'groupId': PropertySchema(
      id: 3,
      name: r'groupId',
      type: IsarType.string,
    ),
    r'quickAddReference': PropertySchema(
      id: 4,
      name: r'quickAddReference',
      type: IsarType.string,
    ),
    r'subgroupsDisplayFormat': PropertySchema(
      id: 5,
      name: r'subgroupsDisplayFormat',
      type: IsarType.string,
    ),
    r'subgroupsSortedBy': PropertySchema(
      id: 6,
      name: r'subgroupsSortedBy',
      type: IsarType.string,
    )
  },
  estimateSize: _dbGroupPrefsEstimateSize,
  serialize: _dbGroupPrefsSerialize,
  deserialize: _dbGroupPrefsDeserialize,
  deserializeProp: _dbGroupPrefsDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'groupId': IndexSchema(
      id: -8523216633229774932,
      name: r'groupId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'groupId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dbGroupPrefsGetId,
  getLinks: _dbGroupPrefsGetLinks,
  attach: _dbGroupPrefsAttach,
  version: '3.1.0+1',
);

int _dbGroupPrefsEstimateSize(
  DbGroupPrefs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.entriesSortedBy.length * 3;
  bytesCount += 3 + object.groupId.length * 3;
  bytesCount += 3 + object.quickAddReference.length * 3;
  bytesCount += 3 + object.subgroupsDisplayFormat.length * 3;
  bytesCount += 3 + object.subgroupsSortedBy.length * 3;
  return bytesCount;
}

void _dbGroupPrefsSerialize(
  DbGroupPrefs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdAtInUtc);
  writer.writeLong(offsets[1], object.editedAtInUtc);
  writer.writeString(offsets[2], object.entriesSortedBy);
  writer.writeString(offsets[3], object.groupId);
  writer.writeString(offsets[4], object.quickAddReference);
  writer.writeString(offsets[5], object.subgroupsDisplayFormat);
  writer.writeString(offsets[6], object.subgroupsSortedBy);
}

DbGroupPrefs _dbGroupPrefsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbGroupPrefs(
    createdAtInUtc: reader.readLong(offsets[0]),
    editedAtInUtc: reader.readLong(offsets[1]),
    entriesSortedBy: reader.readString(offsets[2]),
    groupId: reader.readString(offsets[3]),
    quickAddReference: reader.readString(offsets[4]),
    subgroupsDisplayFormat: reader.readString(offsets[5]),
    subgroupsSortedBy: reader.readString(offsets[6]),
  );
  return object;
}

P _dbGroupPrefsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
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
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbGroupPrefsGetId(DbGroupPrefs object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbGroupPrefsGetLinks(DbGroupPrefs object) {
  return [];
}

void _dbGroupPrefsAttach(
    IsarCollection<dynamic> col, Id id, DbGroupPrefs object) {}

extension DbGroupPrefsQueryWhereSort
    on QueryBuilder<DbGroupPrefs, DbGroupPrefs, QWhere> {
  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DbGroupPrefsQueryWhere
    on QueryBuilder<DbGroupPrefs, DbGroupPrefs, QWhereClause> {
  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
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

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterWhereClause> groupIdEqualTo(
      String groupId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'groupId',
        value: [groupId],
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterWhereClause> groupIdNotEqualTo(
      String groupId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupId',
              lower: [],
              upper: [groupId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupId',
              lower: [groupId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupId',
              lower: [groupId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupId',
              lower: [],
              upper: [groupId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbGroupPrefsQueryFilter
    on QueryBuilder<DbGroupPrefs, DbGroupPrefs, QFilterCondition> {
  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      createdAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      createdAtInUtcGreaterThan(
    int value, {
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

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      createdAtInUtcLessThan(
    int value, {
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

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      createdAtInUtcBetween(
    int lower,
    int upper, {
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

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      editedAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      editedAtInUtcGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      editedAtInUtcLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      editedAtInUtcBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'editedAtInUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entriesSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entriesSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entriesSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entriesSortedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entriesSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entriesSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entriesSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entriesSortedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entriesSortedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      entriesSortedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entriesSortedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      groupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quickAddReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quickAddReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quickAddReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quickAddReference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quickAddReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quickAddReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quickAddReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quickAddReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quickAddReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      quickAddReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quickAddReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subgroupsDisplayFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subgroupsDisplayFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subgroupsDisplayFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subgroupsDisplayFormat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subgroupsDisplayFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subgroupsDisplayFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subgroupsDisplayFormat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subgroupsDisplayFormat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subgroupsDisplayFormat',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsDisplayFormatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subgroupsDisplayFormat',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subgroupsSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subgroupsSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subgroupsSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subgroupsSortedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subgroupsSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subgroupsSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subgroupsSortedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subgroupsSortedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subgroupsSortedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterFilterCondition>
      subgroupsSortedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subgroupsSortedBy',
        value: '',
      ));
    });
  }
}

extension DbGroupPrefsQueryObject
    on QueryBuilder<DbGroupPrefs, DbGroupPrefs, QFilterCondition> {}

extension DbGroupPrefsQueryLinks
    on QueryBuilder<DbGroupPrefs, DbGroupPrefs, QFilterCondition> {}

extension DbGroupPrefsQuerySortBy
    on QueryBuilder<DbGroupPrefs, DbGroupPrefs, QSortBy> {
  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy> sortByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortByEntriesSortedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entriesSortedBy', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortByEntriesSortedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entriesSortedBy', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy> sortByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy> sortByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortByQuickAddReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quickAddReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortByQuickAddReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quickAddReference', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortBySubgroupsDisplayFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupsDisplayFormat', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortBySubgroupsDisplayFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupsDisplayFormat', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortBySubgroupsSortedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupsSortedBy', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      sortBySubgroupsSortedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupsSortedBy', Sort.desc);
    });
  }
}

extension DbGroupPrefsQuerySortThenBy
    on QueryBuilder<DbGroupPrefs, DbGroupPrefs, QSortThenBy> {
  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy> thenByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenByEntriesSortedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entriesSortedBy', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenByEntriesSortedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entriesSortedBy', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy> thenByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy> thenByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenByQuickAddReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quickAddReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenByQuickAddReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quickAddReference', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenBySubgroupsDisplayFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupsDisplayFormat', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenBySubgroupsDisplayFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupsDisplayFormat', Sort.desc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenBySubgroupsSortedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupsSortedBy', Sort.asc);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QAfterSortBy>
      thenBySubgroupsSortedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupsSortedBy', Sort.desc);
    });
  }
}

extension DbGroupPrefsQueryWhereDistinct
    on QueryBuilder<DbGroupPrefs, DbGroupPrefs, QDistinct> {
  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QDistinct>
      distinctByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QDistinct>
      distinctByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QDistinct> distinctByEntriesSortedBy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entriesSortedBy',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QDistinct> distinctByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QDistinct>
      distinctByQuickAddReference({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quickAddReference',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QDistinct>
      distinctBySubgroupsDisplayFormat({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subgroupsDisplayFormat',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroupPrefs, DbGroupPrefs, QDistinct>
      distinctBySubgroupsSortedBy({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subgroupsSortedBy',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbGroupPrefsQueryProperty
    on QueryBuilder<DbGroupPrefs, DbGroupPrefs, QQueryProperty> {
  QueryBuilder<DbGroupPrefs, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbGroupPrefs, int, QQueryOperations> createdAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbGroupPrefs, int, QQueryOperations> editedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbGroupPrefs, String, QQueryOperations>
      entriesSortedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entriesSortedBy');
    });
  }

  QueryBuilder<DbGroupPrefs, String, QQueryOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupId');
    });
  }

  QueryBuilder<DbGroupPrefs, String, QQueryOperations>
      quickAddReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quickAddReference');
    });
  }

  QueryBuilder<DbGroupPrefs, String, QQueryOperations>
      subgroupsDisplayFormatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subgroupsDisplayFormat');
    });
  }

  QueryBuilder<DbGroupPrefs, String, QQueryOperations>
      subgroupsSortedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subgroupsSortedBy');
    });
  }
}
