part of 'start_screen_bloc.dart';

@immutable
sealed class StartScreenEvent {}

class LoadingCompaniesEvent extends StartScreenEvent {}

class SearchingOnAssetsListEvent extends StartScreenEvent {
  late final String searchInput;
  late final String companyId;

  SearchingOnAssetsListEvent(
      {required this.searchInput, required this.companyId});
}

final class ChoosingResultEvent extends StartScreenEvent {
  late final AssetsGroup? assetGroupItem;
  late final LocationsGroup? locationGroupItem;

  ChoosingResultEvent(this.assetGroupItem, this.locationGroupItem);
}

class FilteringCriticalStatusSensorsEvent extends StartScreenEvent {}

class FilteringEnergyTypeSensorsEvent extends StartScreenEvent {}
