import 'package:listinha/app/features/products/products_viewmodel.dart';
import 'package:listinha/app/repositories/products_repository.dart';
import 'package:provider/provider.dart';

final providers = [
  Provider<ProductsRepository>(
    create: (context) => ProductsRepository(),
  ),
  ChangeNotifierProvider<ProductsViewmodel>(
    create: (context) => ProductsViewmodel(
      productsRepository: context.read(),
    ),
  ),
];
