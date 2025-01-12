// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_field_identifications.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbFieldIdentificationsSchema = Schema(
  name: r'DbFieldIdentifications',
  id: 7534068282301469313,
  properties: {
    r'items': PropertySchema(
      id: 0,
      name: r'items',
      type: IsarType.objectList,
      target: r'DbFieldIdentification',
    )
  },
  estimateSize: _dbFieldIdentificationsEstimateSize,
  serialize: _dbFieldIdentificationsSerialize,
  deserialize: _dbFieldIdentificationsDeserialize,
  deserializeProp: _dbFieldIdentificationsDeserializeProp,
);

int _dbFieldIdentificationsEstimateSize(
  DbFieldIdentifications object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.items;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DbFieldIdentification]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += DbFieldIdentificationSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _dbFieldIdentificationsSerialize(
  DbFieldIdentifications object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<DbFieldIdentification>(
    offsets[0],
    allOffsets,
    DbFieldIdentificationSchema.serialize,
    object.items,
  );
}

DbFieldIdentifications _dbFieldIdentificationsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbFieldIdentifications(
    items: reader.readObjectList<DbFieldIdentification>(
      offsets[0],
      DbFieldIdentificationSchema.deserialize,
      allOffsets,
      DbFieldIdentification(),
    ),
  );
  return object;
}

P _dbFieldIdentificationsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<DbFieldIdentification>(
        offset,
        DbFieldIdentificationSchema.deserialize,
        allOffsets,
        DbFieldIdentification(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbFieldIdentificationsQueryFilter on QueryBuilder<
    DbFieldIdentifications, DbFieldIdentifications, QFilterCondition> {
  QueryBuilder<DbFieldIdentifications, DbFieldIdentifications,
      QAfterFilterCondition> itemsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'items',
      ));
    });
  }

  QueryBuilder<DbFieldIdentifications, DbFieldIdentifications,
      QAfterFilterCondition> itemsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'items',
      ));
    });
  }

  QueryBuilder<DbFieldIdentifications, DbFieldIdentifications,
      QAfterFilterCondition> itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbFieldIdentifications, DbFieldIdentifications,
      QAfterFilterCondition> itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbFieldIdentifications, DbFieldIdentifications,
      QAfterFilterCondition> itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbFieldIdentifications, DbFieldIdentifications,
      QAfterFilterCondition> itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbFieldIdentifications, DbFieldIdentifications,
      QAfterFilterCondition> itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbFieldIdentifications, DbFieldIdentifications,
      QAfterFilterCondition> itemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension DbFieldIdentificationsQueryObject on QueryBuilder<
    DbFieldIdentifications, DbFieldIdentifications, QFilterCondition> {
  QueryBuilder<DbFieldIdentifications, DbFieldIdentifications,
          QAfterFilterCondition>
      itemsElement(FilterQuery<DbFieldIdentification> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'items');
    });
  }
}
