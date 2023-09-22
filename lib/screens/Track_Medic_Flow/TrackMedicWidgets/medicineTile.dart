import 'package:cathartic_gofer/models/medicineSheduleModel.dart';
import 'package:cathartic_gofer/provider/medicineSheduleProvider.dart';
import 'package:cathartic_gofer/screens/Track_Medic_Flow/TrackMedicWidgets/popUp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class medicineTile extends StatelessWidget {
  const medicineTile({
    super.key,
    required this.msl,
    this.isCustom = false,
  });
  final medicineSheduleModel msl;
  final isCustom;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(msl.medicine!),
            subtitle: Text(isCustom
                ? "${msl.dateTime!.toString().substring(0, 19)}"
                : "${msl.intakeMethod!} Food"),
            trailing: PopupMenuButton(
              position: PopupMenuPosition.under,
              surfaceTintColor: Colors.white,
              icon: const Icon(Icons.more_vert),
              onSelected: (int value) {
                if (value == 0) {
                  showAddList(context, msl, true, isCustom, 0);
                }
                if (value == 1) {
                  Provider.of<medicineSheduleProvider>(context, listen: false)
                      .removeMedicine(msl.id!, msl.time!);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Remove"),
                ),
                isCustom
                    ? PopupMenuItem(
                        value: 3,
                        child: Text(""),
                      )
                    : PopupMenuItem(
                        value: 0,
                        child: Text("Edit"),
                      ),
              ],
            )));
  }
}
