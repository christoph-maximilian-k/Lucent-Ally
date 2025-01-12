// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_fields.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbFieldsSchema = Schema(
  name: r'DbFields',
  id: -4440810325097836536,
  properties: {
    r'items': PropertySchema(
      id: 0,
      name: r'items',
      type: IsarType.objectList,
      target: r'DbField',
    )
  },
  estimateSize: _dbFieldsEstimateSize,
  serialize: _dbFieldsSerialize,
  deserialize: _dbFieldsDeserialize,
  deserializeProp: _dbFieldsDeserializeProp,
);

int _dbFieldsEstimateSize(
  DbFields object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.items;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DbField]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += DbFieldSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _dbFieldsSerialize(
  DbFields object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<DbField>(
    offsets[0],
    allOffsets,
    DbFieldSchema.serialize,
    object.items,
  );
}

DbFields _dbFieldsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbFields(
    items: reader.readObjectList<DbField>(
      offsets[0],
      DbFieldSchema.deserialize,
      allOffsets,
      DbField(),
    ),
  );
  return object;
}

P _dbFieldsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<DbField>(
        offset,
        DbFieldSchema.deserialize,
        allOffsets,
        DbField(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbFieldsQueryFilter
    on QueryBuilder<DbFields, DbFields, QFilterCondition> {
  QueryBuilder<DbFields, DbFields, QAfterFilterCondition> itemsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'items',
      ));
    });
  }

  QueryBuilder<DbFields, DbFields, QAfterFilterCondition> itemsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'items',
      ));
    });
  }

  QueryBuilder<DbFields, DbFields, QAfterFilterCondition> itemsLengthEqualTo(
      int length) {
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

  QueryBuilder<DbFields, DbFields, QAfterFilterCondition> itemsIsEmpty() {
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

  QueryBuilder<DbFields, DbFields, QAfterFilterCondition> itemsIsNotEmpty() {
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

  QueryBuilder<DbFields, DbFields, QAfterFilterCondition> itemsLengthLessThan(
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

  QueryBuilder<DbFields, DbFields, QAfterFilterCondition>
      itemsLengthGreaterThan(
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

  QueryBuilder<DbFields, DbFields, QAfterFilterCondition> itemsLengthBetween(
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

extension DbFieldsQueryObject
    on QueryBuilder<DbFields, DbFields, QFilterCondition> {
  QueryBuilder<DbFields, DbFields, QAfterFilterCondition> itemsElement(
      FilterQuery<DbField> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'items');
    });
  }
}
