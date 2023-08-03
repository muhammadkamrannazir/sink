import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sink/common/auth.dart';
import 'package:sink/common/calendar.dart';
import 'package:sink/models/category.dart';
import 'package:sink/models/entry.dart';
import 'package:sink/repository/firestore.dart';
import 'package:sink/theme/palette.dart';

@immutable
class AppState {
  final String userId;
  final String? userEmail;
  final AuthenticationStatus authStatus;
  final bool registrationInProgress;
  final bool registrationSuccess;
  final bool signInInProgress;
  final String authenticationErrorMessage;
  final List<Entry> removed;
  final Set<Category> categories;
  // TODO: must be at least one default category
  final bool areCategoriesLoading;
  final Set<Color> availableColors;
  final DoubleLinkedQueueEntry<DateTime>? selectedMonth;
  final DoubleLinkedQueue<DateTime> viewableMonths;
  final FirestoreDatabase database;

  AppState({
    required this.userId,
    this.userEmail,
    required this.authStatus,
    required this.registrationInProgress,
    required this.registrationSuccess,
    required this.signInInProgress,
    required this.authenticationErrorMessage,
    required this.removed,
    required this.categories,
    required this.areCategoriesLoading,
    required this.availableColors,
    this.selectedMonth,
    required this.viewableMonths,
    required this.database,
  });

  AppState copyWith({
    String? userId,
    String? userEmail,
    AuthenticationStatus? authStatus,
    bool? registrationInProgress,
    bool? registrationSuccess,
    bool? signInInProgress,
    String? authenticationErrorMessage,
    List<Entry>? removed,
    Set<Category>? categories,
    bool? areCategoriesLoading,
    Set<Color>? availableColors,
    DoubleLinkedQueueEntry<DateTime>? selectedMonth,
    DoubleLinkedQueue<DateTime>? viewableMonths,
    FirestoreDatabase? database,
  }) {
    return AppState(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      authStatus: authStatus ?? this.authStatus,
      registrationInProgress:
          registrationInProgress ?? this.registrationInProgress,
      registrationSuccess: registrationSuccess ?? this.registrationSuccess,
      signInInProgress: signInInProgress ?? this.signInInProgress,
      authenticationErrorMessage:
          authenticationErrorMessage ?? this.authenticationErrorMessage,
      removed: removed ?? this.removed,
      categories: categories ?? this.categories,
      areCategoriesLoading: areCategoriesLoading ?? this.areCategoriesLoading,
      availableColors: availableColors ?? this.availableColors,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      viewableMonths: viewableMonths ?? this.viewableMonths,
      database: database ?? this.database,
    );
  }
}

String? chooseOldOrNull(String? old, String? fresh) {
  if (fresh == null) {
    return old;
  } else if (fresh == "") {
    return null;
  } else {
    return fresh;
  }
}
