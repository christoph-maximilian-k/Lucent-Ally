// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_avatar_image_data.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DbAvatarImageDataSchema = Schema(
  name: r'DbAvatarImageData',
  id: -8591343274537177713,
  properties: {
    r'image': PropertySchema(
      id: 0,
      name: r'image',
      type: IsarType.object,
      target: r'DbFileItem',
    )
  },
  estimateSize: _dbAvatarImageDataEstimateSize,
  serialize: _dbAvatarImageDataSerialize,
  deserialize: _dbAvatarImageDataDeserialize,
  deserializeProp: _dbAvatarImageDataDeserializeProp,
);

int _dbAvatarImageDataEstimateSize(
  DbAvatarImageData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 +
          DbFileItemSchema.estimateSize(
              value, allOffsets[DbFileItem]!, allOffsets);
    }
  }
  return bytesCount;
}

void _dbAvatarImageDataSerialize(
  DbAvatarImageData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<DbFileItem>(
    offsets[0],
    allOffsets,
    DbFileItemSchema.serialize,
    object.image,
  );
}

DbAvatarImageData _dbAvatarImageDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DbAvatarImageData(
    image: reader.readObjectOrNull<DbFileItem>(
      offsets[0],
      DbFileItemSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _dbAvatarImageDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<DbFileItem>(
        offset,
        DbFileItemSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DbAvatarImageDataQueryFilter
    on QueryBuilder<DbAvatarImageData, DbAvatarImageData, QFilterCondition> {
  QueryBuilder<DbAvatarImageData, DbAvatarImageData, QAfterFilterCondition>
      imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<DbAvatarImageData, DbAvatarImageData, QAfterFilterCondition>
      imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }
}

extension DbAvatarImageDataQueryObject
    on QueryBuilder<DbAvatarImageData, DbAvatarImageData, QFilterCondition> {
  QueryBuilder<DbAvatarImageData, DbAvatarImageData, QAfterFilterCondition>
      image(FilterQuery<DbFileItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'image');
    });
  }
}
