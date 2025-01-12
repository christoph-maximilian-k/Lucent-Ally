// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_payment_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbPaymentDataSchema = Schema(
  name: r'DbPaymentData',
  id: 3931104896425683335,
  properties: {
    r'currencyCode': PropertySchema(
      id: 0,
      name: r'currencyCode',
      type: IsarType.string,
    ),
    r'customExchangeRates': PropertySchema(
      id: 1,
      name: r'customExchangeRates',
      type: IsarType.string,
    ),
    r'distributeEqually': PropertySchema(
      id: 2,
      name: r'distributeEqually',
      type: IsarType.bool,
    ),
    r'encryptedCurrency': PropertySchema(
      id: 3,
      name: r'encryptedCurrency',
      type: IsarType.byteList,
    ),
    r'encryptedPaymentDate': PropertySchema(
      id: 4,
      name: r'encryptedPaymentDate',
      type: IsarType.byteList,
    ),
    r'encryptedShareReferences': PropertySchema(
      id: 5,
      name: r'encryptedShareReferences',
      type: IsarType.byteList,
    ),
    r'encryptedTotal': PropertySchema(
      id: 6,
      name: r'encryptedTotal',
      type: IsarType.byteList,
    ),
    r'importReferenceExchangeRate': PropertySchema(
      id: 7,
      name: r'importReferenceExchangeRate',
      type: IsarType.string,
    ),
    r'importReferenceForceMemberValueImport': PropertySchema(
      id: 8,
      name: r'importReferenceForceMemberValueImport',
      type: IsarType.bool,
    ),
    r'importReferenceIsCompensated': PropertySchema(
      id: 9,
      name: r'importReferenceIsCompensated',
      type: IsarType.string,
    ),
    r'importReferencePaidById': PropertySchema(
      id: 10,
      name: r'importReferencePaidById',
      type: IsarType.string,
    ),
    r'importReferencePaymentDate': PropertySchema(
      id: 11,
      name: r'importReferencePaymentDate',
      type: IsarType.string,
    ),
    r'importReferenceTags': PropertySchema(
      id: 12,
      name: r'importReferenceTags',
      type: IsarType.string,
    ),
    r'importReferenceTotalCurrency': PropertySchema(
      id: 13,
      name: r'importReferenceTotalCurrency',
      type: IsarType.string,
    ),
    r'importReferenceTotalValue': PropertySchema(
      id: 14,
      name: r'importReferenceTotalValue',
      type: IsarType.string,
    ),
    r'importReferencesMembers': PropertySchema(
      id: 15,
      name: r'importReferencesMembers',
      type: IsarType.objectList,
      target: r'DbMemberToImportReference',
    ),
    r'isCompensated': PropertySchema(
      id: 16,
      name: r'isCompensated',
      type: IsarType.bool,
    ),
    r'paidById': PropertySchema(
      id: 17,
      name: r'paidById',
      type: IsarType.string,
    ),
    r'participantReference': PropertySchema(
      id: 18,
      name: r'participantReference',
      type: IsarType.string,
    ),
    r'paymentDateDefaultDate': PropertySchema(
      id: 19,
      name: r'paymentDateDefaultDate',
      type: IsarType.string,
    ),
    r'paymentDateDefaultTime': PropertySchema(
      id: 20,
      name: r'paymentDateDefaultTime',
      type: IsarType.string,
    ),
    r'paymentDateInUtc': PropertySchema(
      id: 21,
      name: r'paymentDateInUtc',
      type: IsarType.long,
    ),
    r'paymentDateTimezone': PropertySchema(
      id: 22,
      name: r'paymentDateTimezone',
      type: IsarType.string,
    ),
    r'shareReferences': PropertySchema(
      id: 23,
      name: r'shareReferences',
      type: IsarType.objectList,
      target: r'DbShareReference',
    ),
    r'tagsData': PropertySchema(
      id: 24,
      name: r'tagsData',
      type: IsarType.object,
      target: r'DbTagsData',
    ),
    r'total': PropertySchema(
      id: 25,
      name: r'total',
      type: IsarType.double,
    )
  },
  estimateSize: _dbPaymentDataEstimateSize,
  serialize: _dbPaymentDataSerialize,
  deserialize: _dbPaymentDataDeserialize,
  deserializeProp: _dbPaymentDataDeserializeProp,
);

int _dbPaymentDataEstimateSize(
  DbPaymentData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.currencyCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.customExchangeRates;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.encryptedCurrency;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.encryptedPaymentDate;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.encryptedShareReferences;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.encryptedTotal;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  {
    final value = object.importReferenceExchangeRate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceIsCompensated;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferencePaidById;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferencePaymentDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceTags;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceTotalCurrency;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importReferenceTotalValue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.importReferencesMembers;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DbMemberToImportReference]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += DbMemberToImportReferenceSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.paidById;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.participantReference;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentDateDefaultDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentDateDefaultTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentDateTimezone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.shareReferences;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DbShareReference]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              DbShareReferenceSchema.estimateSize(value, offsets, allOffsets);
        }
      }
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
  return bytesCount;
}

void _dbPaymentDataSerialize(
  DbPaymentData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.currencyCode);
  writer.writeString(offsets[1], object.customExchangeRates);
  writer.writeBool(offsets[2], object.distributeEqually);
  writer.writeByteList(offsets[3], object.encryptedCurrency);
  writer.writeByteList(offsets[4], object.encryptedPaymentDate);
  writer.writeByteList(offsets[5], object.encryptedShareReferences);
  writer.writeByteList(offsets[6], object.encryptedTotal);
  writer.writeString(offsets[7], object.importReferenceExchangeRate);
  writer.writeBool(offsets[8], object.importReferenceForceMemberValueImport);
  writer.writeString(offsets[9], object.importReferenceIsCompensated);
  writer.writeString(offsets[10], object.importReferencePaidById);
  writer.writeString(offsets[11], object.importReferencePaymentDate);
  writer.writeString(offsets[12], object.importReferenceTags);
  writer.writeString(offsets[13], object.importReferenceTotalCurrency);
  writer.writeString(offsets[14], object.importReferenceTotalValue);
  writer.writeObjectList<DbMemberToImportReference>(
    offsets[15],
    allOffsets,
    DbMemberToImportReferenceSchema.serialize,
    object.importReferencesMembers,
  );
  writer.writeBool(offsets[16], object.isCompensated);
  writer.writeString(offsets[17], object.paidById);
  writer.writeString(offsets[18], object.participantReference);
  writer.writeString(offsets[19], object.paymentDateDefaultDate);
  writer.writeString(offsets[20], object.paymentDateDefaultTime);
  writer.writeLong(offsets[21], object.paymentDateInUtc);
  writer.writeString(offsets[22], object.paymentDateTimezone);
  writer.writeObjectList<DbShareReference>(
    offsets[23],
    allOffsets,
    DbShareReferenceSchema.serialize,
    object.shareReferences,
  );
  writer.writeObject<DbTagsData>(
    offsets[24],
    allOffsets,
    DbTagsDataSchema.serialize,
    object.tagsData,
  );
  writer.writeDouble(offsets[25], object.total);
}

DbPaymentData _dbPaymentDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbPaymentData(
    currencyCode: reader.readStringOrNull(offsets[0]),
    customExchangeRates: reader.readStringOrNull(offsets[1]),
    distributeEqually: reader.readBoolOrNull(offsets[2]),
    encryptedCurrency: reader.readByteList(offsets[3]),
    encryptedPaymentDate: reader.readByteList(offsets[4]),
    encryptedShareReferences: reader.readByteList(offsets[5]),
    encryptedTotal: reader.readByteList(offsets[6]),
    importReferenceExchangeRate: reader.readStringOrNull(offsets[7]),
    importReferenceForceMemberValueImport: reader.readBoolOrNull(offsets[8]),
    importReferenceIsCompensated: reader.readStringOrNull(offsets[9]),
    importReferencePaidById: reader.readStringOrNull(offsets[10]),
    importReferencePaymentDate: reader.readStringOrNull(offsets[11]),
    importReferenceTags: reader.readStringOrNull(offsets[12]),
    importReferenceTotalCurrency: reader.readStringOrNull(offsets[13]),
    importReferenceTotalValue: reader.readStringOrNull(offsets[14]),
    importReferencesMembers: reader.readObjectList<DbMemberToImportReference>(
      offsets[15],
      DbMemberToImportReferenceSchema.deserialize,
      allOffsets,
      DbMemberToImportReference(),
    ),
    isCompensated: reader.readBoolOrNull(offsets[16]),
    paidById: reader.readStringOrNull(offsets[17]),
    participantReference: reader.readStringOrNull(offsets[18]),
    paymentDateDefaultDate: reader.readStringOrNull(offsets[19]),
    paymentDateDefaultTime: reader.readStringOrNull(offsets[20]),
    paymentDateInUtc: reader.readLongOrNull(offsets[21]),
    paymentDateTimezone: reader.readStringOrNull(offsets[22]),
    shareReferences: reader.readObjectList<DbShareReference>(
      offsets[23],
      DbShareReferenceSchema.deserialize,
      allOffsets,
      DbShareReference(),
    ),
    tagsData: reader.readObjectOrNull<DbTagsData>(
      offsets[24],
      DbTagsDataSchema.deserialize,
      allOffsets,
    ),
    total: reader.readDoubleOrNull(offsets[25]),
  );
  return object;
}

P _dbPaymentDataDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readByteList(offset)) as P;
    case 4:
      return (reader.readByteList(offset)) as P;
    case 5:
      return (reader.readByteList(offset)) as P;
    case 6:
      return (reader.readByteList(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readObjectList<DbMemberToImportReference>(
        offset,
        DbMemberToImportReferenceSchema.deserialize,
        allOffsets,
        DbMemberToImportReference(),
      )) as P;
    case 16:
      return (reader.readBoolOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readObjectList<DbShareReference>(
        offset,
        DbShareReferenceSchema.deserialize,
        allOffsets,
        DbShareReference(),
      )) as P;
    case 24:
      return (reader.readObjectOrNull<DbTagsData>(
        offset,
        DbTagsDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 25:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbPaymentDataQueryFilter
    on QueryBuilder<DbPaymentData, DbPaymentData, QFilterCondition> {
  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currencyCode',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currencyCode',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currencyCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currencyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currencyCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currencyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      currencyCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currencyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customExchangeRates',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customExchangeRates',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customExchangeRates',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customExchangeRates',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customExchangeRates',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customExchangeRates',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      customExchangeRatesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customExchangeRates',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      distributeEquallyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'distributeEqually',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      distributeEquallyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'distributeEqually',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      distributeEquallyEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distributeEqually',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedCurrency',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedCurrency',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedCurrency',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedCurrency',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedCurrency',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedCurrencyLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedCurrency',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedPaymentDate',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedPaymentDate',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedPaymentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedPaymentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedPaymentDate',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedPaymentDate',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedPaymentDate',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedPaymentDate',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedPaymentDate',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedPaymentDateLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedPaymentDate',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedShareReferences',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedShareReferences',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedShareReferences',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedShareReferences',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedShareReferences',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedShareReferences',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedShareReferences',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedShareReferences',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedShareReferences',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedShareReferences',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedShareReferences',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedShareReferencesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedShareReferences',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptedTotal',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptedTotal',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptedTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptedTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptedTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptedTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTotal',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTotal',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTotal',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTotal',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTotal',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      encryptedTotalLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'encryptedTotal',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceExchangeRate',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceExchangeRate',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceExchangeRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceExchangeRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceExchangeRate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceExchangeRate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceExchangeRateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceExchangeRate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceForceMemberValueImportIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceForceMemberValueImport',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceForceMemberValueImportIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceForceMemberValueImport',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceForceMemberValueImportEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceForceMemberValueImport',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceIsCompensated',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceIsCompensated',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceIsCompensated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceIsCompensated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceIsCompensated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceIsCompensated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceIsCompensated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceIsCompensated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceIsCompensated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceIsCompensated',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceIsCompensated',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceIsCompensatedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceIsCompensated',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferencePaidById',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferencePaidById',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferencePaidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferencePaidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferencePaidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferencePaidById',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferencePaidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferencePaidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferencePaidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferencePaidById',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferencePaidById',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaidByIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferencePaidById',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferencePaymentDate',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferencePaymentDate',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferencePaymentDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferencePaymentDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferencePaymentDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferencePaymentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferencePaymentDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferencePaymentDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferencePaymentDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferencePaymentDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferencePaymentDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencePaymentDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferencePaymentDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceTags',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceTags',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceTags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceTags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceTags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceTags',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceTags',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceTotalCurrency',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceTotalCurrency',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceTotalCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceTotalCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceTotalCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceTotalCurrency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceTotalCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceTotalCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceTotalCurrency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceTotalCurrency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceTotalCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalCurrencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceTotalCurrency',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferenceTotalValue',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferenceTotalValue',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceTotalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importReferenceTotalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importReferenceTotalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importReferenceTotalValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importReferenceTotalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importReferenceTotalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importReferenceTotalValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importReferenceTotalValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importReferenceTotalValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferenceTotalValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importReferenceTotalValue',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencesMembersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importReferencesMembers',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencesMembersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importReferencesMembers',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencesMembersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'importReferencesMembers',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencesMembersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'importReferencesMembers',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencesMembersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'importReferencesMembers',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencesMembersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'importReferencesMembers',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencesMembersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'importReferencesMembers',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencesMembersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'importReferencesMembers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      isCompensatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCompensated',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      isCompensatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCompensated',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      isCompensatedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompensated',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paidById',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paidById',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paidById',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paidById',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paidById',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paidById',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paidByIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paidById',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'participantReference',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'participantReference',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'participantReference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'participantReference',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'participantReference',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'participantReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      participantReferenceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'participantReference',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentDateDefaultDate',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentDateDefaultDate',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDateDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentDateDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentDateDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentDateDefaultDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentDateDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentDateDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentDateDefaultDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentDateDefaultDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDateDefaultDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentDateDefaultDate',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentDateDefaultTime',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentDateDefaultTime',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDateDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentDateDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentDateDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentDateDefaultTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentDateDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentDateDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentDateDefaultTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentDateDefaultTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDateDefaultTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateDefaultTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentDateDefaultTime',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateInUtcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentDateInUtc',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateInUtcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentDateInUtc',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateInUtcEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDateInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateInUtcGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentDateInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateInUtcLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentDateInUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateInUtcBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentDateInUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentDateTimezone',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentDateTimezone',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDateTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentDateTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentDateTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentDateTimezone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentDateTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentDateTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentDateTimezone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentDateTimezone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentDateTimezone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      paymentDateTimezoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentDateTimezone',
        value: '',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      shareReferencesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shareReferences',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      shareReferencesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shareReferences',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      shareReferencesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'shareReferences',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      shareReferencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'shareReferences',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      shareReferencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'shareReferences',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      shareReferencesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'shareReferences',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      shareReferencesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'shareReferences',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      shareReferencesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'shareReferences',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      tagsDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagsData',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      tagsDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagsData',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      totalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'total',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      totalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'total',
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      totalEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      totalGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      totalLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'total',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      totalBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'total',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension DbPaymentDataQueryObject
    on QueryBuilder<DbPaymentData, DbPaymentData, QFilterCondition> {
  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      importReferencesMembersElement(FilterQuery<DbMemberToImportReference> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'importReferencesMembers');
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition>
      shareReferencesElement(FilterQuery<DbShareReference> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'shareReferences');
    });
  }

  QueryBuilder<DbPaymentData, DbPaymentData, QAfterFilterCondition> tagsData(
      FilterQuery<DbTagsData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'tagsData');
    });
  }
}
