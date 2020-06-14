import 'package:flutter/material.dart';

const inputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0
    )
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0
    )
  )
);