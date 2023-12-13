abstract class ScannerState {}

class ScannerInitial extends ScannerState {}

class Scanning extends ScannerState {}

class ScanCompletedState extends ScannerState {
  final String data;

  ScanCompletedState(this.data);
}