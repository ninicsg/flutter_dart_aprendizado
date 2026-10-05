// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banco_dados.dart';

// ignore_for_file: type=lint
class $TarefasTable extends Tarefas with TableInfo<$TarefasTable, Tarefa> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarefasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _descricaoMeta = const VerificationMeta(
    'descricao',
  );
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
    'descricao',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 42,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teste3Meta = const VerificationMeta('teste3');
  @override
  late final GeneratedColumn<bool> teste3 = GeneratedColumn<bool>(
    'teste3',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("teste3" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _teste33Meta = const VerificationMeta(
    'teste33',
  );
  @override
  late final GeneratedColumn<bool> teste33 = GeneratedColumn<bool>(
    'teste33',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("teste33" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, descricao, teste3, teste33];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarefas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tarefa> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(
        _descricaoMeta,
        descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta),
      );
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    if (data.containsKey('teste3')) {
      context.handle(
        _teste3Meta,
        teste3.isAcceptableOrUnknown(data['teste3']!, _teste3Meta),
      );
    }
    if (data.containsKey('teste33')) {
      context.handle(
        _teste33Meta,
        teste33.isAcceptableOrUnknown(data['teste33']!, _teste33Meta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tarefa map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tarefa(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      descricao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descricao'],
      )!,
      teste3: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}teste3'],
      )!,
      teste33: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}teste33'],
      )!,
    );
  }

  @override
  $TarefasTable createAlias(String alias) {
    return $TarefasTable(attachedDatabase, alias);
  }
}

class Tarefa extends DataClass implements Insertable<Tarefa> {
  final int id;
  final String descricao;
  final bool teste3;
  final bool teste33;
  const Tarefa({
    required this.id,
    required this.descricao,
    required this.teste3,
    required this.teste33,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['descricao'] = Variable<String>(descricao);
    map['teste3'] = Variable<bool>(teste3);
    map['teste33'] = Variable<bool>(teste33);
    return map;
  }

  TarefasCompanion toCompanion(bool nullToAbsent) {
    return TarefasCompanion(
      id: Value(id),
      descricao: Value(descricao),
      teste3: Value(teste3),
      teste33: Value(teste33),
    );
  }

  factory Tarefa.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tarefa(
      id: serializer.fromJson<int>(json['id']),
      descricao: serializer.fromJson<String>(json['descricao']),
      teste3: serializer.fromJson<bool>(json['teste3']),
      teste33: serializer.fromJson<bool>(json['teste33']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'descricao': serializer.toJson<String>(descricao),
      'teste3': serializer.toJson<bool>(teste3),
      'teste33': serializer.toJson<bool>(teste33),
    };
  }

  Tarefa copyWith({int? id, String? descricao, bool? teste3, bool? teste33}) =>
      Tarefa(
        id: id ?? this.id,
        descricao: descricao ?? this.descricao,
        teste3: teste3 ?? this.teste3,
        teste33: teste33 ?? this.teste33,
      );
  Tarefa copyWithCompanion(TarefasCompanion data) {
    return Tarefa(
      id: data.id.present ? data.id.value : this.id,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      teste3: data.teste3.present ? data.teste3.value : this.teste3,
      teste33: data.teste33.present ? data.teste33.value : this.teste33,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tarefa(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('teste3: $teste3, ')
          ..write('teste33: $teste33')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, descricao, teste3, teste33);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tarefa &&
          other.id == this.id &&
          other.descricao == this.descricao &&
          other.teste3 == this.teste3 &&
          other.teste33 == this.teste33);
}

class TarefasCompanion extends UpdateCompanion<Tarefa> {
  final Value<int> id;
  final Value<String> descricao;
  final Value<bool> teste3;
  final Value<bool> teste33;
  const TarefasCompanion({
    this.id = const Value.absent(),
    this.descricao = const Value.absent(),
    this.teste3 = const Value.absent(),
    this.teste33 = const Value.absent(),
  });
  TarefasCompanion.insert({
    this.id = const Value.absent(),
    required String descricao,
    this.teste3 = const Value.absent(),
    this.teste33 = const Value.absent(),
  }) : descricao = Value(descricao);
  static Insertable<Tarefa> custom({
    Expression<int>? id,
    Expression<String>? descricao,
    Expression<bool>? teste3,
    Expression<bool>? teste33,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descricao != null) 'descricao': descricao,
      if (teste3 != null) 'teste3': teste3,
      if (teste33 != null) 'teste33': teste33,
    });
  }

  TarefasCompanion copyWith({
    Value<int>? id,
    Value<String>? descricao,
    Value<bool>? teste3,
    Value<bool>? teste33,
  }) {
    return TarefasCompanion(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      teste3: teste3 ?? this.teste3,
      teste33: teste33 ?? this.teste33,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (teste3.present) {
      map['teste3'] = Variable<bool>(teste3.value);
    }
    if (teste33.present) {
      map['teste33'] = Variable<bool>(teste33.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarefasCompanion(')
          ..write('id: $id, ')
          ..write('descricao: $descricao, ')
          ..write('teste3: $teste3, ')
          ..write('teste33: $teste33')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TarefasTable tarefas = $TarefasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tarefas];
}

typedef $$TarefasTableCreateCompanionBuilder = TarefasCompanion Function({
  Value<int> id,
  required String descricao,
  Value<bool> teste3,
  Value<bool> teste33,
});
typedef $$TarefasTableUpdateCompanionBuilder = TarefasCompanion Function({
  Value<int> id,
  Value<String> descricao,
  Value<bool> teste3,
  Value<bool> teste33,
});

class $$TarefasTableFilterComposer
    extends Composer<_$AppDatabase, $TarefasTable> {
  $$TarefasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descricao => $composableBuilder(
    column: $table.descricao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get teste3 => $composableBuilder(
    column: $table.teste3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get teste33 => $composableBuilder(
    column: $table.teste33,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TarefasTableOrderingComposer
    extends Composer<_$AppDatabase, $TarefasTable> {
  $$TarefasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descricao => $composableBuilder(
    column: $table.descricao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get teste3 => $composableBuilder(
    column: $table.teste3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get teste33 => $composableBuilder(
    column: $table.teste33,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TarefasTableAnnotationComposer
    extends Composer<_$AppDatabase, $TarefasTable> {
  $$TarefasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<bool> get teste3 =>
      $composableBuilder(column: $table.teste3, builder: (column) => column);

  GeneratedColumn<bool> get teste33 =>
      $composableBuilder(column: $table.teste33, builder: (column) => column);
}

class $$TarefasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TarefasTable,
          Tarefa,
          $$TarefasTableFilterComposer,
          $$TarefasTableOrderingComposer,
          $$TarefasTableAnnotationComposer,
          $$TarefasTableCreateCompanionBuilder,
          $$TarefasTableUpdateCompanionBuilder,
          (Tarefa, BaseReferences<_$AppDatabase, $TarefasTable, Tarefa>),
          Tarefa,
          PrefetchHooks Function()
        > {
  $$TarefasTableTableManager(_$AppDatabase db, $TarefasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TarefasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TarefasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TarefasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> descricao = const Value.absent(),
                Value<bool> teste3 = const Value.absent(),
                Value<bool> teste33 = const Value.absent(),
              }) => TarefasCompanion(
                id: id,
                descricao: descricao,
                teste3: teste3,
                teste33: teste33,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String descricao,
                Value<bool> teste3 = const Value.absent(),
                Value<bool> teste33 = const Value.absent(),
              }) => TarefasCompanion.insert(
                id: id,
                descricao: descricao,
                teste3: teste3,
                teste33: teste33,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TarefasTable, Tarefa>(table),
                  BaseReferences<_$AppDatabase, $TarefasTable, Tarefa>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TarefasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TarefasTable,
      Tarefa,
      $$TarefasTableFilterComposer,
      $$TarefasTableOrderingComposer,
      $$TarefasTableAnnotationComposer,
      $$TarefasTableCreateCompanionBuilder,
      $$TarefasTableUpdateCompanionBuilder,
      (Tarefa, BaseReferences<_$AppDatabase, $TarefasTable, Tarefa>),
      Tarefa,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TarefasTableTableManager get tarefas =>
      $$TarefasTableTableManager(_db, _db.tarefas);
}
