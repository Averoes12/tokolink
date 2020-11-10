import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import 'infrastructure/implementations/category_repository_impl.dart';
import 'infrastructure/implementations/coupon_repository_impl.dart';
import 'infrastructure/implementations/product_repository_impl.dart';
import 'infrastructure/implementations/region_repository_impl.dart';
import 'infrastructure/repositories/category_repository.dart';
import 'infrastructure/repositories/coupon_repository.dart';
import 'infrastructure/repositories/product_repository.dart';
import 'infrastructure/repositories/region_repository.dart';
import 'presentation/screens/root_screen.dart';

void main() {
  serviceLocator();
  setupLogging();
  runApp(RootScreen());
}

void serviceLocator() {
  GetIt.I.registerFactory<CategoryRepository>(() => CategoryRepositoryImpl());
  GetIt.I.registerFactory<CouponRepository>(() => CouponRepositoryImpl());
  GetIt.I.registerFactory<ProductRepository>(() => ProductRepositoryImpl());
  GetIt.I.registerFactory<RegionRepository>(() => RegionRepositoryImpl());
}

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
