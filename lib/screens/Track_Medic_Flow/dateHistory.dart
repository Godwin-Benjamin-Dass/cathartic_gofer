import 'package:cathartic_gofer/models/dateHistoryModel.dart';
import 'package:cathartic_gofer/screens/Track_Medic_Flow/viewMedicinePage.dart';
import 'package:cathartic_gofer/service/DateHistoryService.dart';
import 'package:flutter/material.dart';

class dateHistory extends StatefulWidget {
  const dateHistory({super.key});

  @override
  State<dateHistory> createState() => _dateHistoryState();
}

class _dateHistoryState extends State<dateHistory> {
  List<dateHistoryModel> dhm = [];
  bool isLoading = false;
  fetchShedule() async {
    isLoading = true;
    setState(() {});
    dhm = await DateHistoryService.getAllDateHistories();
    debugPrint(dhm.toString());
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchShedule();
  }

  int calculateDaysDifference(DateTime startTimestamp, DateTime endTimestamp) {
    final difference = endTimestamp.difference(startTimestamp);
    return difference.inDays;
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
          "Date Shedule",
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
            children: [
              const Text(
                "Color Representation",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("Never took medication"),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("Took medication"),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("remaining dates"),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Time Line",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    "Dates: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  dhm.isNotEmpty
                      ? Text(dhm.first.date.toString().substring(0, 10) +
                          " -> " +
                          dhm.last.date.toString().substring(0, 10))
                      : SizedBox(),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    "No Of days: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  dhm.isNotEmpty
                      ? Text(calculateDaysDifference(
                                  dhm.last.date!, dhm.last.date!) ==
                              0
                          ? "1"
                          : calculateDaysDifference(
                                  dhm.last.date!, dhm.last.date!)
                              .toString())
                      : SizedBox(),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Shedule",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15),
              ),
              const SizedBox(
                height: 8,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: dhm.length,
                      itemBuilder: (ctx, idx) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          viewMedicinePage(dhm: dhm[idx])));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: dhm[idx].date!.isBefore(DateTime.now())
                                      ? dhm[idx].isTaken!
                                          ? Colors.green
                                          : Colors.amber
                                      : Colors.grey,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(dhm[idx]
                                        .date
                                        .toString()
                                        .substring(0, 10)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(dhm[idx].time!),
                                  ],
                                )),
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
