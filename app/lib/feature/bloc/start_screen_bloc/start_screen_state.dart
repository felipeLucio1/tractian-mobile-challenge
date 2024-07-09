part of 'start_screen_bloc.dart';

@immutable
sealed class StartScreenState {}

final class LoadingScreenState extends StartScreenState {
  void initLoading() {
    LoadingCompaniesEvent();
  }
}

final class SuccessDataRetrievingCompaniesState extends StartScreenState {
  final List<Company> _companiesList;

  SuccessDataRetrievingCompaniesState(this._companiesList);

  List<Company> get companies => _companiesList;
}

final class ErrorDataRetrievingCompaniesState extends StartScreenState {}

final class SearchFilterState extends StartScreenState {
  // ignore: unused_field
  late final SearchObj _searchResults;

  SearchFilterState(this._searchResults);
}

final class ShowChoosenResultState extends StartScreenState {
  // ignore: unused_field
  late final List<ResultComponent>? _choosenResult;

  ShowChoosenResultState(this._choosenResult);
}

final class FIlteringCricalStatusSensorsState extends StartScreenState {
  late final List<List<ResultComponent>> sensorList;

  FIlteringCricalStatusSensorsState(this.sensorList);
}

final class FIlteringEnergySensorsState extends StartScreenState {
  late final List<List<ResultComponent>> energySensorList;

  FIlteringEnergySensorsState(this.energySensorList);
}
