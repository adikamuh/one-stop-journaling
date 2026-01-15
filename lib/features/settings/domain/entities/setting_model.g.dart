// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSettingModelCollection on Isar {
  IsarCollection<SettingModel> get settingModels => this.collection();
}

const SettingModelSchema = CollectionSchema(
  name: r'SettingModel',
  id: 4631777779382765364,
  properties: {
    r'enableLocalAuth': PropertySchema(
      id: 0,
      name: r'enableLocalAuth',
      type: IsarType.bool,
    ),
  },

  estimateSize: _settingModelEstimateSize,
  serialize: _settingModelSerialize,
  deserialize: _settingModelDeserialize,
  deserializeProp: _settingModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _settingModelGetId,
  getLinks: _settingModelGetLinks,
  attach: _settingModelAttach,
  version: '3.3.0-dev.3',
);

int _settingModelEstimateSize(
  SettingModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _settingModelSerialize(
  SettingModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.enableLocalAuth);
}

SettingModel _settingModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SettingModel(
    enableLocalAuth: reader.readBool(offsets[0]),
    id: id,
  );
  return object;
}

P _settingModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _settingModelGetId(SettingModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _settingModelGetLinks(SettingModel object) {
  return [];
}

void _settingModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  SettingModel object,
) {
  object.id = id;
}

extension SettingModelQueryWhereSort
    on QueryBuilder<SettingModel, SettingModel, QWhere> {
  QueryBuilder<SettingModel, SettingModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SettingModelQueryWhere
    on QueryBuilder<SettingModel, SettingModel, QWhereClause> {
  QueryBuilder<SettingModel, SettingModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension SettingModelQueryFilter
    on QueryBuilder<SettingModel, SettingModel, QFilterCondition> {
  QueryBuilder<SettingModel, SettingModel, QAfterFilterCondition>
  enableLocalAuthEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'enableLocalAuth', value: value),
      );
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<SettingModel, SettingModel, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<SettingModel, SettingModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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
}

extension SettingModelQueryObject
    on QueryBuilder<SettingModel, SettingModel, QFilterCondition> {}

extension SettingModelQueryLinks
    on QueryBuilder<SettingModel, SettingModel, QFilterCondition> {}

extension SettingModelQuerySortBy
    on QueryBuilder<SettingModel, SettingModel, QSortBy> {
  QueryBuilder<SettingModel, SettingModel, QAfterSortBy>
  sortByEnableLocalAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableLocalAuth', Sort.asc);
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterSortBy>
  sortByEnableLocalAuthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableLocalAuth', Sort.desc);
    });
  }
}

extension SettingModelQuerySortThenBy
    on QueryBuilder<SettingModel, SettingModel, QSortThenBy> {
  QueryBuilder<SettingModel, SettingModel, QAfterSortBy>
  thenByEnableLocalAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableLocalAuth', Sort.asc);
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterSortBy>
  thenByEnableLocalAuthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enableLocalAuth', Sort.desc);
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SettingModel, SettingModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension SettingModelQueryWhereDistinct
    on QueryBuilder<SettingModel, SettingModel, QDistinct> {
  QueryBuilder<SettingModel, SettingModel, QDistinct>
  distinctByEnableLocalAuth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enableLocalAuth');
    });
  }
}

extension SettingModelQueryProperty
    on QueryBuilder<SettingModel, SettingModel, QQueryProperty> {
  QueryBuilder<SettingModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SettingModel, bool, QQueryOperations> enableLocalAuthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enableLocalAuth');
    });
  }
}
