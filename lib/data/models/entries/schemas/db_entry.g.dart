// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDbEntryCollection on Isar {
  IsarCollection<DbEntry> get dbEntrys => this.collection();
}

const DbEntrySchema = CollectionSchema(
  name: r'DbEntry',
  id: 618823930979236916,
  properties: {
    r'createdAtInUtc': PropertySchema(
      id: 0,
      name: r'createdAtInUtc',
      type: IsarType.long,
    ),
    r'createdAtTimeZone': PropertySchema(
      id: 1,
      name: r'createdAtTimeZone',
      type: IsarType.string,
    ),
    r'editedAtInUtc': PropertySchema(
      id: 2,
      name: r'editedAtInUtc',
      type: IsarType.long,
    ),
    r'editedAtTimeZone': PropertySchema(
      id: 3,
      name: r'editedAtTimeZone',
      type: IsarType.string,
    ),
    r'entryCreator': PropertySchema(
      id: 4,
      name: r'entryCreator',
      type: IsarType.string,
    ),
    r'entryId': PropertySchema(
      id: 5,
      name: r'entryId',
      type: IsarType.string,
    ),
    r'entryName': PropertySchema(
      id: 6,
      name: r'entryName',
      type: IsarType.string,
    ),
    r'fields': PropertySchema(
      id: 7,
      name: r'fields',
      type: IsarType.object,
      target: r'DbFields',
    ),
    r'isEncrypted': PropertySchema(
      id: 8,
      name: r'isEncrypted',
      type: IsarType.bool,
    ),
    r'modelEntryReference': PropertySchema(
      id: 9,
      name: r'modelEntryReference',
      type: IsarType.string,
    )
  },
  estimateSize: _dbEntryEstimateSize,
  serialize: _dbEntrySerialize,
  deserialize: _dbEntryDeserialize,
  deserializeProp: _dbEntryDeserializeProp,
  idName: r'isarId',
  indexes: {
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
    r'editedAtInUtc': IndexSchema(
      id: 8840644130544104231,
      name: r'editedAtInUtc',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'editedAtInUtc',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'entryName': IndexSchema(
      id: 174585222945992955,
      name: r'entryName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'entryName',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
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
  getId: _dbEntryGetId,
  getLinks: _dbEntryGetLinks,
  attach: _dbEntryAttach,
  version: '3.1.0+1',
);

int _dbEntryEstimateSize(
  DbEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.createdAtTimeZone.length * 3;
  bytesCount += 3 + object.editedAtTimeZone.length * 3;
  bytesCount += 3 + object.entryCreator.length * 3;
  bytesCount += 3 + object.entryId.length * 3;
  bytesCount += 3 + object.entryName.length * 3;
  bytesCount += 3 +
      DbFieldsSchema.estimateSize(
          object.fields, allOffsets[DbFields]!, allOffsets);
  bytesCount += 3 + object.modelEntryReference.length * 3;
  return bytesCount;
}

void _dbEntrySerialize(
  DbEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createdAtInUtc);
  writer.writeString(offsets[1], object.createdAtTimeZone);
  writer.writeLong(offsets[2], object.editedAtInUtc);
  writer.writeString(offsets[3], object.editedAtTimeZone);
  writer.writeString(offsets[4], object.entryCreator);
  writer.writeString(offsets[5], object.entryId);
  writer.writeString(offsets[6], object.entryName);
  writer.writeObject<DbFields>(
    offsets[7],
    allOffsets,
    DbFieldsSchema.serialize,
    object.fields,
  );
  writer.writeBool(offsets[8], object.isEncrypted);
  writer.writeString(offsets[9], object.modelEntryReference);
}

DbEntry _dbEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbEntry(
    createdAtInUtc: reader.readLong(offsets[0]),
    createdAtTimeZone: reader.readString(offsets[1]),
    editedAtInUtc: reader.readLong(offsets[2]),
    editedAtTimeZone: reader.readString(offsets[3]),
    entryCreator: reader.readString(offsets[4]),
    entryId: reader.readString(offsets[5]),
    entryName: reader.readString(offsets[6]),
    fields: reader.readObjectOrNull<DbFields>(
          offsets[7],
          DbFieldsSchema.deserialize,
          allOffsets,
        ) ??
        DbFields(),
    isEncrypted: reader.readBool(offsets[8]),
    modelEntryReference: reader.readString(offsets[9]),
  );
  return object;
}

P _dbEntryDeserializeProp<P>(
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
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readObjectOrNull<DbFields>(
            offset,
            DbFieldsSchema.deserialize,
            allOffsets,
          ) ??
          DbFields()) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dbEntryGetId(DbEntry object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dbEntryGetLinks(DbEntry object) {
  return [];
}

void _dbEntryAttach(IsarCollection<dynamic> col, Id id, DbEntry object) {}

extension DbEntryQueryWhereSort on QueryBuilder<DbEntry, DbEntry, QWhere> {
  QueryBuilder<DbEntry, DbEntry, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhere> anyIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isEncrypted'),
      );
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhere> anyCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAtInUtc'),
      );
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhere> anyEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'editedAtInUtc'),
      );
    });
  }
}

extension DbEntryQueryWhere on QueryBuilder<DbEntry, DbEntry, QWhereClause> {
  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> isEncryptedEqualTo(
      bool isEncrypted) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isEncrypted',
        value: [isEncrypted],
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> isEncryptedNotEqualTo(
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

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> modelEntryReferenceEqualTo(
      String modelEntryReference) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'modelEntryReference',
        value: [modelEntryReference],
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause>
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

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> createdAtInUtcEqualTo(
      int createdAtInUtc) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAtInUtc',
        value: [createdAtInUtc],
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> createdAtInUtcNotEqualTo(
      int createdAtInUtc) {
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

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> createdAtInUtcGreaterThan(
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

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> createdAtInUtcLessThan(
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

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> createdAtInUtcBetween(
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

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> editedAtInUtcEqualTo(
      int editedAtInUtc) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'editedAtInUtc',
        value: [editedAtInUtc],
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> editedAtInUtcNotEqualTo(
      int editedAtInUtc) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'editedAtInUtc',
              lower: [],
              upper: [editedAtInUtc],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'editedAtInUtc',
              lower: [editedAtInUtc],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'editedAtInUtc',
              lower: [editedAtInUtc],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'editedAtInUtc',
              lower: [],
              upper: [editedAtInUtc],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> editedAtInUtcGreaterThan(
    int editedAtInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'editedAtInUtc',
        lower: [editedAtInUtc],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> editedAtInUtcLessThan(
    int editedAtInUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'editedAtInUtc',
        lower: [],
        upper: [editedAtInUtc],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> editedAtInUtcBetween(
    int lowerEditedAtInUtc,
    int upperEditedAtInUtc, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'editedAtInUtc',
        lower: [lowerEditedAtInUtc],
        includeLower: includeLower,
        upper: [upperEditedAtInUtc],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> entryNameEqualTo(
      String entryName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'entryName',
        value: [entryName],
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterWhereClause> entryNameNotEqualTo(
      String entryName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryName',
              lower: [],
              upper: [entryName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryName',
              lower: [entryName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryName',
              lower: [entryName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'entryName',
              lower: [],
              upper: [entryName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DbEntryQueryFilter
    on QueryBuilder<DbEntry, DbEntry, QFilterCondition> {
  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> createdAtInUtcEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> createdAtInUtcLessThan(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> createdAtInUtcBetween(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtTimeZone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtTimeZone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtTimeZone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      createdAtTimeZoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtTimeZone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> editedAtInUtcEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> editedAtInUtcLessThan(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> editedAtInUtcBetween(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> editedAtTimeZoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      editedAtTimeZoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'editedAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      editedAtTimeZoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'editedAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> editedAtTimeZoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'editedAtTimeZone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      editedAtTimeZoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'editedAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      editedAtTimeZoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'editedAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      editedAtTimeZoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'editedAtTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> editedAtTimeZoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'editedAtTimeZone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      editedAtTimeZoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editedAtTimeZone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      editedAtTimeZoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'editedAtTimeZone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryCreatorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryCreatorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryCreatorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryCreatorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryCreator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryCreatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryCreatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryCreatorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entryCreator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryCreatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entryCreator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryCreatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      entryCreatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entryCreator',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdEqualTo(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdGreaterThan(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdLessThan(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdBetween(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdStartsWith(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdEndsWith(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entryId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entryName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> entryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entryName',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> isEncryptedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEncrypted',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
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

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      modelEntryReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'modelEntryReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      modelEntryReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'modelEntryReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      modelEntryReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modelEntryReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition>
      modelEntryReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'modelEntryReference',
        value: '',
      ));
    });
  }
}

extension DbEntryQueryObject
    on QueryBuilder<DbEntry, DbEntry, QFilterCondition> {
  QueryBuilder<DbEntry, DbEntry, QAfterFilterCondition> fields(
      FilterQuery<DbFields> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fields');
    });
  }
}

extension DbEntryQueryLinks
    on QueryBuilder<DbEntry, DbEntry, QFilterCondition> {}

extension DbEntryQuerySortBy on QueryBuilder<DbEntry, DbEntry, QSortBy> {
  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByCreatedAtTimeZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTimeZone', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByCreatedAtTimeZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTimeZone', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEditedAtTimeZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtTimeZone', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEditedAtTimeZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtTimeZone', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEntryCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreator', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEntryCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreator', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEntryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryName', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByEntryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryName', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByIsEncryptedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByModelEntryReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryReference', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> sortByModelEntryReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryReference', Sort.desc);
    });
  }
}

extension DbEntryQuerySortThenBy
    on QueryBuilder<DbEntry, DbEntry, QSortThenBy> {
  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByCreatedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByCreatedAtTimeZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTimeZone', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByCreatedAtTimeZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtTimeZone', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEditedAtInUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtInUtc', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEditedAtTimeZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtTimeZone', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEditedAtTimeZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editedAtTimeZone', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEntryCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreator', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEntryCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryCreator', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEntryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEntryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryId', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEntryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryName', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByEntryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryName', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByIsEncryptedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEncrypted', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByModelEntryReference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryReference', Sort.asc);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QAfterSortBy> thenByModelEntryReferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelEntryReference', Sort.desc);
    });
  }
}

extension DbEntryQueryWhereDistinct
    on QueryBuilder<DbEntry, DbEntry, QDistinct> {
  QueryBuilder<DbEntry, DbEntry, QDistinct> distinctByCreatedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbEntry, DbEntry, QDistinct> distinctByCreatedAtTimeZone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtTimeZone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QDistinct> distinctByEditedAtInUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbEntry, DbEntry, QDistinct> distinctByEditedAtTimeZone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editedAtTimeZone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QDistinct> distinctByEntryCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryCreator', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QDistinct> distinctByEntryId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QDistinct> distinctByEntryName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DbEntry, DbEntry, QDistinct> distinctByIsEncrypted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEncrypted');
    });
  }

  QueryBuilder<DbEntry, DbEntry, QDistinct> distinctByModelEntryReference(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelEntryReference',
          caseSensitive: caseSensitive);
    });
  }
}

extension DbEntryQueryProperty
    on QueryBuilder<DbEntry, DbEntry, QQueryProperty> {
  QueryBuilder<DbEntry, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DbEntry, int, QQueryOperations> createdAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtInUtc');
    });
  }

  QueryBuilder<DbEntry, String, QQueryOperations> createdAtTimeZoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtTimeZone');
    });
  }

  QueryBuilder<DbEntry, int, QQueryOperations> editedAtInUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editedAtInUtc');
    });
  }

  QueryBuilder<DbEntry, String, QQueryOperations> editedAtTimeZoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editedAtTimeZone');
    });
  }

  QueryBuilder<DbEntry, String, QQueryOperations> entryCreatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryCreator');
    });
  }

  QueryBuilder<DbEntry, String, QQueryOperations> entryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryId');
    });
  }

  QueryBuilder<DbEntry, String, QQueryOperations> entryNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryName');
    });
  }

  QueryBuilder<DbEntry, DbFields, QQueryOperations> fieldsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fields');
    });
  }

  QueryBuilder<DbEntry, bool, QQueryOperations> isEncryptedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEncrypted');
    });
  }

  QueryBuilder<DbEntry, String, QQueryOperations>
      modelEntryReferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelEntryReference');
    });
  }
}
