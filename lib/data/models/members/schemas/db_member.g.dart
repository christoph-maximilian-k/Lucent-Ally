// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_member.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbMemberCollection on Isar {
  IsarCollection<DbMember> get dbMembers => this.collection();
}

const DbMemberSchema = CollectionSchema(
  name: r'DbMember',
  id: -3585558112230575978,
  properties: {
    r'createdAtInUtc': PropertySchema(
      id: 0,
      name: r'createdAtInUtc',
      type: IsarType.long,
    ),
    r'creator': PropertySchema(
      id: 1,
      name: r'creator',
      type: IsarType.string,
    ),
    r'editedAtInUtc': PropertySchema(
      id: 2,
      name: r'editedAtInUtc',
      type: IsarType.long,
    ),
    r'memberId': PropertySchema(
      id: 3,
      name: r'memberId',
      type: IsarType.string,
    ),
    r'memberName': PropertySchema(
      id: 4,
      name: r'memberName',
      type: IsarType.string,
    ),
    r'memberType': PropertySchema(
      id: 5,
      name: r'memberType',
      type: IsarType.string,
    )
  },
  estimateSize: _dbMemberEstimateSize,
  serialize: _dbMemberSerialize,
  deserialize: _dbMemberDeserialize,
  deserializeProp: _dbMemberDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'memberType': IndexSchema(
      id: -1991231428006634670,
      name: r'memberType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'memberType',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'memberName': IndexSchema(
      id: -6834322328190846064,
      name: r'memberName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'memberName',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dbMemberGetId,
  getLinks: _dbMemberGetLinks,
  attach: _dbMemberAttach,
  version: '3.1.0+1',
);

int _dbMemberEstimateSize(
  DbMember object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.creator.length * 3;
  bytesCount += 3 + object.memberId.length * 3;
  bytesCount += 3 + object.memberName.length * 3;
  bytesCount += 3 + object.memberType.length * 3;
  return bytesCount;
}

void _dbMemberSerialize(
  DbMember object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdAtInUtc);
  writer.writeString(offsets[1], object.creator);
  writer.writeLong(offsets[2], object.editedAtInUtc);
  writer.writeString(offsets[3], object.memberId);
  writer.writeString(offsets[4], object.memberName);
  writer.writeString(offsets[5], object.memberType);
}

DbMember _dbMemberDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbMember(
    createdAtInUtc: reader.readLong(offsets[0]),
    creator: reader.readString(offsets[1]),
    editedAtInUtc: reader.readLong(offsets[2]),
    memberId: reader.readString(offsets[3]),
    memberName: reader.readString(offsets[4]),
    memberType: reader.readString(offsets[5]),
  );
  return object;
}

P _dbMemberDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbMemberGetId(DbMember object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbMemberGetLinks(DbMember object) {
  return [];
}

void _dbMemberAttach(IsarCollection<dynamic> col, Id id, DbMember object) {}

extension DbMemberQueryWhereSort on QueryBuilder<DbMember, DbMember, QWhere> {
  QueryBuilder<DbMember, DbMember, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DbMemberQueryWhere on QueryBuilder<DbMember, DbMember, QWhereClause> {
  QueryBuilder<DbMember, DbMember, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<DbMember, DbMember, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DbMember, DbMember, QAfterWhereClause> memberTypeEqualTo(
      String memberType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'memberType',
        value: [memberType],
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterWhereClause> memberTypeNotEqualTo(
      String memberType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberType',
              lower: [],
              upper: [memberType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberType',
              lower: [memberType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberType',
              lower: [memberType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberType',
              lower: [],
              upper: [memberType],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterWhereClause> memberNameEqualTo(
      String memberName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'memberName',
        value: [memberName],
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterWhereClause> memberNameNotEqualTo(
      String memberName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberName',
              lower: [],
              upper: [memberName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberName',
              lower: [memberName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberName',
              lower: [memberName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberName',
              lower: [],
              upper: [memberName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbMemberQueryFilter
    on QueryBuilder<DbMember, DbMember, QFilterCondition> {
  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> createdAtInUtcEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition>
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition>
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> createdAtInUtcBetween(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> creatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> editedAtInUtcEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition>
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> editedAtInUtcLessThan(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> editedAtInUtcBetween(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdEqualTo(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdGreaterThan(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdLessThan(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdBetween(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdStartsWith(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdEndsWith(
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

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memberId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memberName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memberName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memberName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'memberName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'memberName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memberName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memberName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition>
      memberNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memberName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memberType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memberType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memberType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'memberType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'memberType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memberType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memberType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition> memberTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberType',
        value: '',
      ));
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterFilterCondition>
      memberTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memberType',
        value: '',
      ));
    });
  }
}

extension DbMemberQueryObject
    on QueryBuilder<DbMember, DbMember, QFilterCondition> {}

extension DbMemberQueryLinks
    on QueryBuilder<DbMember, DbMember, QFilterCondition> {}

extension DbMemberQuerySortBy on QueryBuilder<DbMember, DbMember, QSortBy> {
  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByMemberName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberName', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByMemberNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberName', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByMemberType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberType', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> sortByMemberTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberType', Sort.desc);
    });
  }
}

extension DbMemberQuerySortThenBy
    on QueryBuilder<DbMember, DbMember, QSortThenBy> {
  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByMemberName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberName', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByMemberNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberName', Sort.desc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByMemberType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberType', Sort.asc);
    });
  }

  QueryBuilder<DbMember, DbMember, QAfterSortBy> thenByMemberTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberType', Sort.desc);
    });
  }
}

extension DbMemberQueryWhereDistinct
    on QueryBuilder<DbMember, DbMember, QDistinct> {
  QueryBuilder<DbMember, DbMember, QDistinct> distinctByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbMember, DbMember, QDistinct> distinctByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creator', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbMember, DbMember, QDistinct> distinctByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbMember, DbMember, QDistinct> distinctByMemberId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbMember, DbMember, QDistinct> distinctByMemberName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbMember, DbMember, QDistinct> distinctByMemberType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberType', caseSensitive: caseSensitive);
    });
  }
}

extension DbMemberQueryProperty
    on QueryBuilder<DbMember, DbMember, QQueryProperty> {
  QueryBuilder<DbMember, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbMember, int, QQueryOperations> createdAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbMember, String, QQueryOperations> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creator');
    });
  }

  QueryBuilder<DbMember, int, QQueryOperations> editedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbMember, String, QQueryOperations> memberIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberId');
    });
  }

  QueryBuilder<DbMember, String, QQueryOperations> memberNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberName');
    });
  }

  QueryBuilder<DbMember, String, QQueryOperations> memberTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberType');
    });
  }
}
