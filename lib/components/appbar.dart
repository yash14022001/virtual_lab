import 'package:flutter/material.dart';

PreferredSizeWidget HomeAppBar([String? title]) {
  return AppBar(
    title: Text(title ?? "Virtual Lab"),
  );
}
