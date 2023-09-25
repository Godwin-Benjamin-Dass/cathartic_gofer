import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);
  void toggle() {
    state = !state;
  }
}

final userProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final doctorProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final pharmacistProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final guardianProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());
