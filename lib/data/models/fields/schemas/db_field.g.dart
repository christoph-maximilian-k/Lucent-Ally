// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_field.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbFieldSchema = Schema(
  name: r'DbField',
  id: 8711336070772874199,
  properties: {
    r'avatarImageData': PropertySchema(
      id: 0,
      name: r'avatarImageData',
      type: IsarType.object,
      target: r'DbAvatarImageData',
    ),
    r'booleanData': PropertySchema(
      id: 1,
      name: r'booleanData',
      type: IsarType.object,
      target: r'DbBooleanData',
    ),
    r'canChangeParameters': PropertySchema(
      id: 2,
      name: r'canChangeParameters',
      type: IsarType.bool,
    ),
    r'dateAndTimeData': PropertySchema(
      id: 3,
      name: r'dateAndTimeData',
      type: IsarType.object,
      target: r'DbDateAndTimeData',
    ),
    r'dateData': PropertySchema(
      id: 4,
      name: r'dateData',
      type: IsarType.object,
      target: r'DbDateData',
    ),
    r'dateOfBirthData': PropertySchema(
      id: 5,
      name: r'dateOfBirthData',
      type: IsarType.object,
      target: r'DbDateOfBirthData',
    ),
    r'emailData': PropertySchema(
      id: 6,
      name: r'emailData',
      type: IsarType.object,
      target: r'DbEmailData',
    ),
    r'emotionData': PropertySchema(
      id: 7,
      name: r'emotionData',
      type: IsarType.object,
      target: r'DbEmotionData',
    ),
    r'fieldId': PropertySchema(
      id: 8,
      name: r'fieldId',
      type: IsarType.string,
    ),
    r'fieldType': PropertySchema(
      id: 9,
      name: r'fieldType',
      type: IsarType.string,
    ),
    r'fileData': PropertySchema(
      id: 10,
      name: r'fileData',
      type: IsarType.object,
      target: r'DbFileData',
    ),
    r'imageData': PropertySchema(
      id: 11,
      name: r'imageData',
      type: IsarType.object,
      target: r'DbImageData',
    ),
    r'locationData': PropertySchema(
      id: 12,
      name: r'locationData',
      type: IsarType.object,
      target: r'DbLocationData',
    ),
    r'measurementData': PropertySchema(
      id: 13,
      name: r'measurementData',
      type: IsarType.object,
      target: r'DbMeasurementData',
    ),
    r'moneyData': PropertySchema(
      id: 14,
      name: r'moneyData',
      type: IsarType.object,
      target: r'DbMoneyData',
    ),
    r'numberData': PropertySchema(
      id: 15,
      name: r'numberData',
      type: IsarType.object,
      target: r'DbNumberData',
    ),
    r'passwordData': PropertySchema(
      id: 16,
      name: r'passwordData',
      type: IsarType.object,
      target: r'DbPasswordData',
    ),
    r'paymentData': PropertySchema(
      id: 17,
      name: r'paymentData',
      type: IsarType.object,
      target: r'DbPaymentData',
    ),
    r'phoneData': PropertySchema(
      id: 18,
      name: r'phoneData',
      type: IsarType.object,
      target: r'DbPhoneData',
    ),
    r'tagsData': PropertySchema(
      id: 19,
      name: r'tagsData',
      type: IsarType.object,
      target: r'DbTagsData',
    ),
    r'textData': PropertySchema(
      id: 20,
      name: r'textData',
      type: IsarType.object,
      target: r'DbTextData',
    ),
    r'timeData': PropertySchema(
      id: 21,
      name: r'timeData',
      type: IsarType.object,
      target: r'DbTimeData',
    ),
    r'usernameData': PropertySchema(
      id: 22,
      name: r'usernameData',
      type: IsarType.object,
      target: r'DbUsernameData',
    ),
    r'websiteData': PropertySchema(
      id: 23,
      name: r'websiteData',
      type: IsarType.object,
      target: r'DbWebsiteData',
    )
  },
  estimateSize: _dbFieldEstimateSize,
  serialize: _dbFieldSerialize,
  deserialize: _dbFieldDeserialize,
  deserializeProp: _dbFieldDeserializeProp,
);

int _dbFieldEstimateSize(
  DbField object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.avatarImageData;
    if (value != null) {
      bytesCount += 3 +
          DbAvatarImageDataSchema.estimateSize(
              value, allOffsets[DbAvatarImageData]!, allOffsets);
    }
  }
  {
    final value = object.booleanData;
    if (value != null) {
      bytesCount += 3 +
          DbBooleanDataSchema.estimateSize(
              value, allOffsets[DbBooleanData]!, allOffsets);
    }
  }
  {
    final value = object.dateAndTimeData;
    if (value != null) {
      bytesCount += 3 +
          DbDateAndTimeDataSchema.estimateSize(
              value, allOffsets[DbDateAndTimeData]!, allOffsets);
    }
  }
  {
    final value = object.dateData;
    if (value != null) {
      bytesCount += 3 +
          DbDateDataSchema.estimateSize(
              value, allOffsets[DbDateData]!, allOffsets);
    }
  }
  {
    final value = object.dateOfBirthData;
    if (value != null) {
      bytesCount += 3 +
          DbDateOfBirthDataSchema.estimateSize(
              value, allOffsets[DbDateOfBirthData]!, allOffsets);
    }
  }
  {
    final value = object.emailData;
    if (value != null) {
      bytesCount += 3 +
          DbEmailDataSchema.estimateSize(
              value, allOffsets[DbEmailData]!, allOffsets);
    }
  }
  {
    final value = object.emotionData;
    if (value != null) {
      bytesCount += 3 +
          DbEmotionDataSchema.estimateSize(
              value, allOffsets[DbEmotionData]!, allOffsets);
    }
  }
  {
    final value = object.fieldId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fieldType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fileData;
    if (value != null) {
      bytesCount += 3 +
          DbFileDataSchema.estimateSize(
              value, allOffsets[DbFileData]!, allOffsets);
    }
  }
  {
    final value = object.imageData;
    if (value != null) {
      bytesCount += 3 +
          DbImageDataSchema.estimateSize(
              value, allOffsets[DbImageData]!, allOffsets);
    }
  }
  {
    final value = object.locationData;
    if (value != null) {
      bytesCount += 3 +
          DbLocationDataSchema.estimateSize(
              value, allOffsets[DbLocationData]!, allOffsets);
    }
  }
  {
    final value = object.measurementData;
    if (value != null) {
      bytesCount += 3 +
          DbMeasurementDataSchema.estimateSize(
              value, allOffsets[DbMeasurementData]!, allOffsets);
    }
  }
  {
    final value = object.moneyData;
    if (value != null) {
      bytesCount += 3 +
          DbMoneyDataSchema.estimateSize(
              value, allOffsets[DbMoneyData]!, allOffsets);
    }
  }
  {
    final value = object.numberData;
    if (value != null) {
      bytesCount += 3 +
          DbNumberDataSchema.estimateSize(
              value, allOffsets[DbNumberData]!, allOffsets);
    }
  }
  {
    final value = object.passwordData;
    if (value != null) {
      bytesCount += 3 +
          DbPasswordDataSchema.estimateSize(
              value, allOffsets[DbPasswordData]!, allOffsets);
    }
  }
  {
    final value = object.paymentData;
    if (value != null) {
      bytesCount += 3 +
          DbPaymentDataSchema.estimateSize(
              value, allOffsets[DbPaymentData]!, allOffsets);
    }
  }
  {
    final value = object.phoneData;
    if (value != null) {
      bytesCount += 3 +
          DbPhoneDataSchema.estimateSize(
              value, allOffsets[DbPhoneData]!, allOffsets);
    }
  }
  {
    final value = object.tagsData;
    if (value != null) {
      bytesCount += 3 +
          DbTagsDataSchema.estimateSize(
              value, allOffsets[DbTagsData]!, allOffsets);
    }
  }
  {
    final value = object.textData;
    if (value != null) {
      bytesCount += 3 +
          DbTextDataSchema.estimateSize(
              value, allOffsets[DbTextData]!, allOffsets);
    }
  }
  {
    final value = object.timeData;
    if (value != null) {
      bytesCount += 3 +
          DbTimeDataSchema.estimateSize(
              value, allOffsets[DbTimeData]!, allOffsets);
    }
  }
  {
    final value = object.usernameData;
    if (value != null) {
      bytesCount += 3 +
          DbUsernameDataSchema.estimateSize(
              value, allOffsets[DbUsernameData]!, allOffsets);
    }
  }
  {
    final value = object.websiteData;
    if (value != null) {
      bytesCount += 3 +
          DbWebsiteDataSchema.estimateSize(
              value, allOffsets[DbWebsiteData]!, allOffsets);
    }
  }
  return bytesCount;
}

void _dbFieldSerialize(
  DbField object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<DbAvatarImageData>(
    offsets[0],
    allOffsets,
    DbAvatarImageDataSchema.serialize,
    object.avatarImageData,
  );
  writer.writeObject<DbBooleanData>(
    offsets[1],
    allOffsets,
    DbBooleanDataSchema.serialize,
    object.booleanData,
  );
  writer.writeBool(offsets[2], object.canChangeParameters);
  writer.writeObject<DbDateAndTimeData>(
    offsets[3],
    allOffsets,
    DbDateAndTimeDataSchema.serialize,
    object.dateAndTimeData,
  );
  writer.writeObject<DbDateData>(
    offsets[4],
    allOffsets,
    DbDateDataSchema.serialize,
    object.dateData,
  );
  writer.writeObject<DbDateOfBirthData>(
    offsets[5],
    allOffsets,
    DbDateOfBirthDataSchema.serialize,
    object.dateOfBirthData,
  );
  writer.writeObject<DbEmailData>(
    offsets[6],
    allOffsets,
    DbEmailDataSchema.serialize,
    object.emailData,
  );
  writer.writeObject<DbEmotionData>(
    offsets[7],
    allOffsets,
    DbEmotionDataSchema.serialize,
    object.emotionData,
  );
  writer.writeString(offsets[8], object.fieldId);
  writer.writeString(offsets[9], object.fieldType);
  writer.writeObject<DbFileData>(
    offsets[10],
    allOffsets,
    DbFileDataSchema.serialize,
    object.fileData,
  );
  writer.writeObject<DbImageData>(
    offsets[11],
    allOffsets,
    DbImageDataSchema.serialize,
    object.imageData,
  );
  writer.writeObject<DbLocationData>(
    offsets[12],
    allOffsets,
    DbLocationDataSchema.serialize,
    object.locationData,
  );
  writer.writeObject<DbMeasurementData>(
    offsets[13],
    allOffsets,
    DbMeasurementDataSchema.serialize,
    object.measurementData,
  );
  writer.writeObject<DbMoneyData>(
    offsets[14],
    allOffsets,
    DbMoneyDataSchema.serialize,
    object.moneyData,
  );
  writer.writeObject<DbNumberData>(
    offsets[15],
    allOffsets,
    DbNumberDataSchema.serialize,
    object.numberData,
  );
  writer.writeObject<DbPasswordData>(
    offsets[16],
    allOffsets,
    DbPasswordDataSchema.serialize,
    object.passwordData,
  );
  writer.writeObject<DbPaymentData>(
    offsets[17],
    allOffsets,
    DbPaymentDataSchema.serialize,
    object.paymentData,
  );
  writer.writeObject<DbPhoneData>(
    offsets[18],
    allOffsets,
    DbPhoneDataSchema.serialize,
    object.phoneData,
  );
  writer.writeObject<DbTagsData>(
    offsets[19],
    allOffsets,
    DbTagsDataSchema.serialize,
    object.tagsData,
  );
  writer.writeObject<DbTextData>(
    offsets[20],
    allOffsets,
    DbTextDataSchema.serialize,
    object.textData,
  );
  writer.writeObject<DbTimeData>(
    offsets[21],
    allOffsets,
    DbTimeDataSchema.serialize,
    object.timeData,
  );
  writer.writeObject<DbUsernameData>(
    offsets[22],
    allOffsets,
    DbUsernameDataSchema.serialize,
    object.usernameData,
  );
  writer.writeObject<DbWebsiteData>(
    offsets[23],
    allOffsets,
    DbWebsiteDataSchema.serialize,
    object.websiteData,
  );
}

DbField _dbFieldDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbField(
    avatarImageData: reader.readObjectOrNull<DbAvatarImageData>(
      offsets[0],
      DbAvatarImageDataSchema.deserialize,
      allOffsets,
    ),
    booleanData: reader.readObjectOrNull<DbBooleanData>(
      offsets[1],
      DbBooleanDataSchema.deserialize,
      allOffsets,
    ),
    canChangeParameters: reader.readBoolOrNull(offsets[2]),
    dateAndTimeData: reader.readObjectOrNull<DbDateAndTimeData>(
      offsets[3],
      DbDateAndTimeDataSchema.deserialize,
      allOffsets,
    ),
    dateData: reader.readObjectOrNull<DbDateData>(
      offsets[4],
      DbDateDataSchema.deserialize,
      allOffsets,
    ),
    dateOfBirthData: reader.readObjectOrNull<DbDateOfBirthData>(
      offsets[5],
      DbDateOfBirthDataSchema.deserialize,
      allOffsets,
    ),
    emailData: reader.readObjectOrNull<DbEmailData>(
      offsets[6],
      DbEmailDataSchema.deserialize,
      allOffsets,
    ),
    emotionData: reader.readObjectOrNull<DbEmotionData>(
      offsets[7],
      DbEmotionDataSchema.deserialize,
      allOffsets,
    ),
    fieldId: reader.readStringOrNull(offsets[8]),
    fieldType: reader.readStringOrNull(offsets[9]),
    fileData: reader.readObjectOrNull<DbFileData>(
      offsets[10],
      DbFileDataSchema.deserialize,
      allOffsets,
    ),
    imageData: reader.readObjectOrNull<DbImageData>(
      offsets[11],
      DbImageDataSchema.deserialize,
      allOffsets,
    ),
    locationData: reader.readObjectOrNull<DbLocationData>(
      offsets[12],
      DbLocationDataSchema.deserialize,
      allOffsets,
    ),
    measurementData: reader.readObjectOrNull<DbMeasurementData>(
      offsets[13],
      DbMeasurementDataSchema.deserialize,
      allOffsets,
    ),
    moneyData: reader.readObjectOrNull<DbMoneyData>(
      offsets[14],
      DbMoneyDataSchema.deserialize,
      allOffsets,
    ),
    numberData: reader.readObjectOrNull<DbNumberData>(
      offsets[15],
      DbNumberDataSchema.deserialize,
      allOffsets,
    ),
    passwordData: reader.readObjectOrNull<DbPasswordData>(
      offsets[16],
      DbPasswordDataSchema.deserialize,
      allOffsets,
    ),
    paymentData: reader.readObjectOrNull<DbPaymentData>(
      offsets[17],
      DbPaymentDataSchema.deserialize,
      allOffsets,
    ),
    phoneData: reader.readObjectOrNull<DbPhoneData>(
      offsets[18],
      DbPhoneDataSchema.deserialize,
      allOffsets,
    ),
    tagsData: reader.readObjectOrNull<DbTagsData>(
      offsets[19],
      DbTagsDataSchema.deserialize,
      allOffsets,
    ),
    textData: reader.readObjectOrNull<DbTextData>(
      offsets[20],
      DbTextDataSchema.deserialize,
      allOffsets,
    ),
    timeData: reader.readObjectOrNull<DbTimeData>(
      offsets[21],
      DbTimeDataSchema.deserialize,
      allOffsets,
    ),
    usernameData: reader.readObjectOrNull<DbUsernameData>(
      offsets[22],
      DbUsernameDataSchema.deserialize,
      allOffsets,
    ),
    websiteData: reader.readObjectOrNull<DbWebsiteData>(
      offsets[23],
      DbWebsiteDataSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _dbFieldDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<DbAvatarImageData>(
        offset,
        DbAvatarImageDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectOrNull<DbBooleanData>(
        offset,
        DbBooleanDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<DbDateAndTimeData>(
        offset,
        DbDateAndTimeDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readObjectOrNull<DbDateData>(
        offset,
        DbDateDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 5:
      return (reader.readObjectOrNull<DbDateOfBirthData>(
        offset,
        DbDateOfBirthDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 6:
      return (reader.readObjectOrNull<DbEmailData>(
        offset,
        DbEmailDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 7:
      return (reader.readObjectOrNull<DbEmotionData>(
        offset,
        DbEmotionDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readObjectOrNull<DbFileData>(
        offset,
        DbFileDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 11:
      return (reader.readObjectOrNull<DbImageData>(
        offset,
        DbImageDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 12:
      return (reader.readObjectOrNull<DbLocationData>(
        offset,
        DbLocationDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 13:
      return (reader.readObjectOrNull<DbMeasurementData>(
        offset,
        DbMeasurementDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 14:
      return (reader.readObjectOrNull<DbMoneyData>(
        offset,
        DbMoneyDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 15:
      return (reader.readObjectOrNull<DbNumberData>(
        offset,
        DbNumberDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 16:
      return (reader.readObjectOrNull<DbPasswordData>(
        offset,
        DbPasswordDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 17:
      return (reader.readObjectOrNull<DbPaymentData>(
        offset,
        DbPaymentDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 18:
      return (reader.readObjectOrNull<DbPhoneData>(
        offset,
        DbPhoneDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 19:
      return (reader.readObjectOrNull<DbTagsData>(
        offset,
        DbTagsDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 20:
      return (reader.readObjectOrNull<DbTextData>(
        offset,
        DbTextDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 21:
      return (reader.readObjectOrNull<DbTimeData>(
        offset,
        DbTimeDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 22:
      return (reader.readObjectOrNull<DbUsernameData>(
        offset,
        DbUsernameDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 23:
      return (reader.readObjectOrNull<DbWebsiteData>(
        offset,
        DbWebsiteDataSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbFieldQueryFilter
    on QueryBuilder<DbField, DbField, QFilterCondition> {
  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      avatarImageDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarImageData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      avatarImageDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarImageData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> booleanDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'booleanData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> booleanDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'booleanData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      canChangeParametersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'canChangeParameters',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      canChangeParametersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'canChangeParameters',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      canChangeParametersEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'canChangeParameters',
        value: value,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      dateAndTimeDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateAndTimeData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      dateAndTimeDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateAndTimeData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> dateDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> dateDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      dateOfBirthDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateOfBirthData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      dateOfBirthDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateOfBirthData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> emailDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emailData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> emailDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emailData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> emotionDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emotionData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> emotionDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emotionData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fieldId',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fieldId',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fieldId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fieldId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fieldId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fieldId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fieldId',
        value: '',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fieldType',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fieldType',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fieldType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fieldType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fieldType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fieldType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fieldType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fieldType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fieldType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fieldType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fieldType',
        value: '',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fieldTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fieldType',
        value: '',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fileDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fileDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> imageDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> imageDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> locationDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locationData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      locationDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locationData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      measurementDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'measurementData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      measurementDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'measurementData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> moneyDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'moneyData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> moneyDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'moneyData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> numberDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numberData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> numberDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numberData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> passwordDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'passwordData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      passwordDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'passwordData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> paymentDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> paymentDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> phoneDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phoneData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> phoneDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phoneData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> tagsDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagsData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> tagsDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagsData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> textDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> textDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> timeDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> timeDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> usernameDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'usernameData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition>
      usernameDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'usernameData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> websiteDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'websiteData',
      ));
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> websiteDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'websiteData',
      ));
    });
  }
}

extension DbFieldQueryObject
    on QueryBuilder<DbField, DbField, QFilterCondition> {
  QueryBuilder<DbField, DbField, QAfterFilterCondition> avatarImageData(
      FilterQuery<DbAvatarImageData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'avatarImageData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> booleanData(
      FilterQuery<DbBooleanData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'booleanData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> dateAndTimeData(
      FilterQuery<DbDateAndTimeData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'dateAndTimeData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> dateData(
      FilterQuery<DbDateData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'dateData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> dateOfBirthData(
      FilterQuery<DbDateOfBirthData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'dateOfBirthData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> emailData(
      FilterQuery<DbEmailData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'emailData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> emotionData(
      FilterQuery<DbEmotionData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'emotionData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> fileData(
      FilterQuery<DbFileData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fileData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> imageData(
      FilterQuery<DbImageData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'imageData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> locationData(
      FilterQuery<DbLocationData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'locationData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> measurementData(
      FilterQuery<DbMeasurementData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'measurementData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> moneyData(
      FilterQuery<DbMoneyData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'moneyData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> numberData(
      FilterQuery<DbNumberData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'numberData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> passwordData(
      FilterQuery<DbPasswordData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'passwordData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> paymentData(
      FilterQuery<DbPaymentData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'paymentData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> phoneData(
      FilterQuery<DbPhoneData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'phoneData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> tagsData(
      FilterQuery<DbTagsData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'tagsData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> textData(
      FilterQuery<DbTextData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'textData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> timeData(
      FilterQuery<DbTimeData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'timeData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> usernameData(
      FilterQuery<DbUsernameData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'usernameData');
    });
  }

  QueryBuilder<DbField, DbField, QAfterFilterCondition> websiteData(
      FilterQuery<DbWebsiteData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'websiteData');
    });
  }
}
