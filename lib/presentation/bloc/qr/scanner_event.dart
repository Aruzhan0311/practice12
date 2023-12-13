abstract class ScannerEvent {}

class StartScanning extends ScannerEvent {}

class ScanCompleted extends ScannerEvent {
  final String data;

  ScanCompleted(this.data);
}