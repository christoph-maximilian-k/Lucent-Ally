// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_group_to_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbGroupToEntryCollection on Isar {
  IsarCollection<DbGroupToEntry> get dbGroupToEntrys => this.collection();
}

const DbGroupToEntrySchema = CollectionSchema(
  name: r'DbGroupToEntry',
  id: 2804713802916864608,
  properties: {
    r'addedBy': PropertySchema(
      id: 0,
      name: r'addedBy',
      type: IsarType.string,
    ),
    r'createdAtInUtc': PropertySchema(
      id: 1,
      name: r'createdAtInUtc',
      type: IsarType.long,
    ),
    r'entryCreatedAtInUtc': PropertySchema(
      id: 2,
      name: r'entryCreatedAtInUtc',
      type: IsarType.long,
    ),
    r'entryId': PropertySchema(
      id: 3,
      name: r'entryId',
      type: IsarType.string,
    ),
    r'groupId': PropertySchema(
      id: 4,
      name: r'groupId',
      type: IsarType.string,
    ),
    r'groupToEntryId': PropertySchema(
      id: 5,
      name: r'groupToEntryId',
      type: IsarType.string,
    ),
    r'modelEntryReference': PropertySchema(
      id: 6,
      name: r'modelEntryReference',
      type: IsarType.string,
    )
  },
  estimateSize: _dbGroupToEntryEstimateSize,
  serialize: _dbGroupToEntrySerialize,
  deserialize: _dbGroupToEntryDeserialize,
  deserializeProp: _dbGroupToEntryDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'modelEntryReference': IndexSchema(
      id: -5162077637125519852,
      name: r'modelEntryReference',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'modelEntryReference',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
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
    ),
    r'entryId': IndexSchema(
      id: 3733379884318738402,
      name: r'entryId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'entryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAtInUtc': IndexSchema(
      id: 3291605724372131896,
      name: r'createdAtInUtc',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAtInUtc',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'entryCreatedAtInUtc': IndexSchema(
      id: -9155725214861654185,
      name: r'entryCreatedAtInUtc',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'entryCreatedAtInUtc',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'addedBy': IndexSchema(
      id: 3974286479458394488,
      name: r'addedBy',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'addedBy',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dbGroupToEntryGetId,
  getLinks: _dbGroupToEntryGetLinks,
  attach: _dbGroupToEntryAttach,
  version: '3.1.0+1',
);

int _dbGroupToEntryEstimateSize(
  DbGroupToEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.addedBy.length * 3;
  bytesCount += 3 + object.entryId.length * 3;
  bytesCount += 3 + object.groupId.length * 3;
  bytesCount += 3 + object.groupToEntryId.length * 3;
  bytesCount += 3 + object.modelEntryReference.length * 3;
  return bytesCount;
}

void _dbGroupToEntrySerialize(
  DbGroupToEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.addedBy);
  writer.writeLong(offsets[1], object.createdAtInUtc);
  writer.writeLong(offsets[2], object.entryCreatedAtInUtc);
  writer.writeString(offsets[3], object.entryId);
  writer.writeString(offsets[4], object.groupId);
  writer.writeString(offsets[5], object.groupToEntryId);
  writer.writeString(offsets[6], object.modelEntryReference);
}

DbGroupToEntry _dbGroupToEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbGroupToEntry(
    addedBy: reader.readString(offsets[0]),
    createdAtInUtc: reader.readLong(offsets[1]),
    entryCreatedAtInUtc: reader.readLong(offsets[2]),
    entryId: reader.readString(offsets[3]),
    groupId: reader.readString(offsets[4]),
    groupToEntryId: reader.readString(offsets[5]),
    modelEntryReference: reader.readString(offsets[6]),
  );
  return object;
}

P _dbGroupToEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
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

Id _dbGroupToEntryGetId(DbGroupToEntry object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbGroupToEntryGetLinks(DbGroupToEntry object) {
  return [];
}

void _dbGroupToEntryAttach(
    IsarCollection<dynamic> col, Id id, DbGroupToEntry object) {}

extension DbGroupToEntryQueryWhereSort
    on QueryBuilder<DbGroupToEntry, DbGroupToEntry, QWhere> {
  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhere>
      anyCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAtInUtc'),
      );
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhere>
      anyEntryCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'entryCreatedAtInUtc'),
      );
    });
  }
}

extension DbGroupToEntryQueryWhere
    on QueryBuilder<DbGroupToEntry, DbGroupToEntry, QWhereClause> {
  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      modelEntryReferenceEqualTo(String modelEntryReference) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'modelEntryReference',
        value: [modelEntryReference],
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      modelEntryReferenceNotEqualTo(String modelEntryReference) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryReference',
              lower: [],
              upper: [modelEntryReference],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryReference',
              lower: [modelEntryReference],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryReference',
              lower: [modelEntryReference],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryReference',
              lower: [],
              upper: [modelEntryReference],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      groupIdEqualTo(String groupId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'groupId',
        value: [groupId],
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      groupIdNotEqualTo(String groupId) {
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      entryIdEqualTo(String entryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entryId',
        value: [entryId],
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      entryIdNotEqualTo(String entryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryId',
              lower: [],
              upper: [entryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryId',
              lower: [entryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryId',
              lower: [entryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryId',
              lower: [],
              upper: [entryId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      createdAtInUtcEqualTo(int createdAtInUtc) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAtInUtc',
        value: [createdAtInUtc],
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      createdAtInUtcNotEqualTo(int createdAtInUtc) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtInUtc',
              lower: [],
              upper: [createdAtInUtc],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtInUtc',
              lower: [createdAtInUtc],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtInUtc',
              lower: [createdAtInUtc],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtInUtc',
              lower: [],
              upper: [createdAtInUtc],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      createdAtInUtcGreaterThan(
    int createdAtInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtInUtc',
        lower: [createdAtInUtc],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      createdAtInUtcLessThan(
    int createdAtInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtInUtc',
        lower: [],
        upper: [createdAtInUtc],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      createdAtInUtcBetween(
    int lowerCreatedAtInUtc,
    int upperCreatedAtInUtc, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtInUtc',
        lower: [lowerCreatedAtInUtc],
        includeLower: includeLower,
        upper: [upperCreatedAtInUtc],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      entryCreatedAtInUtcEqualTo(int entryCreatedAtInUtc) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entryCreatedAtInUtc',
        value: [entryCreatedAtInUtc],
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      entryCreatedAtInUtcNotEqualTo(int entryCreatedAtInUtc) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryCreatedAtInUtc',
              lower: [],
              upper: [entryCreatedAtInUtc],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryCreatedAtInUtc',
              lower: [entryCreatedAtInUtc],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryCreatedAtInUtc',
              lower: [entryCreatedAtInUtc],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryCreatedAtInUtc',
              lower: [],
              upper: [entryCreatedAtInUtc],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      entryCreatedAtInUtcGreaterThan(
    int entryCreatedAtInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'entryCreatedAtInUtc',
        lower: [entryCreatedAtInUtc],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      entryCreatedAtInUtcLessThan(
    int entryCreatedAtInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'entryCreatedAtInUtc',
        lower: [],
        upper: [entryCreatedAtInUtc],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      entryCreatedAtInUtcBetween(
    int lowerEntryCreatedAtInUtc,
    int upperEntryCreatedAtInUtc, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'entryCreatedAtInUtc',
        lower: [lowerEntryCreatedAtInUtc],
        includeLower: includeLower,
        upper: [upperEntryCreatedAtInUtc],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      addedByEqualTo(String addedBy) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'addedBy',
        value: [addedBy],
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterWhereClause>
      addedByNotEqualTo(String addedBy) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'addedBy',
              lower: [],
              upper: [addedBy],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'addedBy',
              lower: [addedBy],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'addedBy',
              lower: [addedBy],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'addedBy',
              lower: [],
              upper: [addedBy],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbGroupToEntryQueryFilter
    on QueryBuilder<DbGroupToEntry, DbGroupToEntry, QFilterCondition> {
  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'addedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'addedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'addedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'addedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      addedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'addedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      createdAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      entryCreatedAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryCreatedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      entryCreatedAtInUtcGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryCreatedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      entryCreatedAtInUtcLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryCreatedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      entryCreatedAtInUtcBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryCreatedAtInUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      entryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      entryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      entryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      entryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupToEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupToEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupToEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupToEntryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupToEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupToEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupToEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupToEntryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupToEntryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      groupToEntryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupToEntryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
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

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelEntryReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelEntryReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelEntryReference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelEntryReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelEntryReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelEntryReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelEntryReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterFilterCondition>
      modelEntryReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelEntryReference',
        value: '',
      ));
    });
  }
}

extension DbGroupToEntryQueryObject
    on QueryBuilder<DbGroupToEntry, DbGroupToEntry, QFilterCondition> {}

extension DbGroupToEntryQueryLinks
    on QueryBuilder<DbGroupToEntry, DbGroupToEntry, QFilterCondition> {}

extension DbGroupToEntryQuerySortBy
    on QueryBuilder<DbGroupToEntry, DbGroupToEntry, QSortBy> {
  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy> sortByAddedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedBy', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByAddedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedBy', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByEntryCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreatedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByEntryCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreatedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy> sortByEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy> sortByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByGroupToEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupToEntryId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByGroupToEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupToEntryId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByModelEntryReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      sortByModelEntryReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryReference', Sort.desc);
    });
  }
}

extension DbGroupToEntryQuerySortThenBy
    on QueryBuilder<DbGroupToEntry, DbGroupToEntry, QSortThenBy> {
  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy> thenByAddedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedBy', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByAddedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedBy', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByEntryCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreatedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByEntryCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreatedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy> thenByEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy> thenByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByGroupToEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupToEntryId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByGroupToEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupToEntryId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByModelEntryReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QAfterSortBy>
      thenByModelEntryReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryReference', Sort.desc);
    });
  }
}

extension DbGroupToEntryQueryWhereDistinct
    on QueryBuilder<DbGroupToEntry, DbGroupToEntry, QDistinct> {
  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QDistinct> distinctByAddedBy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QDistinct>
      distinctByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QDistinct>
      distinctByEntryCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryCreatedAtInUtc');
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QDistinct> distinctByEntryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QDistinct> distinctByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QDistinct>
      distinctByGroupToEntryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupToEntryId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroupToEntry, DbGroupToEntry, QDistinct>
      distinctByModelEntryReference({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelEntryReference',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbGroupToEntryQueryProperty
    on QueryBuilder<DbGroupToEntry, DbGroupToEntry, QQueryProperty> {
  QueryBuilder<DbGroupToEntry, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbGroupToEntry, String, QQueryOperations> addedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedBy');
    });
  }

  QueryBuilder<DbGroupToEntry, int, QQueryOperations> createdAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbGroupToEntry, int, QQueryOperations>
      entryCreatedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryCreatedAtInUtc');
    });
  }

  QueryBuilder<DbGroupToEntry, String, QQueryOperations> entryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryId');
    });
  }

  QueryBuilder<DbGroupToEntry, String, QQueryOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupId');
    });
  }

  QueryBuilder<DbGroupToEntry, String, QQueryOperations>
      groupToEntryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupToEntryId');
    });
  }

  QueryBuilder<DbGroupToEntry, String, QQueryOperations>
      modelEntryReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelEntryReference');
    });
  }
}
