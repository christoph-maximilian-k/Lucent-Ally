// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_import_specifications.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbImportSpecificationsSchema = Schema(
  name: r'DbImportSpecifications',
  id: 476271240613513946,
  properties: {
    r'createdAtInstruction': PropertySchema(
      id: 0,
      name: r'createdAtInstruction',
      type: IsarType.string,
    ),
    r'entryNameDefault': PropertySchema(
      id: 1,
      name: r'entryNameDefault',
      type: IsarType.string,
    ),
    r'entryNameInstruction': PropertySchema(
      id: 2,
      name: r'entryNameInstruction',
      type: IsarType.string,
    ),
    r'fields': PropertySchema(
      id: 3,
      name: r'fields',
      type: IsarType.object,
      target: r'DbFields',
    ),
    r'invalidValueRule': PropertySchema(
      id: 4,
      name: r'invalidValueRule',
      type: IsarType.string,
    ),
    r'missingValueRule': PropertySchema(
      id: 5,
      name: r'missingValueRule',
      type: IsarType.string,
    )
  },
  estimateSize: _dbImportSpecificationsEstimateSize,
  serialize: _dbImportSpecificationsSerialize,
  deserialize: _dbImportSpecificationsDeserialize,
  deserializeProp: _dbImportSpecificationsDeserializeProp,
);

int _dbImportSpecificationsEstimateSize(
  DbImportSpecifications object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.createdAtInstruction;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.entryNameDefault;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.entryNameInstruction;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fields;
    if (value != null) {
      bytesCount += 3 +
          DbFieldsSchema.estimateSize(value, allOffsets[DbFields]!, allOffsets);
    }
  }
  {
    final value = object.invalidValueRule;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.missingValueRule;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _dbImportSpecificationsSerialize(
  DbImportSpecifications object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.createdAtInstruction);
  writer.writeString(offsets[1], object.entryNameDefault);
  writer.writeString(offsets[2], object.entryNameInstruction);
  writer.writeObject<DbFields>(
    offsets[3],
    allOffsets,
    DbFieldsSchema.serialize,
    object.fields,
  );
  writer.writeString(offsets[4], object.invalidValueRule);
  writer.writeString(offsets[5], object.missingValueRule);
}

DbImportSpecifications _dbImportSpecificationsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbImportSpecifications(
    createdAtInstruction: reader.readStringOrNull(offsets[0]),
    entryNameDefault: reader.readStringOrNull(offsets[1]),
    entryNameInstruction: reader.readStringOrNull(offsets[2]),
    fields: reader.readObjectOrNull<DbFields>(
      offsets[3],
      DbFieldsSchema.deserialize,
      allOffsets,
    ),
    invalidValueRule: reader.readStringOrNull(offsets[4]),
    missingValueRule: reader.readStringOrNull(offsets[5]),
  );
  return object;
}

P _dbImportSpecificationsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<DbFields>(
        offset,
        DbFieldsSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbImportSpecificationsQueryFilter on QueryBuilder<
    DbImportSpecifications, DbImportSpecifications, QFilterCondition> {
  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAtInstruction',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAtInstruction',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtInstruction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAtInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAtInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      createdAtInstructionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAtInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      createdAtInstructionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAtInstruction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtInstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> createdAtInstructionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAtInstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'entryNameDefault',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'entryNameDefault',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryNameDefault',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryNameDefault',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryNameDefault',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryNameDefault',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entryNameDefault',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entryNameDefault',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      entryNameDefaultContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entryNameDefault',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      entryNameDefaultMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entryNameDefault',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryNameDefault',
        value: '',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameDefaultIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entryNameDefault',
        value: '',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'entryNameInstruction',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'entryNameInstruction',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryNameInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryNameInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryNameInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryNameInstruction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entryNameInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entryNameInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      entryNameInstructionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entryNameInstruction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      entryNameInstructionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entryNameInstruction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryNameInstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> entryNameInstructionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entryNameInstruction',
        value: '',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> fieldsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fields',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> fieldsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fields',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'invalidValueRule',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'invalidValueRule',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invalidValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invalidValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invalidValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invalidValueRule',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'invalidValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'invalidValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      invalidValueRuleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'invalidValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      invalidValueRuleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'invalidValueRule',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invalidValueRule',
        value: '',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> invalidValueRuleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'invalidValueRule',
        value: '',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'missingValueRule',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'missingValueRule',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'missingValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'missingValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'missingValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'missingValueRule',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'missingValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'missingValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      missingValueRuleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'missingValueRule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
          QAfterFilterCondition>
      missingValueRuleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'missingValueRule',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'missingValueRule',
        value: '',
      ));
    });
  }

  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> missingValueRuleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'missingValueRule',
        value: '',
      ));
    });
  }
}

extension DbImportSpecificationsQueryObject on QueryBuilder<
    DbImportSpecifications, DbImportSpecifications, QFilterCondition> {
  QueryBuilder<DbImportSpecifications, DbImportSpecifications,
      QAfterFilterCondition> fields(FilterQuery<DbFields> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fields');
    });
  }
}
