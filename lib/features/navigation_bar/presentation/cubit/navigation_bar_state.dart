abstract class NavigationState {}

class NavigationChanged extends NavigationState {
  final int index;

  NavigationChanged(this.index);
}
