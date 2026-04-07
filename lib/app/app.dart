import 'package:flutter/material.dart';
import 'package:listinha/app/features/products/products_viewmodel.dart';
import 'package:listinha/app/repositories/products_repository.dart';
import 'package:listinha/app/routes.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductsRepository>(
          create: (context) => ProductsRepository(),
        ),
        ChangeNotifierProvider<ProductsViewmodel>(
          create: (context) => ProductsViewmodel(
            productsRepository: context.read(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Listinha',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.teal,
              ),
            ),
            routerConfig: routes,
            // home: ProductsScreen(
            //   productsViewmodel: context.read(),
            // ),
          );
        },
      ),
    );
  }
}
