// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_emotion_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbEmotionDataSchema = Schema(
  name: r'DbEmotionData',
  id: 660795483651311581,
  properties: {
    r'emotions': PropertySchema(
      id: 0,
      name: r'emotions',
      type: IsarType.objectList,
      target: r'DbEmotionItem',
    ),
    r'encryptedEmotions': PropertySchema(
      id: 1,
      name: r'encryptedEmotions',
      type: IsarType.byteList,
    ),
    r'encryptedIntensities': PropertySchema(
      id: 2,
      name: r'encryptedIntensities',
      type: IsarType.byteList,
    ),
    r'encryptedOccurrences': PropertySchema(
      id: 3,
      name: r'encryptedOccurrences',
      type: IsarType.byteList,
    ),
    r'encryptedTimezones': PropertySchema(
      id: 4,
      name: r'encryptedTimezones',
      type: IsarType.byteList,
    ),
    r'importReferenceEmotion': PropertySchema(
      id: 5,
      name: r'importReferenceEmotion',
      type: IsarType.string,
    ),
    r'importReferenceIntensity': PropertySchema(
      id: 6,
      name: r'importReferenceIntensity',
      type: IsarType.string,
    ),
    r'importReferenceOccurrence': PropertySchema(
      id: 7,
      name: r'importReferenceOccurrence',
      type: IsarType.string,
    )
  },
  estimateSize: _dbEmotionDataEstimateSize,
  serialize: _dbEmotionDataSerialize,
  deserialize: _dbEmotionDataDeserialize,
  deserializeProp: _dbEmotionDataDeserializeProp,
);

int _dbEmotionDataEstimateSize(
  DbEmotionData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.emotions;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DbEmotionItem]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              DbEmotionItemSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.encryptedEmotions;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.encryptedIntensities;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.encryptedOccurrences;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.encryptedTimezones;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.importReferenceEmotion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceIntensity;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceOccurrence;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dbEmotionDataSerialize(
  DbEmotionData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<DbEmotionItem>(
    offsets[0],
    allOffsets,
    DbEmotionItemSchema.serialize,
    object.emotions,
  );
  writer.writeByteList(offsets[1], object.encryptedEmotions);
  writer.writeByteList(offsets[2], object.encryptedIntensities);
  writer.writeByteList(offsets[3], object.encryptedOccurrences);
  writer.writeByteList(offsets[4], object.encryptedTimezones);
  writer.writeString(offsets[5], object.importReferenceEmotion);
  writer.writeString(offsets[6], object.importReferenceIntensity);
  writer.writeString(offsets[7], object.importReferenceOccurrence);
}

DbEmotionData _dbEmotionDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbEmotionData(
    emotions: reader.readObjectList<DbEmotionItem>(
      offsets[0],
      DbEmotionItemSchema.deserialize,
      allOffsets,
      DbEmotionItem(),
    ),
    encryptedEmotions: reader.readByteList(offsets[1]),
    encryptedIntensities: reader.readByteList(offsets[2]),
    encryptedOccurrences: reader.readByteList(offsets[3]),
    encryptedTimezones: reader.readByteList(offsets[4]),
    importReferenceEmotion: reader.readStringOrNull(offsets[5]),
    importReferenceIntensity: reader.readStringOrNull(offsets[6]),
    importReferenceOccurrence: reader.readStringOrNull(offsets[7]),
  );
  return object;
}

P _dbEmotionDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<DbEmotionItem>(
        offset,
        DbEmotionItemSchema.deserialize,
        allOffsets,
        DbEmotionItem(),
      )) as P;
    case 1:
      return (reader.readByteList(offset)) as P;
    case 2:
      return (reader.readByteList(offset)) as P;
    case 3:
      return (reader.readByteList(offset)) as P;
    case 4:
      return (reader.readByteList(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbEmotionDataQueryFilter
    on QueryBuilder<DbEmotionData, DbEmotionData, QFilterCondition> {
  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      emotionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emotions',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      emotionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emotions',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      emotionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      emotionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      emotionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      emotionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      emotionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      emotionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emotions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedEmotions',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedEmotions',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedEmotions',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedEmotions',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedEmotions',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedEmotions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedEmotions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedEmotions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedEmotions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedEmotions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedEmotions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedEmotionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedEmotions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedIntensities',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedIntensities',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedIntensities',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedIntensities',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedIntensities',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedIntensities',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedIntensities',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedIntensities',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedIntensities',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedIntensities',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedIntensities',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedIntensitiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedIntensities',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedOccurrences',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedOccurrences',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedOccurrences',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedOccurrences',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedOccurrences',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedOccurrences',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedOccurrences',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedOccurrences',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedOccurrences',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedOccurrences',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedOccurrences',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedOccurrencesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedOccurrences',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedTimezones',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedTimezones',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedTimezones',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedTimezones',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedTimezones',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedTimezones',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTimezones',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTimezones',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTimezones',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTimezones',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTimezones',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      encryptedTimezonesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTimezones',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceEmotion',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceEmotion',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceEmotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceEmotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceEmotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceEmotion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceEmotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceEmotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceEmotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceEmotion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceEmotion',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceEmotionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceEmotion',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceIntensity',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceIntensity',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceIntensity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceIntensity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceIntensity',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceIntensityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceIntensity',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceOccurrence',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceOccurrence',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceOccurrence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceOccurrence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceOccurrence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceOccurrence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceOccurrence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceOccurrence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceOccurrence',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceOccurrence',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceOccurrence',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      importReferenceOccurrenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceOccurrence',
        value: '',
      ));
    });
  }
}

extension DbEmotionDataQueryObject
    on QueryBuilder<DbEmotionData, DbEmotionData, QFilterCondition> {
  QueryBuilder<DbEmotionData, DbEmotionData, QAfterFilterCondition>
      emotionsElement(FilterQuery<DbEmotionItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'emotions');
    });
  }
}
