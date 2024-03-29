part of 'animation_bloc.dart';

sealed class AnimationState extends Equatable {
  const AnimationState();

  @override
  List<Object> get props => [];
}

final class AnimationInitial extends AnimationState {}

// send value of swipe card
class ValueSwipeCardState extends AnimationState {
  const ValueSwipeCardState({
    required this.value,
  });

  final double value;

  @override
  List<Object> get props => [value];
}

// trigger to start the animation
class StartAnimationPageViewState extends AnimationState {}

// trigger to end the animation
class EndAnimationPageViewState extends AnimationState {}

// get value of zoom main card
class ValueZoomMainCardState extends AnimationState {
  const ValueZoomMainCardState({
    required this.value,
  });

  final double value;

  @override
  List<Object> get props => [value];
}
