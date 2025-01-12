// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_file_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbFileDataSchema = Schema(
  name: r'DbFileData',
  id: -281065727624376857,
  properties: {
    r'tagsData': PropertySchema(
      id: 0,
      name: r'tagsData',
      type: IsarType.object,
      target: r'DbTagsData',
    ),
    r'value': PropertySchema(
      id: 1,
      name: r'value',
      type: IsarType.objectList,
      target: r'DbFileItem',
    )
  },
  estimateSize: _dbFileDataEstimateSize,
  serialize: _dbFileDataSerialize,
  deserialize: _dbFileDataDeserialize,
  deserializeProp: _dbFileDataDeserializeProp,
);

int _dbFileDataEstimateSize(
  DbFileData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.tagsData;
    if (value != null) {
      bytesCount += 3 +
          DbTagsDataSchema.estimateSize(
              value, allOffsets[DbTagsData]!, allOffsets);
    }
  }
  {
    final list = object.value;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[DbFileItem]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              DbFileItemSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _dbFileDataSerialize(
  DbFileData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<DbTagsData>(
    offsets[0],
    allOffsets,
    DbTagsDataSchema.serialize,
    object.tagsData,
  );
  writer.writeObjectList<DbFileItem>(
    offsets[1],
    allOffsets,
    DbFileItemSchema.serialize,
    object.value,
  );
}

DbFileData _dbFileDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbFileData(
    tagsData: reader.readObjectOrNull<DbTagsData>(
      offsets[0],
      DbTagsDataSchema.deserialize,
      allOffsets,
    ),
    value: reader.readObjectList<DbFileItem>(
      offsets[1],
      DbFileItemSchema.deserialize,
      allOffsets,
      DbFileItem(),
    ),
  );
  return object;
}

P _dbFileDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<DbTagsData>(
        offset,
        DbTagsDataSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectList<DbFileItem>(
        offset,
        DbFileItemSchema.deserialize,
        allOffsets,
        DbFileItem(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbFileDataQueryFilter
    on QueryBuilder<DbFileData, DbFileData, QFilterCondition> {
  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition> tagsDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagsData',
      ));
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition>
      tagsDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagsData',
      ));
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition> valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition> valueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition>
      valueLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'value',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition> valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'value',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition>
      valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'value',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition>
      valueLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'value',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition>
      valueLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'value',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition>
      valueLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'value',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension DbFileDataQueryObject
    on QueryBuilder<DbFileData, DbFileData, QFilterCondition> {
  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition> tagsData(
      FilterQuery<DbTagsData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'tagsData');
    });
  }

  QueryBuilder<DbFileData, DbFileData, QAfterFilterCondition> valueElement(
      FilterQuery<DbFileItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'value');
    });
  }
}
