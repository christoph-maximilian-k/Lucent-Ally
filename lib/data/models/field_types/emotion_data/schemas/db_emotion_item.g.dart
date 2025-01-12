// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_emotion_item.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbEmotionItemSchema = Schema(
  name: r'DbEmotionItem',
  id: -4192886206892351726,
  properties: {
    r'emotion': PropertySchema(
      id: 0,
      name: r'emotion',
      type: IsarType.string,
    ),
    r'intensity': PropertySchema(
      id: 1,
      name: r'intensity',
      type: IsarType.long,
    ),
    r'occurrenceInUtc': PropertySchema(
      id: 2,
      name: r'occurrenceInUtc',
      type: IsarType.long,
    ),
    r'occurrenceTimeZone': PropertySchema(
      id: 3,
      name: r'occurrenceTimeZone',
      type: IsarType.string,
    )
  },
  estimateSize: _dbEmotionItemEstimateSize,
  serialize: _dbEmotionItemSerialize,
  deserialize: _dbEmotionItemDeserialize,
  deserializeProp: _dbEmotionItemDeserializeProp,
);

int _dbEmotionItemEstimateSize(
  DbEmotionItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.emotion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.occurrenceTimeZone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dbEmotionItemSerialize(
  DbEmotionItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.emotion);
  writer.writeLong(offsets[1], object.intensity);
  writer.writeLong(offsets[2], object.occurrenceInUtc);
  writer.writeString(offsets[3], object.occurrenceTimeZone);
}

DbEmotionItem _dbEmotionItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbEmotionItem(
    emotion: reader.readStringOrNull(offsets[0]),
    intensity: reader.readLongOrNull(offsets[1]),
    occurrenceInUtc: reader.readLongOrNull(offsets[2]),
    occurrenceTimeZone: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _dbEmotionItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbEmotionItemQueryFilter
    on QueryBuilder<DbEmotionItem, DbEmotionItem, QFilterCondition> {
  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emotion',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emotion',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emotion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emotion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emotion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emotion',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      emotionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emotion',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      intensityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intensity',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      intensityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intensity',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      intensityEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intensity',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      intensityGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intensity',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      intensityLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intensity',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      intensityBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intensity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceInUtcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'occurrenceInUtc',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceInUtcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'occurrenceInUtc',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceInUtcEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'occurrenceInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceInUtcGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'occurrenceInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceInUtcLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'occurrenceInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceInUtcBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'occurrenceInUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'occurrenceTimeZone',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'occurrenceTimeZone',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'occurrenceTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'occurrenceTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'occurrenceTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'occurrenceTimeZone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'occurrenceTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'occurrenceTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'occurrenceTimeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'occurrenceTimeZone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'occurrenceTimeZone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbEmotionItem, DbEmotionItem, QAfterFilterCondition>
      occurrenceTimeZoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'occurrenceTimeZone',
        value: '',
      ));
    });
  }
}

extension DbEmotionItemQueryObject
    on QueryBuilder<DbEmotionItem, DbEmotionItem, QFilterCondition> {}
