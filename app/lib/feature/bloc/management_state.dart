part of 'management_bloc.dart';

@immutable
sealed class ManagementState {}

final class LoadingScreenState extends ManagementState {}

final class SuccessDataRetrievingCompaniesState extends ManagementState {
  final Stream<List<Company>> _companiesList;

  SuccessDataRetrievingCompaniesState(
      Stream<List<Company>> this._companiesList);

  Stream<List<Company>> get companies => _companiesList;
}

final class ErrorDataRetrievingCompaniesState extends ManagementState {}

final class SuccessRetrievingCompanyElementsState extends ManagementState {
  late final Stream<CompanyComponents> _companyComponents;

  SuccessRetrievingCompanyElementsState(
      Stream<CompanyComponents> this._companyComponents);

  Stream<CompanyComponents> get companyComponents => _companyComponents;
}

final class ErrorDataRetrievingCompanyElementsState extends ManagementState {}

final class SuccessRetrievingAssetInfoState extends ManagementState {
  // ignore: unused_field
  late final Stream<List<AssetsGroup>> _assetsGroupChildren;

  SuccessRetrievingAssetInfoState(
      Stream<List<AssetsGroup>> this._assetsGroupChildren);
}

final class SuccessRetrievingLocationAssetsInfoState extends ManagementState {
  // ignore: unused_field
  late final Stream<List> _locationsGrupAssetsChildren;
  // ignore: unused_field
  late final Stream<List<LocationsGroup>> _locationsGroupChildren;

  SuccessRetrievingLocationAssetsInfoState(
      Stream<List<LocationsGroup>> this._locationsGrupAssetsChildren,
      Stream<List<LocationsGroup>> this._locationsGroupChildren);
}

final class SuccessRetrievingSublocationsInfoState extends ManagementState {
  // ignore: unused_field
  late final Stream<List<LocationsGroup>> _locationsGroupChildren;

  SuccessRetrievingSublocationsInfoState(
      Stream<List<LocationsGroup>> this._locationsGroupChildren);
}

final class ErrorRetrievingElementInfoState extends ManagementState {}

final class SearchFilterState extends ManagementState {
  // ignore: unused_field
  late final Stream<SearchObj> _searchResults;

  SearchFilterState(Stream<SearchObj> this._searchResults);
}

final class ShowChoosenResultState extends ManagementState {
  // ignore: unused_field
  late final Stream<List<ResultComponent>>? _choosenResult;

  ShowChoosenResultState(Stream<List<ResultComponent>>? this._choosenResult);
}

final class FIlteringCricalStatusSensorsState extends ManagementState {
  late final Stream<List<List<ResultComponent>>> sensorList;

  FIlteringCricalStatusSensorsState(
      Stream<List<List<ResultComponent>>> this.sensorList);
}

final class FIlteringEnergySensorsState extends ManagementState {
  late final Stream<List<List<ResultComponent>>> energySensorList;

  FIlteringEnergySensorsState(
      Stream<List<List<ResultComponent>>> this.energySensorList);
}
