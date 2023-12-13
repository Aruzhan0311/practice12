import 'package:flutter_bloc/flutter_bloc.dart';
import 'scanner_event.dart';
import 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(ScannerInitial()) {
    on<StartScanning>((event, emit) => emit(Scanning()));
    on<ScanCompleted>((event, emit) => emit(ScanCompletedState(event.data)));
  }
}