// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_shows.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTvShowCollection on Isar {
  IsarCollection<TvShow> get tvShows => this.collection();
}

const TvShowSchema = CollectionSchema(
  name: r'TvShow',
  id: -7492667836214844311,
  properties: {
    r'backdropPath': PropertySchema(
      id: 0,
      name: r'backdropPath',
      type: IsarType.string,
    ),
    r'firstAirDate': PropertySchema(
      id: 1,
      name: r'firstAirDate',
      type: IsarType.dateTime,
    ),
    r'genreIds': PropertySchema(
      id: 2,
      name: r'genreIds',
      type: IsarType.longList,
    ),
    r'id': PropertySchema(id: 3, name: r'id', type: IsarType.long),
    r'name': PropertySchema(id: 4, name: r'name', type: IsarType.string),
    r'originalLanguage': PropertySchema(
      id: 5,
      name: r'originalLanguage',
      type: IsarType.string,
    ),
    r'originalName': PropertySchema(
      id: 6,
      name: r'originalName',
      type: IsarType.string,
    ),
    r'overview': PropertySchema(
      id: 7,
      name: r'overview',
      type: IsarType.string,
    ),
    r'popularity': PropertySchema(
      id: 8,
      name: r'popularity',
      type: IsarType.double,
    ),
    r'posterPath': PropertySchema(
      id: 9,
      name: r'posterPath',
      type: IsarType.string,
    ),
    r'voteAverage': PropertySchema(
      id: 10,
      name: r'voteAverage',
      type: IsarType.double,
    ),
    r'voteCount': PropertySchema(
      id: 11,
      name: r'voteCount',
      type: IsarType.long,
    ),
  },
  estimateSize: _tvShowEstimateSize,
  serialize: _tvShowSerialize,
  deserialize: _tvShowDeserialize,
  deserializeProp: _tvShowDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tvShowGetId,
  getLinks: _tvShowGetLinks,
  attach: _tvShowAttach,
  version: '3.1.0+1',
);

int _tvShowEstimateSize(
  TvShow object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.backdropPath.length * 3;
  bytesCount += 3 + object.genreIds.length * 8;
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.originalLanguage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.originalName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.overview;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.posterPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _tvShowSerialize(
  TvShow object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.backdropPath);
  writer.writeDateTime(offsets[1], object.firstAirDate);
  writer.writeStringList(offsets[2], object.genreIds);
  writer.writeLong(offsets[3], object.id);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.originalLanguage);
  writer.writeString(offsets[6], object.originalName);
  writer.writeString(offsets[7], object.overview);
  writer.writeDouble(offsets[8], object.popularity);
  writer.writeString(offsets[9], object.posterPath);
  writer.writeDouble(offsets[10], object.voteAverage);
  writer.writeLong(offsets[11], object.voteCount);
}

TvShow _tvShowDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TvShow(
    backdropPath: reader.readString(offsets[0]),
    firstAirDate: reader.readDateTimeOrNull(offsets[1]),
    genreIds: reader.readStringList(offsets[2]) ?? [],
    id: reader.readLong(offsets[3]),
    name: reader.readString(offsets[4]),
    originalLanguage: reader.readStringOrNull(offsets[5]),
    originalName: reader.readStringOrNull(offsets[6]),
    overview: reader.readStringOrNull(offsets[7]),
    popularity: reader.readDouble(offsets[8]),
    posterPath: reader.readStringOrNull(offsets[9]),
    voteAverage: reader.readDouble(offsets[10]),
    voteCount: reader.readLong(offsets[11]),
  );
  object.isarId = id;
  return object;
}

P _tvShowDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongList(offset) ?? []) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tvShowGetId(TvShow object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _tvShowGetLinks(TvShow object) {
  return [];
}

void _tvShowAttach(IsarCollection<dynamic> col, Id id, TvShow object) {
  object.isarId = id;
}

extension TvShowQueryWhereSort on QueryBuilder<TvShow, TvShow, QWhere> {
  QueryBuilder<TvShow, TvShow, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TvShowQueryWhere on QueryBuilder<TvShow, TvShow, QWhereClause> {
  QueryBuilder<TvShow, TvShow, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterWhereClause> isarIdGreaterThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension TvShowQueryFilter on QueryBuilder<TvShow, TvShow, QFilterCondition> {
  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'backdropPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'backdropPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'backdropPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'backdropPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'backdropPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'backdropPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'backdropPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'backdropPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'backdropPath', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> backdropPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'backdropPath', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> firstAirDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'firstAirDate'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> firstAirDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'firstAirDate'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> firstAirDateEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'firstAirDate', value: value),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> firstAirDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'firstAirDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> firstAirDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'firstAirDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> firstAirDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'firstAirDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> genreIdsElementEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'genreIds', value: value),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition>
  genreIdsElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'genreIds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> genreIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'genreIds',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> genreIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'genreIds',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> genreIdsLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genreIds', length, true, length, true);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> genreIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genreIds', 0, true, 0, true);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> genreIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genreIds', 0, false, 999999, true);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> genreIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genreIds', 0, true, length, include);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> genreIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'genreIds', length, include, 999999, true);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> genreIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genreIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'isarId'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'isarId'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> isarIdEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> isarIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> isarIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> isarIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalLanguageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'originalLanguage'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition>
  originalLanguageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'originalLanguage'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalLanguageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'originalLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition>
  originalLanguageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'originalLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalLanguageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'originalLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalLanguageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'originalLanguage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition>
  originalLanguageStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'originalLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalLanguageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'originalLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalLanguageContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'originalLanguage',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalLanguageMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'originalLanguage',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition>
  originalLanguageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'originalLanguage', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition>
  originalLanguageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'originalLanguage', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'originalName'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'originalName'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'originalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'originalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'originalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'originalName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'originalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'originalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'originalName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'originalName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'originalName', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> originalNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'originalName', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'overview'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'overview'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'overview',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'overview',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'overview',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'overview',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'overview',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'overview',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'overview',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'overview',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'overview', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> overviewIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'overview', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> popularityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'popularity',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> popularityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'popularity',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> popularityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'popularity',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> popularityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'popularity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'posterPath'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'posterPath'),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'posterPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'posterPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'posterPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'posterPath', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> posterPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'posterPath', value: ''),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> voteAverageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'voteAverage',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> voteAverageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'voteAverage',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> voteAverageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'voteAverage',
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> voteAverageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'voteAverage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> voteCountEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'voteCount', value: value),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> voteCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'voteCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> voteCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'voteCount',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterFilterCondition> voteCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'voteCount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension TvShowQueryObject on QueryBuilder<TvShow, TvShow, QFilterCondition> {}

extension TvShowQueryLinks on QueryBuilder<TvShow, TvShow, QFilterCondition> {}

extension TvShowQuerySortBy on QueryBuilder<TvShow, TvShow, QSortBy> {
  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByBackdropPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backdropPath', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByBackdropPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backdropPath', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByFirstAirDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstAirDate', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByFirstAirDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstAirDate', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByOriginalLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLanguage', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByOriginalLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLanguage', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByOriginalName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalName', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByOriginalNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalName', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByOverview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByOverviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByPopularity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popularity', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByPopularityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popularity', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByPosterPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterPath', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByPosterPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterPath', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByVoteAverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteAverage', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByVoteAverageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteAverage', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByVoteCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteCount', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> sortByVoteCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteCount', Sort.desc);
    });
  }
}

extension TvShowQuerySortThenBy on QueryBuilder<TvShow, TvShow, QSortThenBy> {
  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByBackdropPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backdropPath', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByBackdropPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backdropPath', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByFirstAirDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstAirDate', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByFirstAirDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstAirDate', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByOriginalLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLanguage', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByOriginalLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalLanguage', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByOriginalName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalName', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByOriginalNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalName', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByOverview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByOverviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overview', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByPopularity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popularity', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByPopularityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'popularity', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByPosterPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterPath', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByPosterPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'posterPath', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByVoteAverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteAverage', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByVoteAverageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteAverage', Sort.desc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByVoteCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteCount', Sort.asc);
    });
  }

  QueryBuilder<TvShow, TvShow, QAfterSortBy> thenByVoteCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voteCount', Sort.desc);
    });
  }
}

extension TvShowQueryWhereDistinct on QueryBuilder<TvShow, TvShow, QDistinct> {
  QueryBuilder<TvShow, TvShow, QDistinct> distinctByBackdropPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backdropPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByFirstAirDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstAirDate');
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByGenreIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genreIds');
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByOriginalLanguage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'originalLanguage',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByOriginalName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByOverview({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overview', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByPopularity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'popularity');
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByPosterPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'posterPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByVoteAverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voteAverage');
    });
  }

  QueryBuilder<TvShow, TvShow, QDistinct> distinctByVoteCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voteCount');
    });
  }
}

extension TvShowQueryProperty on QueryBuilder<TvShow, TvShow, QQueryProperty> {
  QueryBuilder<TvShow, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<TvShow, String, QQueryOperations> backdropPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backdropPath');
    });
  }

  QueryBuilder<TvShow, DateTime?, QQueryOperations> firstAirDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstAirDate');
    });
  }

  QueryBuilder<TvShow, List<int>, QQueryOperations> genreIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genreIds');
    });
  }

  QueryBuilder<TvShow, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TvShow, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<TvShow, String?, QQueryOperations> originalLanguageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalLanguage');
    });
  }

  QueryBuilder<TvShow, String?, QQueryOperations> originalNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalName');
    });
  }

  QueryBuilder<TvShow, String?, QQueryOperations> overviewProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overview');
    });
  }

  QueryBuilder<TvShow, double, QQueryOperations> popularityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'popularity');
    });
  }

  QueryBuilder<TvShow, String?, QQueryOperations> posterPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'posterPath');
    });
  }

  QueryBuilder<TvShow, double, QQueryOperations> voteAverageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voteAverage');
    });
  }

  QueryBuilder<TvShow, int, QQueryOperations> voteCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voteCount');
    });
  }
}
