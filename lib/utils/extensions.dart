import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newappmytectra/utils/localizations.dart';
import 'package:newappmytectra/utils/session.dart';

extension ExtString on String {
  String tr(BuildContext context, [Map<String, dynamic>? args]) {
    return AppLocalizations.of(context)?.translate(this, args) ?? this;
  }

  DateTime? toDateTime() {
    return DateTime.tryParse(this);
  }

  String toTitleCase() {
    var first = trim().substring(0, 1);
    var rem = trim().substring(1);
    return "${first.toUpperCase()}$rem";
  }
}

extension ExtNum on num {
  String get formatCurrency {
    return NumberFormat.currency(symbol: "\u20b9", decimalDigits: 0).format(this);
  }
}

extension ExtDateTime on DateTime {
  DateTime get onlyDate {
    return DateTime(year, month, day);
  }

  bool get withinWeek {
    var now = DateTime.now().onlyDate;
    var time = onlyDate;
    return time.difference(now).inDays <= 7;
  }

  bool get isToday {
    var now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  String format([dateOnly = false]) {
    var locale = Session.language ?? "en";
    if (locale.isEmpty) locale = "en";
    if (dateOnly) {
      try {
        var date = toLocal();
        if (date.isToday) return "today";
        return DateFormat.yMMMd(locale).format(date);
      } catch (e) {
        return toIso8601String();
      }
    }
    try {
      var date = toLocal();
      if (date.isToday) return DateFormat.jm(locale).format(date);
      if (date.withinWeek) return DateFormat.E(locale).add_jm().format(date);
      return DateFormat.MMMd(locale).format(date);
    } catch (e) {
      return toIso8601String();
    }
  }
}
