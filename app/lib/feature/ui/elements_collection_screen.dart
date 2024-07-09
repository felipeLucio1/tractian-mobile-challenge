// ignore_for_file: library_private_types_in_public_api
import 'package:app/data/model/assets_group.dart';
import 'package:app/data/model/company.dart';
import 'package:app/data/model/company_components.dart';
import 'package:app/data/model/locations_group.dart';
import 'package:app/feature/bloc/cmponents_bloc/bloc/components_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late Company _company;

class ElementsCollectionScreen extends StatefulWidget {
  ElementsCollectionScreen({super.key, required Company company}) {
    _company = company;
  }

  @override
  State<ElementsCollectionScreen> createState() =>
      _ElementsCollectionScreenState();
}

class _ElementsCollectionScreenState extends State<ElementsCollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Componentes')),
        body: const ComponentsList(),
      ),
    );
  }
}

class ComponentsList extends StatefulWidget {
  const ComponentsList({super.key});

  @override
  State<ComponentsList> createState() => _ComponentsListState();
}

class _ComponentsListState extends State<ComponentsList> {
  @override
  Widget build(BuildContext context) {
    CompanyComponents? components;
    return BlocProvider<ComponentsBloc>(
      create: (context) => ComponentsBloc(),
      child: BlocBuilder<ComponentsBloc, ComponentsState>(
        builder: (BuildContext context, ComponentsState state) {
          switch (state) {
            case LoadingComponentsScreenState():
              context
                  .read<ComponentsBloc>()
                  .add(LoadOrphanElementsEvent(company: _company));
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SuccessRetrievingElementsState():
              components = state.companyComponents;
              List<dynamic> list = [];
              for (var item in components!.aloneAssetsList) {
                list.add(item);
              }
              for (var item in components!.locationsGroupList) {
                list.add(item);
              }
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    String title = 'vazio';
                    if (list[index] is AssetsGroup) {
                      title = list[index].asset.name;
                    } else if (list[index] is LocationsGroup) {
                      title = list[index].local.name;
                    }
                    return ExpansionTile(
                      title: Text(title),
                    );
                  });
            case SuccessRetrievingAssetInfoState():
              return SingleChildScrollView(
                child: ExpansionPanelList(
                  children: state.assetsGroupChildren.map<ExpansionPanel>(
                    (AssetsGroup assetItem) {
                      return expansionPanelItem(
                          assetItem: assetItem, locationItem: null);
                    },
                  ).toList(),
                ),
              );

            case SuccessRetrievingSublocationsInfoState():
              return SingleChildScrollView(
                child: ExpansionPanelList(
                  children: state.locationsGroupChildren.map<ExpansionPanel>(
                    (LocationsGroup locationItem) {
                      return expansionPanelItem(
                          assetItem: null, locationItem: locationItem);
                    },
                  ).toList(),
                ),
              );

            default:
              return const Text('Oops! Algo deu errado.');
          }
        },
      ),
    );
  }

  ExpansionPanel expansionPanelItem(
      {AssetsGroup? assetItem, LocationsGroup? locationItem}) {
    late final ExpansionPanel expansionPanel;
    if (assetItem != null) {
      expansionPanel = ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return SingleChildScrollView(
              child: ListTile(
            title: Text(assetItem.asset.name),
          ));
        },
        body: const ExpansionPanelList(
          children: [],
        ),
        isExpanded: true,
        canTapOnHeader: true,
      );
    } else if (locationItem != null) {
      expansionPanel = ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: Text(locationItem.location.name),
          );
        },
        body: const ExpansionPanelList(
          children: [],
        ),
        isExpanded: false,
        canTapOnHeader: true,
      );
    } else {
      expansionPanel = ExpansionPanel(
        headerBuilder: (context, isExpanded) =>
            const Text('Erro ao carregar item'),
        body: const ExpansionPanelList(
          children: [],
        ),
      );
    }

    return expansionPanel;
  }
}
