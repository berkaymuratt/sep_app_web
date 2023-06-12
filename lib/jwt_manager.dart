import 'dart:html';
import 'package:flutter/cupertino.dart';

class JwtManager {
  void setJwtToken(String jwt) {
    document.cookie = "sep-token=$jwt";
  }

  void clearToken() {
    document.cookie = "sep-token=;";
  }

  String get jwtToken {
    final cookie = document.cookie!;

    if (!cookie.contains("sep-token")) {
      return "";
    }

    final entity = cookie.split("; ").map((item) {
      final split = item.split("=");
      return MapEntry(split[0], split[1]);
    });

    final cookieMap = Map.fromEntries(entity);

    return cookieMap['sep-token'] ?? "";
  }
}