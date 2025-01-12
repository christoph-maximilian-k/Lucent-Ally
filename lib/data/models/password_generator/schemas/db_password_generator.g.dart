// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_password_generator.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbPasswordGeneratorSchema = Schema(
  name: r'DbPasswordGenerator',
  id: 2713268940636105181,
  properties: {
    r'maxPasswordLength': PropertySchema(
      id: 0,
      name: r'maxPasswordLength',
      type: IsarType.long,
    ),
    r'minPasswordLength': PropertySchema(
      id: 1,
      name: r'minPasswordLength',
      type: IsarType.long,
    ),
    r'passwordLength': PropertySchema(
      id: 2,
      name: r'passwordLength',
      type: IsarType.long,
    ),
    r'usesLowerCase': PropertySchema(
      id: 3,
      name: r'usesLowerCase',
      type: IsarType.bool,
    ),
    r'usesNumbers': PropertySchema(
      id: 4,
      name: r'usesNumbers',
      type: IsarType.bool,
    ),
    r'usesSymbols': PropertySchema(
      id: 5,
      name: r'usesSymbols',
      type: IsarType.bool,
    ),
    r'usesUpperCase': PropertySchema(
      id: 6,
      name: r'usesUpperCase',
      type: IsarType.bool,
    ),
    r'usesUuid': PropertySchema(
      id: 7,
      name: r'usesUuid',
      type: IsarType.bool,
    )
  },
  estimateSize: _dbPasswordGeneratorEstimateSize,
  serialize: _dbPasswordGeneratorSerialize,
  deserialize: _dbPasswordGeneratorDeserialize,
  deserializeProp: _dbPasswordGeneratorDeserializeProp,
);

int _dbPasswordGeneratorEstimateSize(
  DbPasswordGenerator object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dbPasswordGeneratorSerialize(
  DbPasswordGenerator object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.maxPasswordLength);
  writer.writeLong(offsets[1], object.minPasswordLength);
  writer.writeLong(offsets[2], object.passwordLength);
  writer.writeBool(offsets[3], object.usesLowerCase);
  writer.writeBool(offsets[4], object.usesNumbers);
  writer.writeBool(offsets[5], object.usesSymbols);
  writer.writeBool(offsets[6], object.usesUpperCase);
  writer.writeBool(offsets[7], object.usesUuid);
}

DbPasswordGenerator _dbPasswordGeneratorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbPasswordGenerator(
    maxPasswordLength: reader.readLongOrNull(offsets[0]),
    minPasswordLength: reader.readLongOrNull(offsets[1]),
    passwordLength: reader.readLongOrNull(offsets[2]),
    usesLowerCase: reader.readBoolOrNull(offsets[3]),
    usesNumbers: reader.readBoolOrNull(offsets[4]),
    usesSymbols: reader.readBoolOrNull(offsets[5]),
    usesUpperCase: reader.readBoolOrNull(offsets[6]),
    usesUuid: reader.readBoolOrNull(offsets[7]),
  );
  return object;
}

P _dbPasswordGeneratorDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbPasswordGeneratorQueryFilter on QueryBuilder<DbPasswordGenerator,
    DbPasswordGenerator, QFilterCondition> {
  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      maxPasswordLengthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxPasswordLength',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      maxPasswordLengthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxPasswordLength',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      maxPasswordLengthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxPasswordLength',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      maxPasswordLengthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxPasswordLength',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      maxPasswordLengthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxPasswordLength',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      maxPasswordLengthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxPasswordLength',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      minPasswordLengthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minPasswordLength',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      minPasswordLengthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minPasswordLength',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      minPasswordLengthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minPasswordLength',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      minPasswordLengthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minPasswordLength',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      minPasswordLengthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minPasswordLength',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      minPasswordLengthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minPasswordLength',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      passwordLengthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'passwordLength',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      passwordLengthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'passwordLength',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      passwordLengthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passwordLength',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      passwordLengthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'passwordLength',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      passwordLengthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'passwordLength',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      passwordLengthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'passwordLength',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesLowerCaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'usesLowerCase',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesLowerCaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'usesLowerCase',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesLowerCaseEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usesLowerCase',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesNumbersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'usesNumbers',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesNumbersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'usesNumbers',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesNumbersEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usesNumbers',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesSymbolsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'usesSymbols',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesSymbolsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'usesSymbols',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesSymbolsEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usesSymbols',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesUpperCaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'usesUpperCase',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesUpperCaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'usesUpperCase',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesUpperCaseEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usesUpperCase',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesUuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'usesUuid',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesUuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'usesUuid',
      ));
    });
  }

  QueryBuilder<DbPasswordGenerator, DbPasswordGenerator, QAfterFilterCondition>
      usesUuidEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usesUuid',
        value: value,
      ));
    });
  }
}

extension DbPasswordGeneratorQueryObject on QueryBuilder<DbPasswordGenerator,
    DbPasswordGenerator, QFilterCondition> {}
