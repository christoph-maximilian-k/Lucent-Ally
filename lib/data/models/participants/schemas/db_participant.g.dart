// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_participant.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbParticipantCollection on Isar {
  IsarCollection<DbParticipant> get dbParticipants => this.collection();
}

const DbParticipantSchema = CollectionSchema(
  name: r'DbParticipant',
  id: -199804182901934954,
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
    r'participantCreator': PropertySchema(
      id: 2,
      name: r'participantCreator',
      type: IsarType.string,
    ),
    r'participantId': PropertySchema(
      id: 3,
      name: r'participantId',
      type: IsarType.string,
    ),
    r'participantName': PropertySchema(
      id: 4,
      name: r'participantName',
      type: IsarType.string,
    )
  },
  estimateSize: _dbParticipantEstimateSize,
  serialize: _dbParticipantSerialize,
  deserialize: _dbParticipantDeserialize,
  deserializeProp: _dbParticipantDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'participantName': IndexSchema(
      id: -9197690718600844525,
      name: r'participantName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'participantName',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    ),
    r'participantCreator': IndexSchema(
      id: 2105192534243357243,
      name: r'participantCreator',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'participantCreator',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dbParticipantGetId,
  getLinks: _dbParticipantGetLinks,
  attach: _dbParticipantAttach,
  version: '3.1.0+1',
);

int _dbParticipantEstimateSize(
  DbParticipant object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.participantCreator.length * 3;
  bytesCount += 3 + object.participantId.length * 3;
  bytesCount += 3 + object.participantName.length * 3;
  return bytesCount;
}

void _dbParticipantSerialize(
  DbParticipant object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdAtInUtc);
  writer.writeLong(offsets[1], object.editedAtInUtc);
  writer.writeString(offsets[2], object.participantCreator);
  writer.writeString(offsets[3], object.participantId);
  writer.writeString(offsets[4], object.participantName);
}

DbParticipant _dbParticipantDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbParticipant(
    createdAtInUtc: reader.readLong(offsets[0]),
    editedAtInUtc: reader.readLong(offsets[1]),
    participantCreator: reader.readString(offsets[2]),
    participantId: reader.readString(offsets[3]),
    participantName: reader.readString(offsets[4]),
  );
  return object;
}

P _dbParticipantDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbParticipantGetId(DbParticipant object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbParticipantGetLinks(DbParticipant object) {
  return [];
}

void _dbParticipantAttach(
    IsarCollection<dynamic> col, Id id, DbParticipant object) {}

extension DbParticipantQueryWhereSort
    on QueryBuilder<DbParticipant, DbParticipant, QWhere> {
  QueryBuilder<DbParticipant, DbParticipant, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DbParticipantQueryWhere
    on QueryBuilder<DbParticipant, DbParticipant, QWhereClause> {
  QueryBuilder<DbParticipant, DbParticipant, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterWhereClause>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterWhereClause>
      participantNameEqualTo(String participantName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'participantName',
        value: [participantName],
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterWhereClause>
      participantNameNotEqualTo(String participantName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantName',
              lower: [],
              upper: [participantName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantName',
              lower: [participantName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantName',
              lower: [participantName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantName',
              lower: [],
              upper: [participantName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterWhereClause>
      participantCreatorEqualTo(String participantCreator) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'participantCreator',
        value: [participantCreator],
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterWhereClause>
      participantCreatorNotEqualTo(String participantCreator) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantCreator',
              lower: [],
              upper: [participantCreator],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantCreator',
              lower: [participantCreator],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantCreator',
              lower: [participantCreator],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'participantCreator',
              lower: [],
              upper: [participantCreator],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbParticipantQueryFilter
    on QueryBuilder<DbParticipant, DbParticipant, QFilterCondition> {
  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      createdAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      editedAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'participantCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'participantCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'participantCreator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'participantCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'participantCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'participantCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'participantCreator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantCreatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'participantCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdEqualTo(
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdGreaterThan(
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdLessThan(
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdBetween(
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdStartsWith(
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdEndsWith(
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

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'participantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'participantId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'participantId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'participantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'participantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'participantName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'participantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'participantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'participantName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'participantName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterFilterCondition>
      participantNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'participantName',
        value: '',
      ));
    });
  }
}

extension DbParticipantQueryObject
    on QueryBuilder<DbParticipant, DbParticipant, QFilterCondition> {}

extension DbParticipantQueryLinks
    on QueryBuilder<DbParticipant, DbParticipant, QFilterCondition> {}

extension DbParticipantQuerySortBy
    on QueryBuilder<DbParticipant, DbParticipant, QSortBy> {
  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByParticipantCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantCreator', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByParticipantCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantCreator', Sort.desc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByParticipantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByParticipantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantId', Sort.desc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByParticipantName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantName', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      sortByParticipantNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantName', Sort.desc);
    });
  }
}

extension DbParticipantQuerySortThenBy
    on QueryBuilder<DbParticipant, DbParticipant, QSortThenBy> {
  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByParticipantCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantCreator', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByParticipantCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantCreator', Sort.desc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByParticipantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantId', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByParticipantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantId', Sort.desc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByParticipantName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantName', Sort.asc);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QAfterSortBy>
      thenByParticipantNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'participantName', Sort.desc);
    });
  }
}

extension DbParticipantQueryWhereDistinct
    on QueryBuilder<DbParticipant, DbParticipant, QDistinct> {
  QueryBuilder<DbParticipant, DbParticipant, QDistinct>
      distinctByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QDistinct>
      distinctByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QDistinct>
      distinctByParticipantCreator({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'participantCreator',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QDistinct> distinctByParticipantId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'participantId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbParticipant, DbParticipant, QDistinct>
      distinctByParticipantName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'participantName',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbParticipantQueryProperty
    on QueryBuilder<DbParticipant, DbParticipant, QQueryProperty> {
  QueryBuilder<DbParticipant, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbParticipant, int, QQueryOperations> createdAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbParticipant, int, QQueryOperations> editedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbParticipant, String, QQueryOperations>
      participantCreatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'participantCreator');
    });
  }

  QueryBuilder<DbParticipant, String, QQueryOperations>
      participantIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'participantId');
    });
  }

  QueryBuilder<DbParticipant, String, QQueryOperations>
      participantNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'participantName');
    });
  }
}
