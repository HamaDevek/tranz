import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void prints(Object? object, {String? tag, String? name}) {
  if (dotenv.env['APP_DEBUG'] != 'true') {
    switch (tag) {
      case "info":
        log("\x1B[34m$object\x1B[0m",
            name: ((name ?? tag) ?? "log").toUpperCase());
        break;
      case "error":
        log("\x1B[31m$object\x1B[0m",
            name: ((name ?? tag) ?? "log").toUpperCase());
        break;
      case "warning":
        log("\x1B[33m$object\x1B[0m",
            name: ((name ?? tag) ?? "log").toUpperCase());
        break;
      case "success":
        log("\x1B[32m$object\x1B[0m",
            name: ((name ?? tag) ?? "log").toUpperCase());
        break;
      case "api":
        log("\x1B[35m$object\x1B[0m",
            name: ((name ?? tag) ?? "log").toUpperCase());
        break;
      case "token":
        log("\x1B[36m$object\x1B[0m",
            name: ((name ?? tag) ?? "log").toUpperCase());
        break;
      case "debug":
        log("\x1B[37m$object\x1B[0m",
            name: ((name ?? tag) ?? "log").toUpperCase());
        break;
      default:
        log("\x1B[0m$object\x1B[0m",
            name: ((name ?? tag) ?? "log").toUpperCase());
    }
  }
}
