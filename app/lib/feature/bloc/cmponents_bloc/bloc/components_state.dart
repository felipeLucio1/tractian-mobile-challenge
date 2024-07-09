part of 'components_bloc.dart';

@immutable
sealed class ComponentsState {}

final class LoadingComponentsScreenState extends ComponentsState {}

final class SuccessRetrievingElementsState extends ComponentsState {
  late final CompanyComponents? _companyComponents;

  SuccessRetrievingElementsState(this._companyComponents);

  CompanyComponents? get companyComponents => _companyComponents;
}

final class ErrorDataRetrievingCompanyElementsState extends ComponentsState {}

final class SuccessRetrievingAssetInfoState extends ComponentsState {
  // ignore: unused_field
  late final List<AssetsGroup> assetsGroupChildren;

  SuccessRetrievingAssetInfoState(this.assetsGroupChildren);
}

final class SuccessRetrievingLocationAssetsInfoState extends ComponentsState {
  // ignore: unused_field
  late final List<AssetsGroup> locationsGrupAssetsChildren;
  // ignore: unused_field
  late final List<LocationsGroup> locationsGroupChildren;

  SuccessRetrievingLocationAssetsInfoState(
      this.locationsGrupAssetsChildren, this.locationsGroupChildren);
}

final class SuccessRetrievingSublocationsInfoState extends ComponentsState {
  // ignore: unused_field
  late final List<LocationsGroup> locationsGroupChildren;

  SuccessRetrievingSublocationsInfoState(this.locationsGroupChildren);
}

final class ErrorRetrievingElementInfoState extends ComponentsState {}
