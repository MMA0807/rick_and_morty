import 'package:json_annotation/json_annotation.dart';

enum VitalStatus {
  @JsonValue("Alive")
  alive,
  @JsonValue("Dead")
  dead,
  unknown;

  bool get isAlive => this == VitalStatus.alive;

  bool get isDead => this == VitalStatus.dead;

  bool get isUnknown => this == VitalStatus.unknown;
}
