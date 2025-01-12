// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_image_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbImageDataSchema = Schema(
  name: r'DbImageData',
  id: -9178824119852457933,
  properties: {
    r'images': PropertySchema(
      id: 0,
      name: r'images',
      type: IsarType.objectList,
      target: r'DbFileItem',
    ),
    r'tagsData': PropertySchema(
      id: 1,
      name: r'tagsData',
      type: IsarType.object,
      target: r'DbTagsData',
    )
  },
  estimateSize: _dbImageDataEstimateSize,
  serialize: _dbImageDataSerialize,
  deserialize: _dbImageDataDeserialize,
  deserializeProp: _dbImageDataDeserializeProp,
);

int _dbImageDataEstimateSize(
  DbImageData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.images;
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

void _dbImageDataSerialize(
  DbImageData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<DbFileItem>(
    offsets[0],
    allOffsets,
    DbFileItemSchema.serialize,
    object.images,
  );
  writer.writeObject<DbTagsData>(
    offsets[1],
    allOffsets,
    DbTagsDataSchema.serialize,
    object.tagsData,
  );
}

DbImageData _dbImageDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbImageData(
    images: reader.readObjectList<DbFileItem>(
      offsets[0],
      DbFileItemSchema.deserialize,
      allOffsets,
      DbFileItem(),
    ),
    tagsData: reader.readObjectOrNull<DbTagsData>(
      offsets[1],
      DbTagsDataSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _dbImageDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<DbFileItem>(
        offset,
        DbFileItemSchema.deserialize,
        allOffsets,
        DbFileItem(),
      )) as P;
    case 1:
      return (reader.readObjectOrNull<DbTagsData>(
        offset,
        DbTagsDataSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbImageDataQueryFilter
    on QueryBuilder<DbImageData, DbImageData, QFilterCondition> {
  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition> imagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'images',
      ));
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition>
      imagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'images',
      ));
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition>
      imagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition>
      imagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition>
      imagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition>
      imagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition>
      imagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition>
      imagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition>
      tagsDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagsData',
      ));
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition>
      tagsDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagsData',
      ));
    });
  }
}

extension DbImageDataQueryObject
    on QueryBuilder<DbImageData, DbImageData, QFilterCondition> {
  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition> imagesElement(
      FilterQuery<DbFileItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'images');
    });
  }

  QueryBuilder<DbImageData, DbImageData, QAfterFilterCondition> tagsData(
      FilterQuery<DbTagsData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'tagsData');
    });
  }
}
