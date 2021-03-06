import 'package:flutter/material.dart';

abstract class AnimatableWidget extends StatelessWidget {
  const AnimatableWidget({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  Animation<double> get baseAnimation => animation;
}

abstract class AnimatableStatefulWidget extends StatefulWidget {
  const AnimatableStatefulWidget({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;
}

abstract class AnimatableState<T extends AnimatableStatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  Animation<double> get baseAnimation => widget.animation;
}
