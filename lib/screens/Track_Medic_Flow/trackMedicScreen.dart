// ignore_for_file: use_build_context_synchronously

import 'package:cathartic_gofer/provider/medicineSheduleProvider.dart';
import 'package:cathartic_gofer/screens/Track_Medic_Flow/TrackMedicWidgets/popUp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/medicineSheduleService.dart';
import 'TrackMedicWidgets/medicineTile.dart';

class TrackMedicScreen extends StatefulWidget {
  const TrackMedicScreen({super.key});

  @override
  State<TrackMedicScreen> createState() => _TrackMedicScreenState();
}

class _TrackMedicScreenState extends State<TrackMedicScreen> {
  bool isLoading = false;
  fetchShedule() async {
    isLoading = true;
    setState(() {});
    await LocalStorage.init();

    Provider.of<medicineSheduleProvider>(context, listen: false).fetchList();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchShedule();
  }

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
          "Track Medic",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E1E1E)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showAddList(context, null, false);
              },
              icon: const Icon(
                Icons.add,
                color: Color(0xFF1E1E1E),
              ))
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<medicineSheduleProvider>(
              builder: (context, provider, child) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Morning",
                        style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.mor.length,
                          itemBuilder: (ctx, i) {
                            var data = provider.mor[i];
                            return medicineTile(
                              msl: data,
                            );
                          }),
                      const Text(
                        "Afternoon",
                        style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.aft.length,
                          itemBuilder: (ctx, i) {
                            var data = provider.aft[i];
                            return medicineTile(
                              msl: data,
                            );
                          }),
                      const Text(
                        "Night",
                        style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.nig.length,
                          itemBuilder: (ctx, i) {
                            var data = provider.nig[i];
                            return medicineTile(
                              msl: data,
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
