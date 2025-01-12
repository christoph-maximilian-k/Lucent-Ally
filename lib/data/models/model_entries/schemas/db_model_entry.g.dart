// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbModelEntryCollection on Isar {
  IsarCollection<DbModelEntry> get dbModelEntrys => this.collection();
}

const DbModelEntrySchema = CollectionSchema(
  name: r'DbModelEntry',
  id: -6654589935255178266,
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
    r'entryCreatedAtIsEditable': PropertySchema(
      id: 2,
      name: r'entryCreatedAtIsEditable',
      type: IsarType.bool,
    ),
    r'fieldIdentifications': PropertySchema(
      id: 3,
      name: r'fieldIdentifications',
      type: IsarType.object,
      target: r'DbFieldIdentifications',
    ),
    r'importSpecifications': PropertySchema(
      id: 4,
      name: r'importSpecifications',
      type: IsarType.object,
      target: r'DbImportSpecifications',
    ),
    r'modelEntryCreator': PropertySchema(
      id: 5,
      name: r'modelEntryCreator',
      type: IsarType.string,
    ),
    r'modelEntryId': PropertySchema(
      id: 6,
      name: r'modelEntryId',
      type: IsarType.string,
    ),
    r'modelEntryName': PropertySchema(
      id: 7,
      name: r'modelEntryName',
      type: IsarType.string,
    )
  },
  estimateSize: _dbModelEntryEstimateSize,
  serialize: _dbModelEntrySerialize,
  deserialize: _dbModelEntryDeserialize,
  deserializeProp: _dbModelEntryDeserializeProp,
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
    ),
    r'modelEntryName': IndexSchema(
      id: -677970641614248556,
      name: r'modelEntryName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'modelEntryName',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'DbFieldIdentifications': DbFieldIdentificationsSchema,
    r'DbFieldIdentification': DbFieldIdentificationSchema,
    r'DbImportSpecifications': DbImportSpecificationsSchema,
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
  getId: _dbModelEntryGetId,
  getLinks: _dbModelEntryGetLinks,
  attach: _dbModelEntryAttach,
  version: '3.1.0+1',
);

int _dbModelEntryEstimateSize(
  DbModelEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      DbFieldIdentificationsSchema.estimateSize(object.fieldIdentifications,
          allOffsets[DbFieldIdentifications]!, allOffsets);
  {
    final value = object.importSpecifications;
    if (value != null) {
      bytesCount += 3 +
          DbImportSpecificationsSchema.estimateSize(
              value, allOffsets[DbImportSpecifications]!, allOffsets);
    }
  }
  bytesCount += 3 + object.modelEntryCreator.length * 3;
  bytesCount += 3 + object.modelEntryId.length * 3;
  bytesCount += 3 + object.modelEntryName.length * 3;
  return bytesCount;
}

void _dbModelEntrySerialize(
  DbModelEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdAtInUtc);
  writer.writeLong(offsets[1], object.editedAtInUtc);
  writer.writeBool(offsets[2], object.entryCreatedAtIsEditable);
  writer.writeObject<DbFieldIdentifications>(
    offsets[3],
    allOffsets,
    DbFieldIdentificationsSchema.serialize,
    object.fieldIdentifications,
  );
  writer.writeObject<DbImportSpecifications>(
    offsets[4],
    allOffsets,
    DbImportSpecificationsSchema.serialize,
    object.importSpecifications,
  );
  writer.writeString(offsets[5], object.modelEntryCreator);
  writer.writeString(offsets[6], object.modelEntryId);
  writer.writeString(offsets[7], object.modelEntryName);
}

DbModelEntry _dbModelEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbModelEntry(
    createdAtInUtc: reader.readLong(offsets[0]),
    editedAtInUtc: reader.readLong(offsets[1]),
    entryCreatedAtIsEditable: reader.readBool(offsets[2]),
    fieldIdentifications: reader.readObjectOrNull<DbFieldIdentifications>(
          offsets[3],
          DbFieldIdentificationsSchema.deserialize,
          allOffsets,
        ) ??
        DbFieldIdentifications(),
    importSpecifications: reader.readObjectOrNull<DbImportSpecifications>(
      offsets[4],
      DbImportSpecificationsSchema.deserialize,
      allOffsets,
    ),
    modelEntryCreator: reader.readString(offsets[5]),
    modelEntryId: reader.readString(offsets[6]),
    modelEntryName: reader.readString(offsets[7]),
  );
  return object;
}

P _dbModelEntryDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<DbFieldIdentifications>(
            offset,
            DbFieldIdentificationsSchema.deserialize,
            allOffsets,
          ) ??
          DbFieldIdentifications()) as P;
    case 4:
      return (reader.readObjectOrNull<DbImportSpecifications>(
        offset,
        DbImportSpecificationsSchema.deserialize,
        allOffsets,
      )) as P;
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

Id _dbModelEntryGetId(DbModelEntry object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbModelEntryGetLinks(DbModelEntry object) {
  return [];
}

void _dbModelEntryAttach(
    IsarCollection<dynamic> col, Id id, DbModelEntry object) {}

extension DbModelEntryQueryWhereSort
    on QueryBuilder<DbModelEntry, DbModelEntry, QWhere> {
  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DbModelEntryQueryWhere
    on QueryBuilder<DbModelEntry, DbModelEntry, QWhereClause> {
  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhereClause>
      modelEntryIdEqualTo(String modelEntryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'modelEntryId',
        value: [modelEntryId],
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhereClause>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhereClause>
      modelEntryNameEqualTo(String modelEntryName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'modelEntryName',
        value: [modelEntryName],
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterWhereClause>
      modelEntryNameNotEqualTo(String modelEntryName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryName',
              lower: [],
              upper: [modelEntryName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryName',
              lower: [modelEntryName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryName',
              lower: [modelEntryName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'modelEntryName',
              lower: [],
              upper: [modelEntryName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbModelEntryQueryFilter
    on QueryBuilder<DbModelEntry, DbModelEntry, QFilterCondition> {
  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      createdAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      editedAtInUtcEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      entryCreatedAtIsEditableEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryCreatedAtIsEditable',
        value: value,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      importSpecificationsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importSpecifications',
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      importSpecificationsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importSpecifications',
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelEntryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelEntryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelEntryCreator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelEntryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelEntryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelEntryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelEntryCreator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryCreatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelEntryCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
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

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelEntryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelEntryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelEntryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modelEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modelEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modelEntryName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'modelEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'modelEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelEntryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelEntryName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      modelEntryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelEntryName',
        value: '',
      ));
    });
  }
}

extension DbModelEntryQueryObject
    on QueryBuilder<DbModelEntry, DbModelEntry, QFilterCondition> {
  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      fieldIdentifications(FilterQuery<DbFieldIdentifications> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fieldIdentifications');
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterFilterCondition>
      importSpecifications(FilterQuery<DbImportSpecifications> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'importSpecifications');
    });
  }
}

extension DbModelEntryQueryLinks
    on QueryBuilder<DbModelEntry, DbModelEntry, QFilterCondition> {}

extension DbModelEntryQuerySortBy
    on QueryBuilder<DbModelEntry, DbModelEntry, QSortBy> {
  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy> sortByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByEntryCreatedAtIsEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreatedAtIsEditable', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByEntryCreatedAtIsEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreatedAtIsEditable', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByModelEntryCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryCreator', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByModelEntryCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryCreator', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy> sortByModelEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByModelEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByModelEntryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryName', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      sortByModelEntryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryName', Sort.desc);
    });
  }
}

extension DbModelEntryQuerySortThenBy
    on QueryBuilder<DbModelEntry, DbModelEntry, QSortThenBy> {
  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy> thenByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByEntryCreatedAtIsEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreatedAtIsEditable', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByEntryCreatedAtIsEditableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreatedAtIsEditable', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByModelEntryCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryCreator', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByModelEntryCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryCreator', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy> thenByModelEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryId', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByModelEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryId', Sort.desc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByModelEntryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryName', Sort.asc);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QAfterSortBy>
      thenByModelEntryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryName', Sort.desc);
    });
  }
}

extension DbModelEntryQueryWhereDistinct
    on QueryBuilder<DbModelEntry, DbModelEntry, QDistinct> {
  QueryBuilder<DbModelEntry, DbModelEntry, QDistinct>
      distinctByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QDistinct>
      distinctByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QDistinct>
      distinctByEntryCreatedAtIsEditable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryCreatedAtIsEditable');
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QDistinct>
      distinctByModelEntryCreator({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelEntryCreator',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QDistinct> distinctByModelEntryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelEntryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbModelEntry, DbModelEntry, QDistinct> distinctByModelEntryName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelEntryName',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbModelEntryQueryProperty
    on QueryBuilder<DbModelEntry, DbModelEntry, QQueryProperty> {
  QueryBuilder<DbModelEntry, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbModelEntry, int, QQueryOperations> createdAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbModelEntry, int, QQueryOperations> editedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbModelEntry, bool, QQueryOperations>
      entryCreatedAtIsEditableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryCreatedAtIsEditable');
    });
  }

  QueryBuilder<DbModelEntry, DbFieldIdentifications, QQueryOperations>
      fieldIdentificationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fieldIdentifications');
    });
  }

  QueryBuilder<DbModelEntry, DbImportSpecifications?, QQueryOperations>
      importSpecificationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'importSpecifications');
    });
  }

  QueryBuilder<DbModelEntry, String, QQueryOperations>
      modelEntryCreatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelEntryCreator');
    });
  }

  QueryBuilder<DbModelEntry, String, QQueryOperations> modelEntryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelEntryId');
    });
  }

  QueryBuilder<DbModelEntry, String, QQueryOperations>
      modelEntryNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelEntryName');
    });
  }
}
