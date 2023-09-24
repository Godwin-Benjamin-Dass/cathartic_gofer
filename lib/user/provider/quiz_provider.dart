import 'package:flutter_riverpod/flutter_riverpod.dart';

final markProvider = StateProvider<int>((ref) => 0);

final pageProvider = StateProvider<int>((ref) => 0);

class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);
  void toggle() {
    state = !state;
  }
}

final answer1Provider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final answer2Provider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());
final answer3Provider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());
final answer4Provider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());
