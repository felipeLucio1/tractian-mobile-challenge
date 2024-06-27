part of 'management_bloc.dart';

@immutable
sealed class ManagementEvent {}

class LoadingCompaniesEvent extends ManagementEvent {}

class LoadOrphanElementsEvent extends ManagementEvent {
  late final Company company;

  LoadOrphanElementsEvent({required this.company});
}

class LoadingElementInfoEvent extends ManagementEvent {
  late final AssetsGroup? assetGroup;
  late final LocationsGroup? locationGroup;

  LoadingElementInfoEvent(
      {required this.assetGroup,
      required this.locationGroup});
}

class SearchingOnAssetsListEvent extends ManagementEvent {
  late final String searchInput;
  late final String companyId;

  SearchingOnAssetsListEvent(
      {required this.searchInput, required this.companyId});
}

final class ChoosingResultEvent extends ManagementEvent {
  late final AssetsGroup? assetGroupItem;
  late final LocationsGroup? locationGroupItem;

  ChoosingResultEvent(
      this.assetGroupItem, this.locationGroupItem);
}

class FilteringCriticalStatusSensorsEvent extends ManagementEvent {}

class FilteringEnergyTypeSensorsEvent extends ManagementEvent {}
