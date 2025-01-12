// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_participant_to_member.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbParticipantToMemberCollection on Isar {
  IsarCollection<DbParticipantToMember> get dbParticipantToMembers =>
      this.collection();
}

const DbParticipantToMemberSchema = CollectionSchema(
  name: r'DbParticipantToMember',
  id: 1763412772800919479,
  properties: {
    r'addedAtInUtc': PropertySchema(
      id: 0,
      name: r'addedAtInUtc',
      type: IsarType.long,
    ),
    r'addedBy': PropertySchema(
      id: 1,
      name: r'addedBy',
      type: IsarType.string,
    ),
    r'memberId': PropertySchema(
      id: 2,
      name: r'memberId',
      type: IsarType.string,
    ),
    r'participantId': PropertySchema(
      id: 3,
      name: r'participantId',
      type: IsarType.string,
    ),
    r'participantToMemberId': PropertySchema(
      id: 4,
      name: r'participantToMemberId',
      type: IsarType.string,
    )
  },
  estimateSize: _dbParticipantToMemberEstimateSize,
  serialize: _dbParticipantToMemberSerialize,
  deserialize: _dbParticipantToMemberDeserialize,
  deserializeProp: _dbParticipantToMemberDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'participantId': IndexSchema(
      id: -6135301321018090996,
      name: r'participantId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'participantId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'memberId': IndexSchema(
      id: 5707689632932325803,
      name: r'memberId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'memberId',
          type: IndexType.hash,
          caseSensitive: true,
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
  getId: _dbParticipantToMemberGetId,
  getLinks: _dbParticipantToMemberGetLinks,
  attach: _dbParticipantToMemberAttach,
  version: '3.1.0+1',
);

int _dbParticipantToMemberEstimateSize(
  DbParticipantToMember object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.addedBy.length * 3;
  bytesCount += 3 + object.memberId.length * 3;
  bytesCount += 3 + object.participantId.length * 3;
  bytesCount += 3 + object.participantToMemberId.length * 3;
  return bytesCount;
}

void _dbParticipantToMemberSerialize(
  DbParticipantToMember object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.addedAtInUtc);
  writer.writeString(offsets[1], object.addedBy);
  writer.writeString(offsets[2], object.memberId);
  writer.writeString(offsets[3], object.participantId);
  writer.writeString(offsets[4], object.participantToMemberId);
}

DbParticipantToMember _dbParticipantToMemberDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbParticipantToMember(
    addedAtInUtc: reader.readLong(offsets[0]),
    addedBy: reader.readString(offsets[1]),
    memberId: reader.readString(offsets[2]),
    participantId: reader.readString(offsets[3]),
    participantToMemberId: reader.readString(offsets[4]),
  );
  return object;
}

P _dbParticipantToMemberDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbParticipantToMemberGetId(DbParticipantToMember object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbParticipantToMemberGetLinks(
    DbParticipantToMember object) {
  return [];
}

void _dbParticipantToMemberAttach(
    IsarCollection<dynamic> col, Id id, DbParticipantToMember object) {}

extension DbParticipantToMemberQueryWhereSort
    on QueryBuilder<DbParticipantToMember, DbParticipantToMember, QWhere> {
  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DbParticipantToMemberQueryWhere on QueryBuilder<DbParticipantToMember,
    DbParticipantToMember, QWhereClause> {
  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
      isarIdBetween(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
      participantIdEqualTo(String participantId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'participantId',
        value: [participantId],
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
      participantIdNotEqualTo(String participantId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantId',
              lower: [],
              upper: [participantId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantId',
              lower: [participantId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantId',
              lower: [participantId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantId',
              lower: [],
              upper: [participantId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
      memberIdEqualTo(String memberId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'memberId',
        value: [memberId],
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
      memberIdNotEqualTo(String memberId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberId',
              lower: [],
              upper: [memberId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberId',
              lower: [memberId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberId',
              lower: [memberId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberId',
              lower: [],
              upper: [memberId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
      addedByEqualTo(String addedBy) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'addedBy',
        value: [addedBy],
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterWhereClause>
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

extension DbParticipantToMemberQueryFilter on QueryBuilder<
    DbParticipantToMember, DbParticipantToMember, QFilterCondition> {
  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedAtInUtcGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedAtInUtcLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedAtInUtcBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedAtInUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedByEqualTo(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedByGreaterThan(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedByLessThan(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedByBetween(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedByStartsWith(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedByEndsWith(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
          QAfterFilterCondition>
      addedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'addedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
          QAfterFilterCondition>
      addedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'addedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> addedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'addedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> memberIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> memberIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> memberIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> memberIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memberId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> memberIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> memberIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
          QAfterFilterCondition>
      memberIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
          QAfterFilterCondition>
      memberIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memberId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> memberIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> memberIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'participantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'participantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'participantId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'participantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'participantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
          QAfterFilterCondition>
      participantIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'participantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
          QAfterFilterCondition>
      participantIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'participantId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'participantId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantToMemberIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantToMemberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantToMemberIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'participantToMemberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantToMemberIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'participantToMemberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantToMemberIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'participantToMemberId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantToMemberIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'participantToMemberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantToMemberIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'participantToMemberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
          QAfterFilterCondition>
      participantToMemberIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'participantToMemberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
          QAfterFilterCondition>
      participantToMemberIdMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'participantToMemberId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantToMemberIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantToMemberId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember,
      QAfterFilterCondition> participantToMemberIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'participantToMemberId',
        value: '',
      ));
    });
  }
}

extension DbParticipantToMemberQueryObject on QueryBuilder<
    DbParticipantToMember, DbParticipantToMember, QFilterCondition> {}

extension DbParticipantToMemberQueryLinks on QueryBuilder<DbParticipantToMember,
    DbParticipantToMember, QFilterCondition> {}

extension DbParticipantToMemberQuerySortBy
    on QueryBuilder<DbParticipantToMember, DbParticipantToMember, QSortBy> {
  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByAddedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByAddedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByAddedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedBy', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByAddedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedBy', Sort.desc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByParticipantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByParticipantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantId', Sort.desc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByParticipantToMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantToMemberId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      sortByParticipantToMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantToMemberId', Sort.desc);
    });
  }
}

extension DbParticipantToMemberQuerySortThenBy
    on QueryBuilder<DbParticipantToMember, DbParticipantToMember, QSortThenBy> {
  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByAddedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByAddedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByAddedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedBy', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByAddedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedBy', Sort.desc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByParticipantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByParticipantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantId', Sort.desc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByParticipantToMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantToMemberId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QAfterSortBy>
      thenByParticipantToMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantToMemberId', Sort.desc);
    });
  }
}

extension DbParticipantToMemberQueryWhereDistinct
    on QueryBuilder<DbParticipantToMember, DbParticipantToMember, QDistinct> {
  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QDistinct>
      distinctByAddedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedAtInUtc');
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QDistinct>
      distinctByAddedBy({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QDistinct>
      distinctByMemberId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QDistinct>
      distinctByParticipantId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'participantId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbParticipantToMember, DbParticipantToMember, QDistinct>
      distinctByParticipantToMemberId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'participantToMemberId',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbParticipantToMemberQueryProperty on QueryBuilder<
    DbParticipantToMember, DbParticipantToMember, QQueryProperty> {
  QueryBuilder<DbParticipantToMember, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbParticipantToMember, int, QQueryOperations>
      addedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedAtInUtc');
    });
  }

  QueryBuilder<DbParticipantToMember, String, QQueryOperations>
      addedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedBy');
    });
  }

  QueryBuilder<DbParticipantToMember, String, QQueryOperations>
      memberIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberId');
    });
  }

  QueryBuilder<DbParticipantToMember, String, QQueryOperations>
      participantIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'participantId');
    });
  }

  QueryBuilder<DbParticipantToMember, String, QQueryOperations>
      participantToMemberIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'participantToMemberId');
    });
  }
}
