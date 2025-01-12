// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_recent_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbRecentEntryCollection on Isar {
  IsarCollection<DbRecentEntry> get dbRecentEntrys => this.collection();
}

const DbRecentEntrySchema = CollectionSchema(
  name: r'DbRecentEntry',
  id: -7460789770119869491,
  properties: {
    r'entryId': PropertySchema(
      id: 0,
      name: r'entryId',
      type: IsarType.string,
    ),
    r'groupReference': PropertySchema(
      id: 1,
      name: r'groupReference',
      type: IsarType.string,
    ),
    r'interactedAtInUtc': PropertySchema(
      id: 2,
      name: r'interactedAtInUtc',
      type: IsarType.long,
    ),
    r'rootGroupReference': PropertySchema(
      id: 3,
      name: r'rootGroupReference',
      type: IsarType.string,
    )
  },
  estimateSize: _dbRecentEntryEstimateSize,
  serialize: _dbRecentEntrySerialize,
  deserialize: _dbRecentEntryDeserialize,
  deserializeProp: _dbRecentEntryDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'rootGroupReference': IndexSchema(
      id: 3928529767512197246,
      name: r'rootGroupReference',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'rootGroupReference',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'groupReference': IndexSchema(
      id: -4105656780609847444,
      name: r'groupReference',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'groupReference',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'interactedAtInUtc': IndexSchema(
      id: -6745132579444203324,
      name: r'interactedAtInUtc',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'interactedAtInUtc',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dbRecentEntryGetId,
  getLinks: _dbRecentEntryGetLinks,
  attach: _dbRecentEntryAttach,
  version: '3.1.0+1',
);

int _dbRecentEntryEstimateSize(
  DbRecentEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.entryId.length * 3;
  bytesCount += 3 + object.groupReference.length * 3;
  bytesCount += 3 + object.rootGroupReference.length * 3;
  return bytesCount;
}

void _dbRecentEntrySerialize(
  DbRecentEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.entryId);
  writer.writeString(offsets[1], object.groupReference);
  writer.writeLong(offsets[2], object.interactedAtInUtc);
  writer.writeString(offsets[3], object.rootGroupReference);
}

DbRecentEntry _dbRecentEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbRecentEntry(
    entryId: reader.readString(offsets[0]),
    groupReference: reader.readString(offsets[1]),
    interactedAtInUtc: reader.readLong(offsets[2]),
    rootGroupReference: reader.readString(offsets[3]),
  );
  return object;
}

P _dbRecentEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbRecentEntryGetId(DbRecentEntry object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbRecentEntryGetLinks(DbRecentEntry object) {
  return [];
}

void _dbRecentEntryAttach(
    IsarCollection<dynamic> col, Id id, DbRecentEntry object) {}

extension DbRecentEntryQueryWhereSort
    on QueryBuilder<DbRecentEntry, DbRecentEntry, QWhere> {
  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhere>
      anyInteractedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'interactedAtInUtc'),
      );
    });
  }
}

extension DbRecentEntryQueryWhere
    on QueryBuilder<DbRecentEntry, DbRecentEntry, QWhereClause> {
  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
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

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      rootGroupReferenceEqualTo(String rootGroupReference) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rootGroupReference',
        value: [rootGroupReference],
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      rootGroupReferenceNotEqualTo(String rootGroupReference) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rootGroupReference',
              lower: [],
              upper: [rootGroupReference],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rootGroupReference',
              lower: [rootGroupReference],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rootGroupReference',
              lower: [rootGroupReference],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rootGroupReference',
              lower: [],
              upper: [rootGroupReference],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      groupReferenceEqualTo(String groupReference) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'groupReference',
        value: [groupReference],
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      groupReferenceNotEqualTo(String groupReference) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupReference',
              lower: [],
              upper: [groupReference],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupReference',
              lower: [groupReference],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupReference',
              lower: [groupReference],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupReference',
              lower: [],
              upper: [groupReference],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      interactedAtInUtcEqualTo(int interactedAtInUtc) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'interactedAtInUtc',
        value: [interactedAtInUtc],
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      interactedAtInUtcNotEqualTo(int interactedAtInUtc) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'interactedAtInUtc',
              lower: [],
              upper: [interactedAtInUtc],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'interactedAtInUtc',
              lower: [interactedAtInUtc],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'interactedAtInUtc',
              lower: [interactedAtInUtc],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'interactedAtInUtc',
              lower: [],
              upper: [interactedAtInUtc],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      interactedAtInUtcGreaterThan(
    int interactedAtInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'interactedAtInUtc',
        lower: [interactedAtInUtc],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      interactedAtInUtcLessThan(
    int interactedAtInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'interactedAtInUtc',
        lower: [],
        upper: [interactedAtInUtc],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterWhereClause>
      interactedAtInUtcBetween(
    int lowerInteractedAtInUtc,
    int upperInteractedAtInUtc, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'interactedAtInUtc',
        lower: [lowerInteractedAtInUtc],
        includeLower: includeLower,
        upper: [upperInteractedAtInUtc],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DbRecentEntryQueryFilter
    on QueryBuilder<DbRecentEntry, DbRecentEntry, QFilterCondition> {
  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      entryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupReference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      groupReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      interactedAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interactedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      interactedAtInUtcGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interactedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      interactedAtInUtcLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interactedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      interactedAtInUtcBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interactedAtInUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
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

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
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

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
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

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rootGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rootGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rootGroupReference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rootGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rootGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rootGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rootGroupReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootGroupReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterFilterCondition>
      rootGroupReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rootGroupReference',
        value: '',
      ));
    });
  }
}

extension DbRecentEntryQueryObject
    on QueryBuilder<DbRecentEntry, DbRecentEntry, QFilterCondition> {}

extension DbRecentEntryQueryLinks
    on QueryBuilder<DbRecentEntry, DbRecentEntry, QFilterCondition> {}

extension DbRecentEntryQuerySortBy
    on QueryBuilder<DbRecentEntry, DbRecentEntry, QSortBy> {
  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy> sortByEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.asc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy> sortByEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.desc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      sortByGroupReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupReference', Sort.asc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      sortByGroupReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupReference', Sort.desc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      sortByInteractedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interactedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      sortByInteractedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interactedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      sortByRootGroupReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootGroupReference', Sort.asc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      sortByRootGroupReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootGroupReference', Sort.desc);
    });
  }
}

extension DbRecentEntryQuerySortThenBy
    on QueryBuilder<DbRecentEntry, DbRecentEntry, QSortThenBy> {
  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy> thenByEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.asc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy> thenByEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.desc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      thenByGroupReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupReference', Sort.asc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      thenByGroupReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupReference', Sort.desc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      thenByInteractedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interactedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      thenByInteractedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interactedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      thenByRootGroupReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootGroupReference', Sort.asc);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QAfterSortBy>
      thenByRootGroupReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootGroupReference', Sort.desc);
    });
  }
}

extension DbRecentEntryQueryWhereDistinct
    on QueryBuilder<DbRecentEntry, DbRecentEntry, QDistinct> {
  QueryBuilder<DbRecentEntry, DbRecentEntry, QDistinct> distinctByEntryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QDistinct>
      distinctByGroupReference({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupReference',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QDistinct>
      distinctByInteractedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interactedAtInUtc');
    });
  }

  QueryBuilder<DbRecentEntry, DbRecentEntry, QDistinct>
      distinctByRootGroupReference({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rootGroupReference',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbRecentEntryQueryProperty
    on QueryBuilder<DbRecentEntry, DbRecentEntry, QQueryProperty> {
  QueryBuilder<DbRecentEntry, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbRecentEntry, String, QQueryOperations> entryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryId');
    });
  }

  QueryBuilder<DbRecentEntry, String, QQueryOperations>
      groupReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupReference');
    });
  }

  QueryBuilder<DbRecentEntry, int, QQueryOperations>
      interactedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interactedAtInUtc');
    });
  }

  QueryBuilder<DbRecentEntry, String, QQueryOperations>
      rootGroupReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rootGroupReference');
    });
  }
}
