// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_user.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbUserCollection on Isar {
  IsarCollection<DbUser> get dbUsers => this.collection();
}

const DbUserSchema = CollectionSchema(
  name: r'DbUser',
  id: -9131662857584035194,
  properties: {
    r'editedAtInUtc': PropertySchema(
      id: 0,
      name: r'editedAtInUtc',
      type: IsarType.long,
    ),
    r'interactedAtInUtc': PropertySchema(
      id: 1,
      name: r'interactedAtInUtc',
      type: IsarType.long,
    ),
    r'passwordGenerator': PropertySchema(
      id: 2,
      name: r'passwordGenerator',
      type: IsarType.object,
      target: r'DbPasswordGenerator',
    ),
    r'settings': PropertySchema(
      id: 3,
      name: r'settings',
      type: IsarType.object,
      target: r'DbSettings',
    ),
    r'userId': PropertySchema(
      id: 4,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _dbUserEstimateSize,
  serialize: _dbUserSerialize,
  deserialize: _dbUserDeserialize,
  deserializeProp: _dbUserDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'DbSettings': DbSettingsSchema,
    r'DbPasswordGenerator': DbPasswordGeneratorSchema
  },
  getId: _dbUserGetId,
  getLinks: _dbUserGetLinks,
  attach: _dbUserAttach,
  version: '3.1.0+1',
);

int _dbUserEstimateSize(
  DbUser object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      DbPasswordGeneratorSchema.estimateSize(object.passwordGenerator,
          allOffsets[DbPasswordGenerator]!, allOffsets);
  bytesCount += 3 +
      DbSettingsSchema.estimateSize(
          object.settings, allOffsets[DbSettings]!, allOffsets);
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _dbUserSerialize(
  DbUser object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.editedAtInUtc);
  writer.writeLong(offsets[1], object.interactedAtInUtc);
  writer.writeObject<DbPasswordGenerator>(
    offsets[2],
    allOffsets,
    DbPasswordGeneratorSchema.serialize,
    object.passwordGenerator,
  );
  writer.writeObject<DbSettings>(
    offsets[3],
    allOffsets,
    DbSettingsSchema.serialize,
    object.settings,
  );
  writer.writeString(offsets[4], object.userId);
}

DbUser _dbUserDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbUser(
    editedAtInUtc: reader.readLong(offsets[0]),
    interactedAtInUtc: reader.readLong(offsets[1]),
    passwordGenerator: reader.readObjectOrNull<DbPasswordGenerator>(
          offsets[2],
          DbPasswordGeneratorSchema.deserialize,
          allOffsets,
        ) ??
        DbPasswordGenerator(),
    settings: reader.readObjectOrNull<DbSettings>(
          offsets[3],
          DbSettingsSchema.deserialize,
          allOffsets,
        ) ??
        DbSettings(),
    userId: reader.readString(offsets[4]),
  );
  return object;
}

P _dbUserDeserializeProp<P>(
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
      return (reader.readObjectOrNull<DbPasswordGenerator>(
            offset,
            DbPasswordGeneratorSchema.deserialize,
            allOffsets,
          ) ??
          DbPasswordGenerator()) as P;
    case 3:
      return (reader.readObjectOrNull<DbSettings>(
            offset,
            DbSettingsSchema.deserialize,
            allOffsets,
          ) ??
          DbSettings()) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbUserGetId(DbUser object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbUserGetLinks(DbUser object) {
  return [];
}

void _dbUserAttach(IsarCollection<dynamic> col, Id id, DbUser object) {}

extension DbUserQueryWhereSort on QueryBuilder<DbUser, DbUser, QWhere> {
  QueryBuilder<DbUser, DbUser, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DbUserQueryWhere on QueryBuilder<DbUser, DbUser, QWhereClause> {
  QueryBuilder<DbUser, DbUser, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<DbUser, DbUser, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DbUser, DbUser, QAfterWhereClause> userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterWhereClause> userIdNotEqualTo(
      String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbUserQueryFilter on QueryBuilder<DbUser, DbUser, QFilterCondition> {
  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> editedAtInUtcEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> editedAtInUtcGreaterThan(
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

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> editedAtInUtcLessThan(
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

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> editedAtInUtcBetween(
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

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> interactedAtInUtcEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interactedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition>
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

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> interactedAtInUtcLessThan(
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

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> interactedAtInUtcBetween(
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

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension DbUserQueryObject on QueryBuilder<DbUser, DbUser, QFilterCondition> {
  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> passwordGenerator(
      FilterQuery<DbPasswordGenerator> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'passwordGenerator');
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterFilterCondition> settings(
      FilterQuery<DbSettings> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'settings');
    });
  }
}

extension DbUserQueryLinks on QueryBuilder<DbUser, DbUser, QFilterCondition> {}

extension DbUserQuerySortBy on QueryBuilder<DbUser, DbUser, QSortBy> {
  QueryBuilder<DbUser, DbUser, QAfterSortBy> sortByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> sortByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> sortByInteractedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interactedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> sortByInteractedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interactedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension DbUserQuerySortThenBy on QueryBuilder<DbUser, DbUser, QSortThenBy> {
  QueryBuilder<DbUser, DbUser, QAfterSortBy> thenByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> thenByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> thenByInteractedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interactedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> thenByInteractedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interactedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<DbUser, DbUser, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension DbUserQueryWhereDistinct on QueryBuilder<DbUser, DbUser, QDistinct> {
  QueryBuilder<DbUser, DbUser, QDistinct> distinctByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbUser, DbUser, QDistinct> distinctByInteractedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interactedAtInUtc');
    });
  }

  QueryBuilder<DbUser, DbUser, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension DbUserQueryProperty on QueryBuilder<DbUser, DbUser, QQueryProperty> {
  QueryBuilder<DbUser, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbUser, int, QQueryOperations> editedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbUser, int, QQueryOperations> interactedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interactedAtInUtc');
    });
  }

  QueryBuilder<DbUser, DbPasswordGenerator, QQueryOperations>
      passwordGeneratorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'passwordGenerator');
    });
  }

  QueryBuilder<DbUser, DbSettings, QQueryOperations> settingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'settings');
    });
  }

  QueryBuilder<DbUser, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
