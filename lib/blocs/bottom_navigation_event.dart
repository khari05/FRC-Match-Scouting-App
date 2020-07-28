import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();
}

class PageSwitched extends BottomNavigationEvent {
  final int index;

  const PageSwitched({@required this.index});

  @override
  List<Object> get props => [index];
}
