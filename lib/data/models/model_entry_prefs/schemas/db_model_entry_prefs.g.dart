// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model_entry_prefs.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbModelEntryPrefsCollection on Isar {
  IsarCollection<DbModelEntryPrefs> get dbModelEntryPrefs => this.collection();
}

const DbModelEntryPrefsSchema = CollectionSchema(
  name: r'DbModelEntryPrefs',
  id: 8407046818711352984,
  properties: {
    r'copyFieldId': PropertySchema(
      id: 0,
      name: r'copyFieldId',
      type: IsarType.string,
    ),
    r'createdAtInUtc': PropertySchema(
      id: 1,
      name: r'createdAtInUtc',
      type: IsarType.long,
    ),
    r'defaultEveryone': PropertySchema(
      id: 2,
      name: r'defaultEveryone',
      type: IsarType.object,
      target: r'DbDefaultFields',
    ),
    r'defaultSelf': PropertySchema(
      id: 3,
      name: r'defaultSelf',
      type: IsarType.object,
      target: r'DbDefaultFields',
    ),
    r'editedAtInUtc': PropertySchema(
      id: 4,
      name: r'editedAtInUtc',
      type: IsarType.long,
    ),
    r'modelEntryId': PropertySchema(
      id: 5,
      name: r'modelEntryId',
      type: IsarType.string,
    ),
    r'subtitleFieldId': PropertySchema(
      id: 6,
      name: r'subtitleFieldId',
      type: IsarType.string,
    ),
    r'thirdLineFieldId': PropertySchema(
      id: 7,
      name: r'thirdLineFieldId',
      type: IsarType.string,
    )
  },
  estimateSize: _dbModelEntryPrefsEstimateSize,
  serialize: _dbModelEntryPrefsSerialize,
  deserialize: _dbModelEntryPrefsDeserialize,
  deserializeProp: _dbModelEntryPrefsDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'modelEntryId': IndexSchema(
      id: 7892162904292410021,
      name: r'modelEntryId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'modelEntryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'DbDefaultFields': DbDefaultFieldsSchema,
    r'DbFields': DbFieldsSchema,
    r'DbField': DbFieldSchema,
    r'DbDateData': DbDateDataSchema,
    r'DbDateAndTimeData': DbDateAndTimeDataSchema,
    r'DbTimeData': DbTimeDataSchema,
    r'DbDateOfBirthData': DbDateOfBirthDataSchema,
    r'DbNumberData': DbNumberDataSchema,
    r'DbMoneyData': DbMoneyDataSchema,
    r'DbTagsData': DbTagsDataSchema,
    r'DbPasswordData': DbPasswordDataSchema,
    r'DbPhoneData': DbPhoneDataSchema,
    r'DbTextData': DbTextDataSchema,
    r'DbEmailData': DbEmailDataSchema,
    r'DbWebsiteData': DbWebsiteDataSchema,
    r'DbUsernameData': DbUsernameDataSchema,
    r'DbLocationData': DbLocationDataSchema,
    r'DbImageData': DbImageDataSchema,
    r'DbFileItem': DbFileItemSchema,
    r'DbFileData': DbFileDataSchema,
    r'DbPaymentData': DbPaymentDataSchema,
    r'DbShareReference': DbShareReferenceSchema,
    r'DbMemberToImportReference': DbMemberToImportReferenceSchema,
    r'DbMeasurementData': DbMeasurementDataSchema,
    r'DbEmotionData': DbEmotionDataSchema,
    r'DbEmotionItem': DbEmotionItemSchema,
    r'DbAvatarImageData': DbAvatarImageDataSchema,
    r'DbBooleanData': DbBooleanDataSchema
  },
  getId: _dbModelEntryPrefsGetId,
  getLinks: _dbModelEntryPrefsGetLinks,
  attach: _dbModelEntryPrefsAttach,
  version: '3.1.0+1',
);

int _dbModelEntryPrefsEstimateSize(
  DbModelEntryPrefs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.copyFieldId.length * 3;
  bytesCount += 3 +
      DbDefaultFieldsSchema.estimateSize(
          object.defaultEveryone, allOffsets[DbDefaultFields]!, allOffsets);
  bytesCount += 3 +
      DbDefaultFieldsSchema.estimateSize(
          object.defaultSelf, allOffsets[DbDefaultFields]!, allOffsets);
  bytesCount += 3 + object.modelEntryId.length * 3;
  bytesCount += 3 + object.subtitleFieldId.length * 3;
  bytesCount += 3 + object.thirdLineFieldId.length * 3;
  return bytesCount;
}

void _dbModelEntryPrefsSerialize(
  DbModelEntryPrefs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.copyFieldId);
  writer.writeLong(offsets[1], object.createdAtInUtc);
  writer.writeObject<DbDefaultFields>(
    offsets[2],
    allOffsets,
    DbDefaultFieldsSchema.serialize,
    object.defaultEveryone,
  );
  writer.writeObject<DbDefaultFields>(
    offsets[3],
    allOffsets,
    DbDefaultFieldsSchema.serialize,
    object.defaultSelf,
  );
  writer.writeLong(offsets[4], object.editedAtInUtc);
  writer.writeString(offsets[5], object.modelEntryId);
  writer.writeString(offsets[6], object.subtitleFieldId);
  writer.writeString(offsets[7], object.thirdLineFieldId);
}

DbModelEntryPrefs _dbModelEntryPrefsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbModelEntryPrefs(
    copyFieldId: reader.readString(offsets[0]),
    createdAtInUtc: reader.readLong(offsets[1]),
    defaultEveryone: reader.readObjectOrNull<DbDefaultFields>(
          offsets[2],
          DbDefaultFieldsSchema.deserialize,
          allOffsets,
        ) ??
        DbDefaultFields(),
    defaultSelf: reader.readObjectOrNull<DbDefaultFields>(
          offsets[3],
          DbDefaultFieldsSchema.deserialize,
          allOffsets,
        ) ??
        DbDefaultFields(),
    editedAtInUtc: reader.readLong(offsets[4]),
    modelEntryId: reader.readString(offsets[5]),
    subtitleFieldId: reader.readString(offsets[6]),
    thirdLineFieldId: reader.readString(offsets[7]),
  );
  return object;
}

P _dbModelEntryPrefsDeserializeProp<P>(
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
      return (reader.readObjectOrNull<DbDefaultFields>(
            offset,
            DbDefaultFieldsSchema.deserialize,
            allOffsets,
          ) ??
          DbDefaultFields()) as P;
    case 3:
      return (reader.readObjectOrNull<DbDefaultFields>(
            offset,
            DbDefaultFieldsSchema.deserialize,
            allOffsets,
          ) ??
          DbDefaultFields()) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbModelEntryPrefsGetId(DbModelEntryPrefs object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbModelEntryPrefsGetLinks(
    DbModelEntryPrefs object) {
  return [];
}

void _dbModelEntryPrefsAttach(
    IsarCollection<dynamic> col, Id id, DbModelEntryPrefs object) {}

extension DbModelEntryPrefsQueryWhereSort
    on QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QWhere> {
  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DbModelEntryPrefsQueryWhere
    on QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QWhereClause> {
  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterWhereClause>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterWhereClause>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterWhereClause>
      modelEntryIdEqualTo(String modelEntryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'modelEntryId',
        value: [modelEntryId],
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterWhereClause>
      modelEntryIdNotEqualTo(String modelEntryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryId',
              lower: [],
              upper: [modelEntryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryId',
              lower: [modelEntryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryId',
              lower: [modelEntryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryId',
              lower: [],
              upper: [modelEntryId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbModelEntryPrefsQueryFilter
    on QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QFilterCondition> {
  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'copyFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'copyFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'copyFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'copyFieldId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'copyFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'copyFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'copyFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'copyFieldId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'copyFieldId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      copyFieldIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'copyFieldId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      createdAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      editedAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelEntryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelEntryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      modelEntryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelEntryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtitleFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subtitleFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subtitleFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subtitleFieldId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subtitleFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subtitleFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subtitleFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subtitleFieldId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtitleFieldId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      subtitleFieldIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subtitleFieldId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thirdLineFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thirdLineFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thirdLineFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thirdLineFieldId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thirdLineFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thirdLineFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thirdLineFieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thirdLineFieldId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thirdLineFieldId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      thirdLineFieldIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thirdLineFieldId',
        value: '',
      ));
    });
  }
}

extension DbModelEntryPrefsQueryObject
    on QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QFilterCondition> {
  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      defaultEveryone(FilterQuery<DbDefaultFields> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'defaultEveryone');
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterFilterCondition>
      defaultSelf(FilterQuery<DbDefaultFields> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'defaultSelf');
    });
  }
}

extension DbModelEntryPrefsQueryLinks
    on QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QFilterCondition> {}

extension DbModelEntryPrefsQuerySortBy
    on QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QSortBy> {
  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByCopyFieldId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'copyFieldId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByCopyFieldIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'copyFieldId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByModelEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByModelEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortBySubtitleFieldId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitleFieldId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortBySubtitleFieldIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitleFieldId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByThirdLineFieldId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thirdLineFieldId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      sortByThirdLineFieldIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thirdLineFieldId', Sort.desc);
    });
  }
}

extension DbModelEntryPrefsQuerySortThenBy
    on QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QSortThenBy> {
  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByCopyFieldId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'copyFieldId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByCopyFieldIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'copyFieldId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByModelEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByModelEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenBySubtitleFieldId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitleFieldId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenBySubtitleFieldIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitleFieldId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByThirdLineFieldId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thirdLineFieldId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QAfterSortBy>
      thenByThirdLineFieldIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thirdLineFieldId', Sort.desc);
    });
  }
}

extension DbModelEntryPrefsQueryWhereDistinct
    on QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QDistinct> {
  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QDistinct>
      distinctByCopyFieldId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'copyFieldId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QDistinct>
      distinctByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QDistinct>
      distinctByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QDistinct>
      distinctByModelEntryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelEntryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QDistinct>
      distinctBySubtitleFieldId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subtitleFieldId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QDistinct>
      distinctByThirdLineFieldId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thirdLineFieldId',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbModelEntryPrefsQueryProperty
    on QueryBuilder<DbModelEntryPrefs, DbModelEntryPrefs, QQueryProperty> {
  QueryBuilder<DbModelEntryPrefs, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbModelEntryPrefs, String, QQueryOperations>
      copyFieldIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'copyFieldId');
    });
  }

  QueryBuilder<DbModelEntryPrefs, int, QQueryOperations>
      createdAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbDefaultFields, QQueryOperations>
      defaultEveryoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultEveryone');
    });
  }

  QueryBuilder<DbModelEntryPrefs, DbDefaultFields, QQueryOperations>
      defaultSelfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultSelf');
    });
  }

  QueryBuilder<DbModelEntryPrefs, int, QQueryOperations>
      editedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbModelEntryPrefs, String, QQueryOperations>
      modelEntryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelEntryId');
    });
  }

  QueryBuilder<DbModelEntryPrefs, String, QQueryOperations>
      subtitleFieldIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subtitleFieldId');
    });
  }

  QueryBuilder<DbModelEntryPrefs, String, QQueryOperations>
      thirdLineFieldIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thirdLineFieldId');
    });
  }
}
