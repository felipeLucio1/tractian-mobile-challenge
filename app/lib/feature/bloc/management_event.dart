part of 'management_bloc.dart';

@immutable
sealed class ManagementEvent {}

class LoadingCompaniesEvent extends ManagementEvent {}

class LoadOrphanElementsEvent extends ManagementEvent {
  late final Company company;

  LoadOrphanElementsEvent({required Company this.company});
}

class LoadingElementInfoEvent extends ManagementEvent {
  late final AssetsGroup? assetGroup;
  late final LocationsGroup? locationGroup;

  LoadingElementInfoEvent(
      {required AssetsGroup? this.assetGroup,
      required LocationsGroup? this.locationGroup});
}

class SearchingOnAssetsListEvent extends ManagementEvent {
  late final String searchInput;
  late final String companyId;

  SearchingOnAssetsListEvent(
      {required String this.searchInput, required String this.companyId});
}

final class ChoosingResultEvent extends ManagementEvent {
  late final AssetsGroup? assetGroupItem;
  late final LocationsGroup? locationGroupItem;

  ChoosingResultEvent(
      AssetsGroup? this.assetGroupItem, LocationsGroup? this.locationGroupItem);
}

class FilteringCriticalStatusSensorsEvent extends ManagementEvent {}

class FilteringEnergyTypeSensorsEvent extends ManagementEvent {}
