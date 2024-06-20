import 'package:app/data/api/abstract/fetch_components_api.dart';
import 'package:app/data/api/implementation/asset_api_impl.dart';
import 'package:app/data/api/implementation/company_api_impl.dart';
import 'package:app/data/api/implementation/location_api_impl.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:app/di/dependencies_register.dart' as getit;

late final FetchAssetssApi fetchAssetssApi;
late final FetchUserCompaniesApi fetchUserCompaniesApi;
late final FetchLocationsApi fetchLocationsApi;

void main() {
  getit.setupDependencies();

  fetchAssetssApi = AssetApiImpl();
  fetchUserCompaniesApi = CompanyApiImpl();
  fetchLocationsApi = LocationApiImpl();

  Repository.from(
      fetchCompanies: fetchUserCompaniesApi,
      fetchAssets: fetchAssetssApi,
      fetchLocations: fetchLocationsApi);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
