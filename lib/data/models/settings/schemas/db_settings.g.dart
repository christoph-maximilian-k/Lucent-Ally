// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_settings.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbSettingsSchema = Schema(
  name: r'DbSettings',
  id: 1097994837175927760,
  properties: {
    r'acceptedTermsAndConditions': PropertySchema(
      id: 0,
      name: r'acceptedTermsAndConditions',
      type: IsarType.bool,
    ),
    r'defaultCurrency': PropertySchema(
      id: 1,
      name: r'defaultCurrency',
      type: IsarType.string,
    ),
    r'maxLinesForTextFields': PropertySchema(
      id: 2,
      name: r'maxLinesForTextFields',
      type: IsarType.long,
    ),
    r'notificationDurationInSeconds': PropertySchema(
      id: 3,
      name: r'notificationDurationInSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _dbSettingsEstimateSize,
  serialize: _dbSettingsSerialize,
  deserialize: _dbSettingsDeserialize,
  deserializeProp: _dbSettingsDeserializeProp,
);

int _dbSettingsEstimateSize(
  DbSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.defaultCurrency;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dbSettingsSerialize(
  DbSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.acceptedTermsAndConditions);
  writer.writeString(offsets[1], object.defaultCurrency);
  writer.writeLong(offsets[2], object.maxLinesForTextFields);
  writer.writeLong(offsets[3], object.notificationDurationInSeconds);
}

DbSettings _dbSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbSettings(
    acceptedTermsAndConditions: reader.readBoolOrNull(offsets[0]),
    defaultCurrency: reader.readStringOrNull(offsets[1]),
    maxLinesForTextFields: reader.readLongOrNull(offsets[2]),
    notificationDurationInSeconds: reader.readLongOrNull(offsets[3]),
  );
  return object;
}

P _dbSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbSettingsQueryFilter
    on QueryBuilder<DbSettings, DbSettings, QFilterCondition> {
  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      acceptedTermsAndConditionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'acceptedTermsAndConditions',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      acceptedTermsAndConditionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'acceptedTermsAndConditions',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      acceptedTermsAndConditionsEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acceptedTermsAndConditions',
        value: value,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defaultCurrency',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defaultCurrency',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      defaultCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      maxLinesForTextFieldsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxLinesForTextFields',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      maxLinesForTextFieldsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxLinesForTextFields',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      maxLinesForTextFieldsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxLinesForTextFields',
        value: value,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      maxLinesForTextFieldsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxLinesForTextFields',
        value: value,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      maxLinesForTextFieldsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxLinesForTextFields',
        value: value,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      maxLinesForTextFieldsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxLinesForTextFields',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      notificationDurationInSecondsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationDurationInSeconds',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      notificationDurationInSecondsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationDurationInSeconds',
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      notificationDurationInSecondsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      notificationDurationInSecondsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      notificationDurationInSecondsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationDurationInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<DbSettings, DbSettings, QAfterFilterCondition>
      notificationDurationInSecondsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationDurationInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DbSettingsQueryObject
    on QueryBuilder<DbSettings, DbSettings, QFilterCondition> {}
