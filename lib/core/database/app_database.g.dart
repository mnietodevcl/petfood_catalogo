// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _presentationMeta = const VerificationMeta(
    'presentation',
  );
  @override
  late final GeneratedColumn<String> presentation = GeneratedColumn<String>(
    'presentation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productImagePathMeta = const VerificationMeta(
    'productImagePath',
  );
  @override
  late final GeneratedColumn<String> productImagePath = GeneratedColumn<String>(
    'product_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productImageUrlMeta = const VerificationMeta(
    'productImageUrl',
  );
  @override
  late final GeneratedColumn<String> productImageUrl = GeneratedColumn<String>(
    'product_image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nutritionImagePathMeta =
      const VerificationMeta('nutritionImagePath');
  @override
  late final GeneratedColumn<String> nutritionImagePath =
      GeneratedColumn<String>(
        'nutrition_image_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nutritionImageUrlMeta = const VerificationMeta(
    'nutritionImageUrl',
  );
  @override
  late final GeneratedColumn<String> nutritionImageUrl =
      GeneratedColumn<String>(
        'nutrition_image_url',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    description,
    price,
    presentation,
    productImagePath,
    productImageUrl,
    nutritionImagePath,
    nutritionImageUrl,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('presentation')) {
      context.handle(
        _presentationMeta,
        presentation.isAcceptableOrUnknown(
          data['presentation']!,
          _presentationMeta,
        ),
      );
    }
    if (data.containsKey('product_image_path')) {
      context.handle(
        _productImagePathMeta,
        productImagePath.isAcceptableOrUnknown(
          data['product_image_path']!,
          _productImagePathMeta,
        ),
      );
    }
    if (data.containsKey('product_image_url')) {
      context.handle(
        _productImageUrlMeta,
        productImageUrl.isAcceptableOrUnknown(
          data['product_image_url']!,
          _productImageUrlMeta,
        ),
      );
    }
    if (data.containsKey('nutrition_image_path')) {
      context.handle(
        _nutritionImagePathMeta,
        nutritionImagePath.isAcceptableOrUnknown(
          data['nutrition_image_path']!,
          _nutritionImagePathMeta,
        ),
      );
    }
    if (data.containsKey('nutrition_image_url')) {
      context.handle(
        _nutritionImageUrlMeta,
        nutritionImageUrl.isAcceptableOrUnknown(
          data['nutrition_image_url']!,
          _nutritionImageUrlMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      presentation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}presentation'],
      ),
      productImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_image_path'],
      ),
      productImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_image_url'],
      ),
      nutritionImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrition_image_path'],
      ),
      nutritionImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrition_image_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String? presentation;
  final String? productImagePath;
  final String? productImageUrl;
  final String? nutritionImagePath;
  final String? nutritionImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    this.presentation,
    this.productImagePath,
    this.productImageUrl,
    this.nutritionImagePath,
    this.nutritionImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || presentation != null) {
      map['presentation'] = Variable<String>(presentation);
    }
    if (!nullToAbsent || productImagePath != null) {
      map['product_image_path'] = Variable<String>(productImagePath);
    }
    if (!nullToAbsent || productImageUrl != null) {
      map['product_image_url'] = Variable<String>(productImageUrl);
    }
    if (!nullToAbsent || nutritionImagePath != null) {
      map['nutrition_image_path'] = Variable<String>(nutritionImagePath);
    }
    if (!nullToAbsent || nutritionImageUrl != null) {
      map['nutrition_image_url'] = Variable<String>(nutritionImageUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      description: Value(description),
      price: Value(price),
      presentation: presentation == null && nullToAbsent
          ? const Value.absent()
          : Value(presentation),
      productImagePath: productImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(productImagePath),
      productImageUrl: productImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(productImageUrl),
      nutritionImagePath: nutritionImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(nutritionImagePath),
      nutritionImageUrl: nutritionImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(nutritionImageUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      presentation: serializer.fromJson<String?>(json['presentation']),
      productImagePath: serializer.fromJson<String?>(json['productImagePath']),
      productImageUrl: serializer.fromJson<String?>(json['productImageUrl']),
      nutritionImagePath: serializer.fromJson<String?>(
        json['nutritionImagePath'],
      ),
      nutritionImageUrl: serializer.fromJson<String?>(
        json['nutritionImageUrl'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<double>(price),
      'presentation': serializer.toJson<String?>(presentation),
      'productImagePath': serializer.toJson<String?>(productImagePath),
      'productImageUrl': serializer.toJson<String?>(productImageUrl),
      'nutritionImagePath': serializer.toJson<String?>(nutritionImagePath),
      'nutritionImageUrl': serializer.toJson<String?>(nutritionImageUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    String? category,
    String? description,
    double? price,
    Value<String?> presentation = const Value.absent(),
    Value<String?> productImagePath = const Value.absent(),
    Value<String?> productImageUrl = const Value.absent(),
    Value<String?> nutritionImagePath = const Value.absent(),
    Value<String?> nutritionImageUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    description: description ?? this.description,
    price: price ?? this.price,
    presentation: presentation.present ? presentation.value : this.presentation,
    productImagePath: productImagePath.present
        ? productImagePath.value
        : this.productImagePath,
    productImageUrl: productImageUrl.present
        ? productImageUrl.value
        : this.productImageUrl,
    nutritionImagePath: nutritionImagePath.present
        ? nutritionImagePath.value
        : this.nutritionImagePath,
    nutritionImageUrl: nutritionImageUrl.present
        ? nutritionImageUrl.value
        : this.nutritionImageUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      price: data.price.present ? data.price.value : this.price,
      presentation: data.presentation.present
          ? data.presentation.value
          : this.presentation,
      productImagePath: data.productImagePath.present
          ? data.productImagePath.value
          : this.productImagePath,
      productImageUrl: data.productImageUrl.present
          ? data.productImageUrl.value
          : this.productImageUrl,
      nutritionImagePath: data.nutritionImagePath.present
          ? data.nutritionImagePath.value
          : this.nutritionImagePath,
      nutritionImageUrl: data.nutritionImageUrl.present
          ? data.nutritionImageUrl.value
          : this.nutritionImageUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('presentation: $presentation, ')
          ..write('productImagePath: $productImagePath, ')
          ..write('productImageUrl: $productImageUrl, ')
          ..write('nutritionImagePath: $nutritionImagePath, ')
          ..write('nutritionImageUrl: $nutritionImageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    description,
    price,
    presentation,
    productImagePath,
    productImageUrl,
    nutritionImagePath,
    nutritionImageUrl,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.description == this.description &&
          other.price == this.price &&
          other.presentation == this.presentation &&
          other.productImagePath == this.productImagePath &&
          other.productImageUrl == this.productImageUrl &&
          other.nutritionImagePath == this.nutritionImagePath &&
          other.nutritionImageUrl == this.nutritionImageUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> description;
  final Value<double> price;
  final Value<String?> presentation;
  final Value<String?> productImagePath;
  final Value<String?> productImageUrl;
  final Value<String?> nutritionImagePath;
  final Value<String?> nutritionImageUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.presentation = const Value.absent(),
    this.productImagePath = const Value.absent(),
    this.productImageUrl = const Value.absent(),
    this.nutritionImagePath = const Value.absent(),
    this.nutritionImageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    required String description,
    required double price,
    this.presentation = const Value.absent(),
    this.productImagePath = const Value.absent(),
    this.productImageUrl = const Value.absent(),
    this.nutritionImagePath = const Value.absent(),
    this.nutritionImageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       category = Value(category),
       description = Value(description),
       price = Value(price);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? description,
    Expression<double>? price,
    Expression<String>? presentation,
    Expression<String>? productImagePath,
    Expression<String>? productImageUrl,
    Expression<String>? nutritionImagePath,
    Expression<String>? nutritionImageUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (presentation != null) 'presentation': presentation,
      if (productImagePath != null) 'product_image_path': productImagePath,
      if (productImageUrl != null) 'product_image_url': productImageUrl,
      if (nutritionImagePath != null)
        'nutrition_image_path': nutritionImagePath,
      if (nutritionImageUrl != null) 'nutrition_image_url': nutritionImageUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? category,
    Value<String>? description,
    Value<double>? price,
    Value<String?>? presentation,
    Value<String?>? productImagePath,
    Value<String?>? productImageUrl,
    Value<String?>? nutritionImagePath,
    Value<String?>? nutritionImageUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      presentation: presentation ?? this.presentation,
      productImagePath: productImagePath ?? this.productImagePath,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      nutritionImagePath: nutritionImagePath ?? this.nutritionImagePath,
      nutritionImageUrl: nutritionImageUrl ?? this.nutritionImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (presentation.present) {
      map['presentation'] = Variable<String>(presentation.value);
    }
    if (productImagePath.present) {
      map['product_image_path'] = Variable<String>(productImagePath.value);
    }
    if (productImageUrl.present) {
      map['product_image_url'] = Variable<String>(productImageUrl.value);
    }
    if (nutritionImagePath.present) {
      map['nutrition_image_path'] = Variable<String>(nutritionImagePath.value);
    }
    if (nutritionImageUrl.present) {
      map['nutrition_image_url'] = Variable<String>(nutritionImageUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('presentation: $presentation, ')
          ..write('productImagePath: $productImagePath, ')
          ..write('productImageUrl: $productImageUrl, ')
          ..write('nutritionImagePath: $nutritionImagePath, ')
          ..write('nutritionImageUrl: $nutritionImageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ProductNutritionImagesTable extends ProductNutritionImages
    with TableInfo<$ProductNutritionImagesTable, ProductNutritionImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductNutritionImagesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    imagePath,
    imageUrl,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_nutrition_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductNutritionImage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductNutritionImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductNutritionImage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ProductNutritionImagesTable createAlias(String alias) {
    return $ProductNutritionImagesTable(attachedDatabase, alias);
  }
}

class ProductNutritionImage extends DataClass
    implements Insertable<ProductNutritionImage> {
  final int id;
  final int productId;
  final String? imagePath;
  final String? imageUrl;
  final int sortOrder;
  const ProductNutritionImage({
    required this.id,
    required this.productId,
    this.imagePath,
    this.imageUrl,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ProductNutritionImagesCompanion toCompanion(bool nullToAbsent) {
    return ProductNutritionImagesCompanion(
      id: Value(id),
      productId: Value(productId),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      sortOrder: Value(sortOrder),
    );
  }

  factory ProductNutritionImage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductNutritionImage(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'imagePath': serializer.toJson<String?>(imagePath),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ProductNutritionImage copyWith({
    int? id,
    int? productId,
    Value<String?> imagePath = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    int? sortOrder,
  }) => ProductNutritionImage(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ProductNutritionImage copyWithCompanion(
    ProductNutritionImagesCompanion data,
  ) {
    return ProductNutritionImage(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductNutritionImage(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, imagePath, imageUrl, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductNutritionImage &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.imagePath == this.imagePath &&
          other.imageUrl == this.imageUrl &&
          other.sortOrder == this.sortOrder);
}

class ProductNutritionImagesCompanion
    extends UpdateCompanion<ProductNutritionImage> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String?> imagePath;
  final Value<String?> imageUrl;
  final Value<int> sortOrder;
  const ProductNutritionImagesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ProductNutritionImagesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    this.imagePath = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : productId = Value(productId);
  static Insertable<ProductNutritionImage> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? imagePath,
    Expression<String>? imageUrl,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (imagePath != null) 'image_path': imagePath,
      if (imageUrl != null) 'image_url': imageUrl,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ProductNutritionImagesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String?>? imagePath,
    Value<String?>? imageUrl,
    Value<int>? sortOrder,
  }) {
    return ProductNutritionImagesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      imagePath: imagePath ?? this.imagePath,
      imageUrl: imageUrl ?? this.imageUrl,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductNutritionImagesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('imagePath: $imagePath, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ProductNutritionValuesTable extends ProductNutritionValues
    with TableInfo<$ProductNutritionValuesTable, ProductNutritionValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductNutritionValuesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nutrientNameMeta = const VerificationMeta(
    'nutrientName',
  );
  @override
  late final GeneratedColumn<String> nutrientName = GeneratedColumn<String>(
    'nutrient_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceBasisMeta = const VerificationMeta(
    'referenceBasis',
  );
  @override
  late final GeneratedColumn<String> referenceBasis = GeneratedColumn<String>(
    'reference_basis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qualifierMeta = const VerificationMeta(
    'qualifier',
  );
  @override
  late final GeneratedColumn<String> qualifier = GeneratedColumn<String>(
    'qualifier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    nutrientName,
    amount,
    unit,
    referenceBasis,
    qualifier,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_nutrition_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductNutritionValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('nutrient_name')) {
      context.handle(
        _nutrientNameMeta,
        nutrientName.isAcceptableOrUnknown(
          data['nutrient_name']!,
          _nutrientNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nutrientNameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('reference_basis')) {
      context.handle(
        _referenceBasisMeta,
        referenceBasis.isAcceptableOrUnknown(
          data['reference_basis']!,
          _referenceBasisMeta,
        ),
      );
    }
    if (data.containsKey('qualifier')) {
      context.handle(
        _qualifierMeta,
        qualifier.isAcceptableOrUnknown(data['qualifier']!, _qualifierMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductNutritionValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductNutritionValue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      nutrientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrient_name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      referenceBasis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_basis'],
      ),
      qualifier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qualifier'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ProductNutritionValuesTable createAlias(String alias) {
    return $ProductNutritionValuesTable(attachedDatabase, alias);
  }
}

class ProductNutritionValue extends DataClass
    implements Insertable<ProductNutritionValue> {
  final int id;
  final int productId;
  final String nutrientName;
  final double amount;
  final String unit;
  final String? referenceBasis;
  final String? qualifier;
  final int sortOrder;
  const ProductNutritionValue({
    required this.id,
    required this.productId,
    required this.nutrientName,
    required this.amount,
    required this.unit,
    this.referenceBasis,
    this.qualifier,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['nutrient_name'] = Variable<String>(nutrientName);
    map['amount'] = Variable<double>(amount);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || referenceBasis != null) {
      map['reference_basis'] = Variable<String>(referenceBasis);
    }
    if (!nullToAbsent || qualifier != null) {
      map['qualifier'] = Variable<String>(qualifier);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ProductNutritionValuesCompanion toCompanion(bool nullToAbsent) {
    return ProductNutritionValuesCompanion(
      id: Value(id),
      productId: Value(productId),
      nutrientName: Value(nutrientName),
      amount: Value(amount),
      unit: Value(unit),
      referenceBasis: referenceBasis == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceBasis),
      qualifier: qualifier == null && nullToAbsent
          ? const Value.absent()
          : Value(qualifier),
      sortOrder: Value(sortOrder),
    );
  }

  factory ProductNutritionValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductNutritionValue(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      nutrientName: serializer.fromJson<String>(json['nutrientName']),
      amount: serializer.fromJson<double>(json['amount']),
      unit: serializer.fromJson<String>(json['unit']),
      referenceBasis: serializer.fromJson<String?>(json['referenceBasis']),
      qualifier: serializer.fromJson<String?>(json['qualifier']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'nutrientName': serializer.toJson<String>(nutrientName),
      'amount': serializer.toJson<double>(amount),
      'unit': serializer.toJson<String>(unit),
      'referenceBasis': serializer.toJson<String?>(referenceBasis),
      'qualifier': serializer.toJson<String?>(qualifier),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ProductNutritionValue copyWith({
    int? id,
    int? productId,
    String? nutrientName,
    double? amount,
    String? unit,
    Value<String?> referenceBasis = const Value.absent(),
    Value<String?> qualifier = const Value.absent(),
    int? sortOrder,
  }) => ProductNutritionValue(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    nutrientName: nutrientName ?? this.nutrientName,
    amount: amount ?? this.amount,
    unit: unit ?? this.unit,
    referenceBasis: referenceBasis.present
        ? referenceBasis.value
        : this.referenceBasis,
    qualifier: qualifier.present ? qualifier.value : this.qualifier,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ProductNutritionValue copyWithCompanion(
    ProductNutritionValuesCompanion data,
  ) {
    return ProductNutritionValue(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      nutrientName: data.nutrientName.present
          ? data.nutrientName.value
          : this.nutrientName,
      amount: data.amount.present ? data.amount.value : this.amount,
      unit: data.unit.present ? data.unit.value : this.unit,
      referenceBasis: data.referenceBasis.present
          ? data.referenceBasis.value
          : this.referenceBasis,
      qualifier: data.qualifier.present ? data.qualifier.value : this.qualifier,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductNutritionValue(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('nutrientName: $nutrientName, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('referenceBasis: $referenceBasis, ')
          ..write('qualifier: $qualifier, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    nutrientName,
    amount,
    unit,
    referenceBasis,
    qualifier,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductNutritionValue &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.nutrientName == this.nutrientName &&
          other.amount == this.amount &&
          other.unit == this.unit &&
          other.referenceBasis == this.referenceBasis &&
          other.qualifier == this.qualifier &&
          other.sortOrder == this.sortOrder);
}

class ProductNutritionValuesCompanion
    extends UpdateCompanion<ProductNutritionValue> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> nutrientName;
  final Value<double> amount;
  final Value<String> unit;
  final Value<String?> referenceBasis;
  final Value<String?> qualifier;
  final Value<int> sortOrder;
  const ProductNutritionValuesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.nutrientName = const Value.absent(),
    this.amount = const Value.absent(),
    this.unit = const Value.absent(),
    this.referenceBasis = const Value.absent(),
    this.qualifier = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ProductNutritionValuesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String nutrientName,
    required double amount,
    required String unit,
    this.referenceBasis = const Value.absent(),
    this.qualifier = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : productId = Value(productId),
       nutrientName = Value(nutrientName),
       amount = Value(amount),
       unit = Value(unit);
  static Insertable<ProductNutritionValue> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? nutrientName,
    Expression<double>? amount,
    Expression<String>? unit,
    Expression<String>? referenceBasis,
    Expression<String>? qualifier,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (nutrientName != null) 'nutrient_name': nutrientName,
      if (amount != null) 'amount': amount,
      if (unit != null) 'unit': unit,
      if (referenceBasis != null) 'reference_basis': referenceBasis,
      if (qualifier != null) 'qualifier': qualifier,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ProductNutritionValuesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? nutrientName,
    Value<double>? amount,
    Value<String>? unit,
    Value<String?>? referenceBasis,
    Value<String?>? qualifier,
    Value<int>? sortOrder,
  }) {
    return ProductNutritionValuesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      nutrientName: nutrientName ?? this.nutrientName,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      referenceBasis: referenceBasis ?? this.referenceBasis,
      qualifier: qualifier ?? this.qualifier,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (nutrientName.present) {
      map['nutrient_name'] = Variable<String>(nutrientName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (referenceBasis.present) {
      map['reference_basis'] = Variable<String>(referenceBasis.value);
    }
    if (qualifier.present) {
      map['qualifier'] = Variable<String>(qualifier.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductNutritionValuesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('nutrientName: $nutrientName, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('referenceBasis: $referenceBasis, ')
          ..write('qualifier: $qualifier, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductNutritionImagesTable productNutritionImages =
      $ProductNutritionImagesTable(this);
  late final $ProductNutritionValuesTable productNutritionValues =
      $ProductNutritionValuesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    productNutritionImages,
    productNutritionValues,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('product_nutrition_images', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('product_nutrition_values', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  required String name,
  required String category,
  required String description,
  required double price,
  Value<String?> presentation,
  Value<String?> productImagePath,
  Value<String?> productImageUrl,
  Value<String?> nutritionImagePath,
  Value<String?> nutritionImageUrl,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> category,
  Value<String> description,
  Value<double> price,
  Value<String?> presentation,
  Value<String?> productImagePath,
  Value<String?> productImageUrl,
  Value<String?> nutritionImagePath,
  Value<String?> nutritionImageUrl,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ProductNutritionImagesTable,
    List<ProductNutritionImage>
  >
  _productNutritionImagesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productNutritionImages,
        aliasName: 'products__id__product_nutrition_images__product_id',
      );

  $$ProductNutritionImagesTableProcessedTableManager
  get productNutritionImagesRefs {
    final manager = $$ProductNutritionImagesTableTableManager(
      $_db,
      $_db.productNutritionImages,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productNutritionImagesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ProductNutritionValuesTable,
    List<ProductNutritionValue>
  >
  _productNutritionValuesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productNutritionValues,
        aliasName: 'products__id__product_nutrition_values__product_id',
      );

  $$ProductNutritionValuesTableProcessedTableManager
  get productNutritionValuesRefs {
    final manager = $$ProductNutritionValuesTableTableManager(
      $_db,
      $_db.productNutritionValues,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productNutritionValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get presentation => $composableBuilder(
    column: $table.presentation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productImagePath => $composableBuilder(
    column: $table.productImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productImageUrl => $composableBuilder(
    column: $table.productImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nutritionImagePath => $composableBuilder(
    column: $table.nutritionImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nutritionImageUrl => $composableBuilder(
    column: $table.nutritionImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productNutritionImagesRefs(
    Expression<bool> Function($$ProductNutritionImagesTableFilterComposer f) f,
  ) {
    final $$ProductNutritionImagesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productNutritionImages,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductNutritionImagesTableFilterComposer(
                $db: $db,
                $table: $db.productNutritionImages,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> productNutritionValuesRefs(
    Expression<bool> Function($$ProductNutritionValuesTableFilterComposer f) f,
  ) {
    final $$ProductNutritionValuesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productNutritionValues,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductNutritionValuesTableFilterComposer(
                $db: $db,
                $table: $db.productNutritionValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get presentation => $composableBuilder(
    column: $table.presentation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productImagePath => $composableBuilder(
    column: $table.productImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productImageUrl => $composableBuilder(
    column: $table.productImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutritionImagePath => $composableBuilder(
    column: $table.nutritionImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutritionImageUrl => $composableBuilder(
    column: $table.nutritionImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get presentation => $composableBuilder(
    column: $table.presentation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productImagePath => $composableBuilder(
    column: $table.productImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productImageUrl => $composableBuilder(
    column: $table.productImageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nutritionImagePath => $composableBuilder(
    column: $table.nutritionImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nutritionImageUrl => $composableBuilder(
    column: $table.nutritionImageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> productNutritionImagesRefs<T extends Object>(
    Expression<T> Function($$ProductNutritionImagesTableAnnotationComposer a) f,
  ) {
    final $$ProductNutritionImagesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productNutritionImages,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductNutritionImagesTableAnnotationComposer(
                $db: $db,
                $table: $db.productNutritionImages,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> productNutritionValuesRefs<T extends Object>(
    Expression<T> Function($$ProductNutritionValuesTableAnnotationComposer a) f,
  ) {
    final $$ProductNutritionValuesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productNutritionValues,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductNutritionValuesTableAnnotationComposer(
                $db: $db,
                $table: $db.productNutritionValues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool productNutritionImagesRefs,
            bool productNutritionValuesRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String?> presentation = const Value.absent(),
                Value<String?> productImagePath = const Value.absent(),
                Value<String?> productImageUrl = const Value.absent(),
                Value<String?> nutritionImagePath = const Value.absent(),
                Value<String?> nutritionImageUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                category: category,
                description: description,
                price: price,
                presentation: presentation,
                productImagePath: productImagePath,
                productImageUrl: productImageUrl,
                nutritionImagePath: nutritionImagePath,
                nutritionImageUrl: nutritionImageUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String category,
                required String description,
                required double price,
                Value<String?> presentation = const Value.absent(),
                Value<String?> productImagePath = const Value.absent(),
                Value<String?> productImageUrl = const Value.absent(),
                Value<String?> nutritionImagePath = const Value.absent(),
                Value<String?> nutritionImageUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                category: category,
                description: description,
                price: price,
                presentation: presentation,
                productImagePath: productImagePath,
                productImageUrl: productImageUrl,
                nutritionImagePath: nutritionImagePath,
                nutritionImageUrl: nutritionImageUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTable, Product>(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                productNutritionImagesRefs = false,
                productNutritionValuesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (productNutritionImagesRefs) db.productNutritionImages,
                    if (productNutritionValuesRefs) db.productNutritionValues,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (productNutritionImagesRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          ProductNutritionImage
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._productNutritionImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).productNutritionImagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (productNutritionValuesRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          ProductNutritionValue
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._productNutritionValuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).productNutritionValuesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool productNutritionImagesRefs,
        bool productNutritionValuesRefs,
      })
    >;
typedef $$ProductNutritionImagesTableCreateCompanionBuilder =
    ProductNutritionImagesCompanion Function({
      Value<int> id,
      required int productId,
      Value<String?> imagePath,
      Value<String?> imageUrl,
      Value<int> sortOrder,
    });
typedef $$ProductNutritionImagesTableUpdateCompanionBuilder =
    ProductNutritionImagesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String?> imagePath,
      Value<String?> imageUrl,
      Value<int> sortOrder,
    });

final class $$ProductNutritionImagesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductNutritionImagesTable,
          ProductNutritionImage
        > {
  $$ProductNutritionImagesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) => db.products
      .createAlias('product_nutrition_images__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductNutritionImagesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductNutritionImagesTable> {
  $$ProductNutritionImagesTableFilterComposer({
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

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductNutritionImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductNutritionImagesTable> {
  $$ProductNutritionImagesTableOrderingComposer({
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

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductNutritionImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductNutritionImagesTable> {
  $$ProductNutritionImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductNutritionImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductNutritionImagesTable,
          ProductNutritionImage,
          $$ProductNutritionImagesTableFilterComposer,
          $$ProductNutritionImagesTableOrderingComposer,
          $$ProductNutritionImagesTableAnnotationComposer,
          $$ProductNutritionImagesTableCreateCompanionBuilder,
          $$ProductNutritionImagesTableUpdateCompanionBuilder,
          (ProductNutritionImage, $$ProductNutritionImagesTableReferences),
          ProductNutritionImage,
          PrefetchHooks Function({bool productId})
        > {
  $$ProductNutritionImagesTableTableManager(
    _$AppDatabase db,
    $ProductNutritionImagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductNutritionImagesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ProductNutritionImagesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProductNutritionImagesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ProductNutritionImagesCompanion(
                id: id,
                productId: productId,
                imagePath: imagePath,
                imageUrl: imageUrl,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                Value<String?> imagePath = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ProductNutritionImagesCompanion.insert(
                id: id,
                productId: productId,
                imagePath: imagePath,
                imageUrl: imageUrl,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ProductNutritionImagesTable,
                    ProductNutritionImage
                  >(table),
                  $$ProductNutritionImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$ProductNutritionImagesTableReferences
                            ._productIdTable(db),
                        referencedColumn:
                            $$ProductNutritionImagesTableReferences
                                ._productIdTable(db)
                                .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductNutritionImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductNutritionImagesTable,
      ProductNutritionImage,
      $$ProductNutritionImagesTableFilterComposer,
      $$ProductNutritionImagesTableOrderingComposer,
      $$ProductNutritionImagesTableAnnotationComposer,
      $$ProductNutritionImagesTableCreateCompanionBuilder,
      $$ProductNutritionImagesTableUpdateCompanionBuilder,
      (ProductNutritionImage, $$ProductNutritionImagesTableReferences),
      ProductNutritionImage,
      PrefetchHooks Function({bool productId})
    >;
typedef $$ProductNutritionValuesTableCreateCompanionBuilder =
    ProductNutritionValuesCompanion Function({
      Value<int> id,
      required int productId,
      required String nutrientName,
      required double amount,
      required String unit,
      Value<String?> referenceBasis,
      Value<String?> qualifier,
      Value<int> sortOrder,
    });
typedef $$ProductNutritionValuesTableUpdateCompanionBuilder =
    ProductNutritionValuesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> nutrientName,
      Value<double> amount,
      Value<String> unit,
      Value<String?> referenceBasis,
      Value<String?> qualifier,
      Value<int> sortOrder,
    });

final class $$ProductNutritionValuesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductNutritionValuesTable,
          ProductNutritionValue
        > {
  $$ProductNutritionValuesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) => db.products
      .createAlias('product_nutrition_values__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductNutritionValuesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductNutritionValuesTable> {
  $$ProductNutritionValuesTableFilterComposer({
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

  ColumnFilters<String> get nutrientName => $composableBuilder(
    column: $table.nutrientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceBasis => $composableBuilder(
    column: $table.referenceBasis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qualifier => $composableBuilder(
    column: $table.qualifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductNutritionValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductNutritionValuesTable> {
  $$ProductNutritionValuesTableOrderingComposer({
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

  ColumnOrderings<String> get nutrientName => $composableBuilder(
    column: $table.nutrientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceBasis => $composableBuilder(
    column: $table.referenceBasis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qualifier => $composableBuilder(
    column: $table.qualifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductNutritionValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductNutritionValuesTable> {
  $$ProductNutritionValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nutrientName => $composableBuilder(
    column: $table.nutrientName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get referenceBasis => $composableBuilder(
    column: $table.referenceBasis,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qualifier =>
      $composableBuilder(column: $table.qualifier, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductNutritionValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductNutritionValuesTable,
          ProductNutritionValue,
          $$ProductNutritionValuesTableFilterComposer,
          $$ProductNutritionValuesTableOrderingComposer,
          $$ProductNutritionValuesTableAnnotationComposer,
          $$ProductNutritionValuesTableCreateCompanionBuilder,
          $$ProductNutritionValuesTableUpdateCompanionBuilder,
          (ProductNutritionValue, $$ProductNutritionValuesTableReferences),
          ProductNutritionValue,
          PrefetchHooks Function({bool productId})
        > {
  $$ProductNutritionValuesTableTableManager(
    _$AppDatabase db,
    $ProductNutritionValuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductNutritionValuesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ProductNutritionValuesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProductNutritionValuesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> nutrientName = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> referenceBasis = const Value.absent(),
                Value<String?> qualifier = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ProductNutritionValuesCompanion(
                id: id,
                productId: productId,
                nutrientName: nutrientName,
                amount: amount,
                unit: unit,
                referenceBasis: referenceBasis,
                qualifier: qualifier,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String nutrientName,
                required double amount,
                required String unit,
                Value<String?> referenceBasis = const Value.absent(),
                Value<String?> qualifier = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ProductNutritionValuesCompanion.insert(
                id: id,
                productId: productId,
                nutrientName: nutrientName,
                amount: amount,
                unit: unit,
                referenceBasis: referenceBasis,
                qualifier: qualifier,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ProductNutritionValuesTable,
                    ProductNutritionValue
                  >(table),
                  $$ProductNutritionValuesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$ProductNutritionValuesTableReferences
                            ._productIdTable(db),
                        referencedColumn:
                            $$ProductNutritionValuesTableReferences
                                ._productIdTable(db)
                                .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductNutritionValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductNutritionValuesTable,
      ProductNutritionValue,
      $$ProductNutritionValuesTableFilterComposer,
      $$ProductNutritionValuesTableOrderingComposer,
      $$ProductNutritionValuesTableAnnotationComposer,
      $$ProductNutritionValuesTableCreateCompanionBuilder,
      $$ProductNutritionValuesTableUpdateCompanionBuilder,
      (ProductNutritionValue, $$ProductNutritionValuesTableReferences),
      ProductNutritionValue,
      PrefetchHooks Function({bool productId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ProductNutritionImagesTableTableManager get productNutritionImages =>
      $$ProductNutritionImagesTableTableManager(
        _db,
        _db.productNutritionImages,
      );
  $$ProductNutritionValuesTableTableManager get productNutritionValues =>
      $$ProductNutritionValuesTableTableManager(
        _db,
        _db.productNutritionValues,
      );
}
