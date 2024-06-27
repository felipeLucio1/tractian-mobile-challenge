part of 'management_bloc.dart';

@immutable
sealed class ManagementState {}

final class LoadingScreenState extends ManagementState {
  void initLoading() {
    LoadingCompaniesEvent();
  }
}

final class SuccessDataRetrievingCompaniesState extends ManagementState {
  final List<Company> _companiesList;

  SuccessDataRetrievingCompaniesState(this._companiesList);

  List<Company> get companies => _companiesList;
}

final class ErrorDataRetrievingCompaniesState extends ManagementState {}

final class SuccessRetrievingCompanyElementsState extends ManagementState {
  late final Future<CompanyComponents> _companyComponents;

  SuccessRetrievingCompanyElementsState(this._companyComponents);

  Future<CompanyComponents> get companyComponents => _companyComponents;
}

final class ErrorDataRetrievingCompanyElementsState extends ManagementState {}

final class SuccessRetrievingAssetInfoState extends ManagementState {
  // ignore: unused_field
  late final List<AssetsGroup> _assetsGroupChildren;

  SuccessRetrievingAssetInfoState(this._assetsGroupChildren);
}

final class SuccessRetrievingLocationAssetsInfoState extends ManagementState {
  // ignore: unused_field
  late final Stream<List> _locationsGrupAssetsChildren;
  // ignore: unused_field
  late final Stream<List<LocationsGroup>> _locationsGroupChildren;

  SuccessRetrievingLocationAssetsInfoState(
      Stream<List<LocationsGroup>> this._locationsGrupAssetsChildren,
      this._locationsGroupChildren);
}

final class SuccessRetrievingSublocationsInfoState extends ManagementState {
  // ignore: unused_field
  late final Stream<List<LocationsGroup>> _locationsGroupChildren;

  SuccessRetrievingSublocationsInfoState(this._locationsGroupChildren);
}

final class ErrorRetrievingElementInfoState extends ManagementState {}

final class SearchFilterState extends ManagementState {
  // ignore: unused_field
  late final SearchObj _searchResults;

  SearchFilterState(this._searchResults);
}

final class ShowChoosenResultState extends ManagementState {
  // ignore: unused_field
  late final List<ResultComponent>? _choosenResult;

  ShowChoosenResultState(this._choosenResult);
}

final class FIlteringCricalStatusSensorsState extends ManagementState {
  late final List<List<ResultComponent>> sensorList;

  FIlteringCricalStatusSensorsState(this.sensorList);
}

final class FIlteringEnergySensorsState extends ManagementState {
  late final List<List<ResultComponent>> energySensorList;

  FIlteringEnergySensorsState(this.energySensorList);
}
