part of 'animation_bloc.dart';

sealed class AnimationEvent extends Equatable {
  const AnimationEvent();

  @override
  List<Object> get props => [];
}

// get value of swipe card
class ValueSwipeCardEvent extends AnimationEvent {
  const ValueSwipeCardEvent({
    required this.value,
  });

  final double value;

  @override
  List<Object> get props => [value];
}

// trigger to start the animation
class StartAnimationPageViewEvent extends AnimationEvent {}

// trigger to end the animation
class EndAnimationPageViewEvent extends AnimationEvent {}

// get value of zoom main card
class ValueZoomMainCardEvent extends AnimationEvent {
  const ValueZoomMainCardEvent({
    required this.value,
  });

  final double value;

  @override
  List<Object> get props => [value];
}
