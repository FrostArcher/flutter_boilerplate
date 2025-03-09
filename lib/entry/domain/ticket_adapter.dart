import 'package:hive_flutter/adapters.dart';
import 'package:newappmytectra/entry/models/ticket.dart';

class TicketAdapter extends TypeAdapter<Ticket> {
  @override
  final int typeId = 1; // Ensure this is unique and different from `UserAdapter`

  @override
  Ticket read(BinaryReader reader) {
    // Deserialization logic
    final ticketNumber = reader.readString();
    final title = reader.readString();
    final description = reader.readString();
    final status = reader.readString();
    final userPhone = reader.readString();
    final createdTime = reader.readString();
    final updatedTime = reader.readString();
    final servicePrice = reader.readDouble();
    final serviceDays = reader.readInt();
    final underWarranty = reader.readBool();
    return Ticket(
        ticketNumber: ticketNumber,
        title: title,
        description: description,
        status: status,
        userPhone: userPhone,
        createdTime: DateTime.parse(createdTime),
        updatedTime: DateTime.parse(updatedTime),
        serviceEstimationPrice: servicePrice,
        serviceEstimationDays: serviceDays,
        underWarranty: underWarranty
    );
  }

  @override
  void write(BinaryWriter writer, Ticket obj) {
    // Serialization logic
    writer.writeString(obj.ticketNumber);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeString(obj.status);
    writer.writeString(obj.userPhone);
    writer.writeString(obj.createdTime.toString());
    writer.writeString(obj.updatedTime.toString());
    writer.writeDouble(obj.serviceEstimationPrice);
    writer.writeInt(obj.serviceEstimationDays);
    writer.writeBool(obj.underWarranty);
  }
}