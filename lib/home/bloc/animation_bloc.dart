import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'animation_event.dart';
part 'animation_state.dart';

class AnimationBloc extends Bloc<AnimationEvent, AnimationState> {
  AnimationBloc() : super(AnimationInitial()) {
    // pipeline value of swipe card
    on<ValueSwipeCardEvent>((event, emit) {
      emit(ValueSwipeCardState(value: event.value));
    });

    // pipeline to start the animation
    on<StartAnimationPageViewEvent>((event, emit) {
      emit(StartAnimationPageViewState());
    });

    // pipeline to end the animation
    on<EndAnimationPageViewEvent>((event, emit) {
      emit(EndAnimationPageViewState());
    });

    // pipeline value of zoom main card
    on<ValueZoomMainCardEvent>((event, emit) {
      emit(ValueZoomMainCardState(value: event.value));
    });
  }
}
