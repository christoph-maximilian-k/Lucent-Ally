// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_group.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbGroupCollection on Isar {
  IsarCollection<DbGroup> get dbGroups => this.collection();
}

const DbGroupSchema = CollectionSchema(
  name: r'DbGroup',
  id: -2785047984943221735,
  properties: {
    r'commonModelEntries': PropertySchema(
      id: 0,
      name: r'commonModelEntries',
      type: IsarType.stringList,
    ),
    r'createdAtInUtc': PropertySchema(
      id: 1,
      name: r'createdAtInUtc',
      type: IsarType.long,
    ),
    r'defaultCurrencyCode': PropertySchema(
      id: 2,
      name: r'defaultCurrencyCode',
      type: IsarType.string,
    ),
    r'editedAtInUtc': PropertySchema(
      id: 3,
      name: r'editedAtInUtc',
      type: IsarType.long,
    ),
    r'groupCreator': PropertySchema(
      id: 4,
      name: r'groupCreator',
      type: IsarType.string,
    ),
    r'groupDescription': PropertySchema(
      id: 5,
      name: r'groupDescription',
      type: IsarType.string,
    ),
    r'groupId': PropertySchema(
      id: 6,
      name: r'groupId',
      type: IsarType.string,
    ),
    r'groupName': PropertySchema(
      id: 7,
      name: r'groupName',
      type: IsarType.string,
    ),
    r'groupType': PropertySchema(
      id: 8,
      name: r'groupType',
      type: IsarType.string,
    ),
    r'isEncrypted': PropertySchema(
      id: 9,
      name: r'isEncrypted',
      type: IsarType.bool,
    ),
    r'isLocked': PropertySchema(
      id: 10,
      name: r'isLocked',
      type: IsarType.bool,
    ),
    r'isProtected': PropertySchema(
      id: 11,
      name: r'isProtected',
      type: IsarType.bool,
    ),
    r'isRestrictedToCommon': PropertySchema(
      id: 12,
      name: r'isRestrictedToCommon',
      type: IsarType.bool,
    ),
    r'parentGroupReference': PropertySchema(
      id: 13,
      name: r'parentGroupReference',
      type: IsarType.string,
    ),
    r'participantReference': PropertySchema(
      id: 14,
      name: r'participantReference',
      type: IsarType.string,
    ),
    r'rootGroupReference': PropertySchema(
      id: 15,
      name: r'rootGroupReference',
      type: IsarType.string,
    )
  },
  estimateSize: _dbGroupEstimateSize,
  serialize: _dbGroupSerialize,
  deserialize: _dbGroupDeserialize,
  deserializeProp: _dbGroupDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'groupId': IndexSchema(
      id: -8523216633229774932,
      name: r'groupId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'groupId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'groupType': IndexSchema(
      id: -4322165125072475132,
      name: r'groupType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'groupType',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isProtected': IndexSchema(
      id: 3159344841097758515,
      name: r'isProtected',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isProtected',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isEncrypted': IndexSchema(
      id: 4865455266577443787,
      name: r'isEncrypted',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isEncrypted',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'groupName': IndexSchema(
      id: -6302961014654519938,
      name: r'groupName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'groupName',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
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
    r'parentGroupReference': IndexSchema(
      id: -4400075017562765943,
      name: r'parentGroupReference',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'parentGroupReference',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'participantReference': IndexSchema(
      id: 2505365090624054336,
      name: r'participantReference',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'participantReference',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dbGroupGetId,
  getLinks: _dbGroupGetLinks,
  attach: _dbGroupAttach,
  version: '3.1.0+1',
);

int _dbGroupEstimateSize(
  DbGroup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.commonModelEntries.length * 3;
  {
    for (var i = 0; i < object.commonModelEntries.length; i++) {
      final value = object.commonModelEntries[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.defaultCurrencyCode.length * 3;
  bytesCount += 3 + object.groupCreator.length * 3;
  bytesCount += 3 + object.groupDescription.length * 3;
  bytesCount += 3 + object.groupId.length * 3;
  bytesCount += 3 + object.groupName.length * 3;
  bytesCount += 3 + object.groupType.length * 3;
  bytesCount += 3 + object.parentGroupReference.length * 3;
  bytesCount += 3 + object.participantReference.length * 3;
  bytesCount += 3 + object.rootGroupReference.length * 3;
  return bytesCount;
}

void _dbGroupSerialize(
  DbGroup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.commonModelEntries);
  writer.writeLong(offsets[1], object.createdAtInUtc);
  writer.writeString(offsets[2], object.defaultCurrencyCode);
  writer.writeLong(offsets[3], object.editedAtInUtc);
  writer.writeString(offsets[4], object.groupCreator);
  writer.writeString(offsets[5], object.groupDescription);
  writer.writeString(offsets[6], object.groupId);
  writer.writeString(offsets[7], object.groupName);
  writer.writeString(offsets[8], object.groupType);
  writer.writeBool(offsets[9], object.isEncrypted);
  writer.writeBool(offsets[10], object.isLocked);
  writer.writeBool(offsets[11], object.isProtected);
  writer.writeBool(offsets[12], object.isRestrictedToCommon);
  writer.writeString(offsets[13], object.parentGroupReference);
  writer.writeString(offsets[14], object.participantReference);
  writer.writeString(offsets[15], object.rootGroupReference);
}

DbGroup _dbGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbGroup(
    commonModelEntries: reader.readStringList(offsets[0]) ?? [],
    createdAtInUtc: reader.readLong(offsets[1]),
    defaultCurrencyCode: reader.readString(offsets[2]),
    editedAtInUtc: reader.readLong(offsets[3]),
    groupCreator: reader.readString(offsets[4]),
    groupDescription: reader.readString(offsets[5]),
    groupId: reader.readString(offsets[6]),
    groupName: reader.readString(offsets[7]),
    groupType: reader.readString(offsets[8]),
    isEncrypted: reader.readBool(offsets[9]),
    isLocked: reader.readBool(offsets[10]),
    isProtected: reader.readBool(offsets[11]),
    isRestrictedToCommon: reader.readBool(offsets[12]),
    parentGroupReference: reader.readString(offsets[13]),
    participantReference: reader.readString(offsets[14]),
    rootGroupReference: reader.readString(offsets[15]),
  );
  return object;
}

P _dbGroupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbGroupGetId(DbGroup object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbGroupGetLinks(DbGroup object) {
  return [];
}

void _dbGroupAttach(IsarCollection<dynamic> col, Id id, DbGroup object) {}

extension DbGroupByIndex on IsarCollection<DbGroup> {
  Future<DbGroup?> getByGroupId(String groupId) {
    return getByIndex(r'groupId', [groupId]);
  }

  DbGroup? getByGroupIdSync(String groupId) {
    return getByIndexSync(r'groupId', [groupId]);
  }

  Future<bool> deleteByGroupId(String groupId) {
    return deleteByIndex(r'groupId', [groupId]);
  }

  bool deleteByGroupIdSync(String groupId) {
    return deleteByIndexSync(r'groupId', [groupId]);
  }

  Future<List<DbGroup?>> getAllByGroupId(List<String> groupIdValues) {
    final values = groupIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'groupId', values);
  }

  List<DbGroup?> getAllByGroupIdSync(List<String> groupIdValues) {
    final values = groupIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'groupId', values);
  }

  Future<int> deleteAllByGroupId(List<String> groupIdValues) {
    final values = groupIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'groupId', values);
  }

  int deleteAllByGroupIdSync(List<String> groupIdValues) {
    final values = groupIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'groupId', values);
  }

  Future<Id> putByGroupId(DbGroup object) {
    return putByIndex(r'groupId', object);
  }

  Id putByGroupIdSync(DbGroup object, {bool saveLinks = true}) {
    return putByIndexSync(r'groupId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByGroupId(List<DbGroup> objects) {
    return putAllByIndex(r'groupId', objects);
  }

  List<Id> putAllByGroupIdSync(List<DbGroup> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'groupId', objects, saveLinks: saveLinks);
  }
}

extension DbGroupQueryWhereSort on QueryBuilder<DbGroup, DbGroup, QWhere> {
  QueryBuilder<DbGroup, DbGroup, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhere> anyIsProtected() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isProtected'),
      );
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhere> anyIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isEncrypted'),
      );
    });
  }
}

extension DbGroupQueryWhere on QueryBuilder<DbGroup, DbGroup, QWhereClause> {
  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> groupIdEqualTo(
      String groupId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'groupId',
        value: [groupId],
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> groupIdNotEqualTo(
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

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> groupTypeEqualTo(
      String groupType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'groupType',
        value: [groupType],
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> groupTypeNotEqualTo(
      String groupType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupType',
              lower: [],
              upper: [groupType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupType',
              lower: [groupType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupType',
              lower: [groupType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupType',
              lower: [],
              upper: [groupType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> isProtectedEqualTo(
      bool isProtected) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isProtected',
        value: [isProtected],
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> isProtectedNotEqualTo(
      bool isProtected) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isProtected',
              lower: [],
              upper: [isProtected],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isProtected',
              lower: [isProtected],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isProtected',
              lower: [isProtected],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isProtected',
              lower: [],
              upper: [isProtected],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> isEncryptedEqualTo(
      bool isEncrypted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isEncrypted',
        value: [isEncrypted],
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> isEncryptedNotEqualTo(
      bool isEncrypted) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEncrypted',
              lower: [],
              upper: [isEncrypted],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEncrypted',
              lower: [isEncrypted],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEncrypted',
              lower: [isEncrypted],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isEncrypted',
              lower: [],
              upper: [isEncrypted],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> groupNameEqualTo(
      String groupName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'groupName',
        value: [groupName],
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> groupNameNotEqualTo(
      String groupName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupName',
              lower: [],
              upper: [groupName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupName',
              lower: [groupName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupName',
              lower: [groupName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'groupName',
              lower: [],
              upper: [groupName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> rootGroupReferenceEqualTo(
      String rootGroupReference) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rootGroupReference',
        value: [rootGroupReference],
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause>
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

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> parentGroupReferenceEqualTo(
      String parentGroupReference) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'parentGroupReference',
        value: [parentGroupReference],
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause>
      parentGroupReferenceNotEqualTo(String parentGroupReference) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentGroupReference',
              lower: [],
              upper: [parentGroupReference],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentGroupReference',
              lower: [parentGroupReference],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentGroupReference',
              lower: [parentGroupReference],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentGroupReference',
              lower: [],
              upper: [parentGroupReference],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause> participantReferenceEqualTo(
      String participantReference) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'participantReference',
        value: [participantReference],
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterWhereClause>
      participantReferenceNotEqualTo(String participantReference) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantReference',
              lower: [],
              upper: [participantReference],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantReference',
              lower: [participantReference],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantReference',
              lower: [participantReference],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantReference',
              lower: [],
              upper: [participantReference],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbGroupQueryFilter
    on QueryBuilder<DbGroup, DbGroup, QFilterCondition> {
  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonModelEntries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commonModelEntries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commonModelEntries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commonModelEntries',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commonModelEntries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commonModelEntries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commonModelEntries',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commonModelEntries',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonModelEntries',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commonModelEntries',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonModelEntries',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonModelEntries',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonModelEntries',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonModelEntries',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonModelEntries',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      commonModelEntriesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonModelEntries',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> createdAtInUtcEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> createdAtInUtcLessThan(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> createdAtInUtcBetween(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultCurrencyCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultCurrencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultCurrencyCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultCurrencyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      defaultCurrencyCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultCurrencyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> editedAtInUtcEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> editedAtInUtcLessThan(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> editedAtInUtcBetween(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupCreatorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupCreatorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupCreatorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupCreatorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupCreator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupCreatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupCreatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupCreatorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupCreatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupCreator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupCreatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      groupCreatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupDescriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      groupDescriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      groupDescriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupDescriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      groupDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      groupDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      groupDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupDescriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      groupDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      groupDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdEqualTo(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdGreaterThan(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdLessThan(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdBetween(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdStartsWith(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdEndsWith(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupType',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> groupTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupType',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> isEncryptedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEncrypted',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> isLockedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLocked',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> isProtectedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isProtected',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      isRestrictedToCommonEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRestrictedToCommon',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentGroupReference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentGroupReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentGroupReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      parentGroupReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentGroupReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'participantReference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'participantReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      participantReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'participantReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
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

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      rootGroupReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rootGroupReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      rootGroupReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rootGroupReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      rootGroupReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rootGroupReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterFilterCondition>
      rootGroupReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rootGroupReference',
        value: '',
      ));
    });
  }
}

extension DbGroupQueryObject
    on QueryBuilder<DbGroup, DbGroup, QFilterCondition> {}

extension DbGroupQueryLinks
    on QueryBuilder<DbGroup, DbGroup, QFilterCondition> {}

extension DbGroupQuerySortBy on QueryBuilder<DbGroup, DbGroup, QSortBy> {
  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByDefaultCurrencyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultCurrencyCode', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByDefaultCurrencyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultCurrencyCode', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupCreator', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupCreator', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupDescription', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupDescription', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupName', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupName', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupType', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByGroupTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupType', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByIsEncryptedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByIsLocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocked', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByIsLockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocked', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByIsProtected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProtected', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByIsProtectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProtected', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByIsRestrictedToCommon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestrictedToCommon', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy>
      sortByIsRestrictedToCommonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestrictedToCommon', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByParentGroupReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentGroupReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy>
      sortByParentGroupReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentGroupReference', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByParticipantReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy>
      sortByParticipantReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantReference', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByRootGroupReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootGroupReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> sortByRootGroupReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootGroupReference', Sort.desc);
    });
  }
}

extension DbGroupQuerySortThenBy
    on QueryBuilder<DbGroup, DbGroup, QSortThenBy> {
  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByDefaultCurrencyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultCurrencyCode', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByDefaultCurrencyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultCurrencyCode', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupCreator', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupCreator', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupDescription', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupDescription', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupName', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupName', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupType', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByGroupTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupType', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByIsEncryptedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByIsLocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocked', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByIsLockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocked', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByIsProtected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProtected', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByIsProtectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProtected', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByIsRestrictedToCommon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestrictedToCommon', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy>
      thenByIsRestrictedToCommonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRestrictedToCommon', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByParentGroupReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentGroupReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy>
      thenByParentGroupReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentGroupReference', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByParticipantReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy>
      thenByParticipantReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantReference', Sort.desc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByRootGroupReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootGroupReference', Sort.asc);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QAfterSortBy> thenByRootGroupReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rootGroupReference', Sort.desc);
    });
  }
}

extension DbGroupQueryWhereDistinct
    on QueryBuilder<DbGroup, DbGroup, QDistinct> {
  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByCommonModelEntries() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commonModelEntries');
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByDefaultCurrencyCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultCurrencyCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByGroupCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupCreator', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByGroupDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByGroupName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByGroupType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEncrypted');
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByIsLocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLocked');
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByIsProtected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isProtected');
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByIsRestrictedToCommon() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRestrictedToCommon');
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByParentGroupReference(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentGroupReference',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByParticipantReference(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'participantReference',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbGroup, DbGroup, QDistinct> distinctByRootGroupReference(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rootGroupReference',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbGroupQueryProperty
    on QueryBuilder<DbGroup, DbGroup, QQueryProperty> {
  QueryBuilder<DbGroup, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbGroup, List<String>, QQueryOperations>
      commonModelEntriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commonModelEntries');
    });
  }

  QueryBuilder<DbGroup, int, QQueryOperations> createdAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbGroup, String, QQueryOperations>
      defaultCurrencyCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultCurrencyCode');
    });
  }

  QueryBuilder<DbGroup, int, QQueryOperations> editedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbGroup, String, QQueryOperations> groupCreatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupCreator');
    });
  }

  QueryBuilder<DbGroup, String, QQueryOperations> groupDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupDescription');
    });
  }

  QueryBuilder<DbGroup, String, QQueryOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupId');
    });
  }

  QueryBuilder<DbGroup, String, QQueryOperations> groupNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupName');
    });
  }

  QueryBuilder<DbGroup, String, QQueryOperations> groupTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupType');
    });
  }

  QueryBuilder<DbGroup, bool, QQueryOperations> isEncryptedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEncrypted');
    });
  }

  QueryBuilder<DbGroup, bool, QQueryOperations> isLockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLocked');
    });
  }

  QueryBuilder<DbGroup, bool, QQueryOperations> isProtectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isProtected');
    });
  }

  QueryBuilder<DbGroup, bool, QQueryOperations> isRestrictedToCommonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRestrictedToCommon');
    });
  }

  QueryBuilder<DbGroup, String, QQueryOperations>
      parentGroupReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentGroupReference');
    });
  }

  QueryBuilder<DbGroup, String, QQueryOperations>
      participantReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'participantReference');
    });
  }

  QueryBuilder<DbGroup, String, QQueryOperations> rootGroupReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rootGroupReference');
    });
  }
}
