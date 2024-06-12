part of 'management_bloc.dart';

@immutable
sealed class ManagementState {}

final class LoadingScreenInitialState extends ManagementState {}

final class SuccessDataRetrievingState extends ManagementState {}

final class ErrorDataRetrievingState extends ManagementState {}
