part of 'components_bloc.dart';

@immutable
sealed class ComponentsEvent {}

class LoadOrphanElementsEvent extends ComponentsEvent {
  late final Company choosenCompany;

  LoadOrphanElementsEvent({required Company company}) {
    choosenCompany = company;
  }
}

class LoadingElementInfoEvent extends ComponentsEvent {
  final AssetsGroup? assetGroup;
  final LocationsGroup? locationGroup;

  LoadingElementInfoEvent(
      {required this.assetGroup, required this.locationGroup});
}
