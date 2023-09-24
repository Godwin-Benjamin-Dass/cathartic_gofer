import 'package:cathartic_gofer/user/models/dateHistoryModel.dart';
import 'package:flutter/material.dart';

class viewMedicinePage extends StatelessWidget {
  const viewMedicinePage({super.key, required this.dhm});
  final dateHistoryModel dhm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Color(0xFF0075FF),
            )),
        centerTitle: true,
        title: const Text(
          "Info",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E1E1E)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Date : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: dhm.date.toString().substring(0, 10)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Time : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: dhm.date.toString().substring(11, 16)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'When : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: dhm.time),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Status : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: dhm.isTaken! ? "Taken" : "Never took"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "List of Medicine : ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  itemCount: dhm.medicine!.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, idx) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(dhm.medicine![idx]["medicine"]),
                          subtitle: Text(dhm.medicine![idx]["intakeMethod"]),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
