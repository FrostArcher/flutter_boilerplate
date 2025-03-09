import 'package:hive_flutter/adapters.dart';
import 'package:newappmytectra/entry/models/user.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0; // Ensure this is unique for each class you adapt

  @override
  User read(BinaryReader reader) {
    // Deserialization logic
    final name = reader.readString();
    final address = reader.readString();
    final phoneNumber = reader.readString();
    return User(name: name, address: address,phoneNumber: phoneNumber);
  }

  @override
  void write(BinaryWriter writer, User obj) {
    // Serialization logic
    writer.writeString(obj.name);
    writer.writeString(obj.address);
    writer.writeString(obj.phoneNumber);
  }
}