import 'package:flutter/material.dart';
import 'package:listinha/app/providers.dart';
import 'package:listinha/app/routes.dart';
import 'package:listinha/app/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable: themeNotifier,
            builder: (context, theme, _) {
              return MaterialApp.router(
                title: 'Listinha',
                debugShowCheckedModeBanner: false,
                theme: (theme == ThemeMode.light)
                    ? ListinhaTheme.lightTheme
                    : ListinhaTheme.darkTheme,
                routerConfig: routes,
                // home: ProductsScreen(
                //   productsViewmodel: context.read(),
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
