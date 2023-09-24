// ignore_for_file: use_build_context_synchronously

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cathartic_gofer/user/models/dateHistoryModel.dart';
import 'package:cathartic_gofer/user/provider/medicineSheduleProvider.dart';
import 'package:cathartic_gofer/user/screens/Track_Medic_Flow/TrackMedicWidgets/popUp.dart';
import 'package:cathartic_gofer/user/screens/Track_Medic_Flow/dateHistory.dart';
import 'package:cathartic_gofer/user/screens/Track_Medic_Flow/trackMedicSettings.dart';
import 'package:cathartic_gofer/user/service/DateHistoryService.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/dateService.dart';
import '../../service/medicineSheduleService.dart';
import 'TrackMedicWidgets/medicineTile.dart';
import 'dart:math' as math;

class TrackMedicScreen extends StatefulWidget {
  const TrackMedicScreen({super.key});

  @override
  State<TrackMedicScreen> createState() => _TrackMedicScreenState();
}

class _TrackMedicScreenState extends State<TrackMedicScreen> {
  bool isLoading = false;
  List<DateTime?> _dates = [];
  bool morning = true;
  bool afternoon = false;
  bool night = false;
  bool custom = false;

  List<dateHistoryModel> dhv = [];

  fetchShedule() async {
    isLoading = true;
    setState(() {});
    await LocalStorage.init();
    await DateStorage.init();
    Provider.of<medicineSheduleProvider>(context, listen: false).fetchList();
    _dates = await DateHistoryService.getAllDates();
    debugPrint(_dates.toString());

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const trackMedicSettings()));
              },
              icon: const HeroIcon(
                HeroIcons.cog8Tooth,
                color: Colors.black,
              ))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<medicineSheduleProvider>(
              builder: (context, provider, child) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              morning = true;
                              afternoon = false;
                              night = false;
                              custom = false;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: morning ? Colors.grey : Colors.black),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Morning",
                                  style: TextStyle(
                                      color:
                                          morning ? Colors.black : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              morning = false;
                              afternoon = true;
                              night = false;
                              custom = false;

                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color:
                                      afternoon ? Colors.grey : Colors.black),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Afternoon",
                                  style: TextStyle(
                                      color: afternoon
                                          ? Colors.black
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              morning = false;
                              afternoon = false;
                              night = true;
                              custom = false;

                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: night ? Colors.grey : Colors.black),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Night",
                                  style: TextStyle(
                                      color: night ? Colors.black : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              morning = false;
                              afternoon = false;
                              night = false;
                              custom = true;

                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: custom ? Colors.grey : Colors.black),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Custom",
                                  style: TextStyle(
                                      color:
                                          custom ? Colors.black : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      morning
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.mor.length,
                              itemBuilder: (ctx, i) {
                                var data = provider.mor[i];
                                return medicineTile(
                                  msl: data,
                                );
                              })
                          : Container(),
                      afternoon
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.aft.length,
                              itemBuilder: (ctx, i) {
                                var data = provider.aft[i];
                                return medicineTile(
                                  msl: data,
                                );
                              })
                          : Container(),
                      night
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.nig.length,
                              itemBuilder: (ctx, i) {
                                var data = provider.nig[i];
                                return medicineTile(
                                  msl: data,
                                );
                              })
                          : Container(),
                      custom
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.cus.length,
                              itemBuilder: (ctx, i) {
                                var data = provider.cus[i];
                                return medicineTile(
                                  msl: data,
                                  isCustom: true,
                                );
                              })
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: Consumer<medicineSheduleProvider>(
        builder: (context, provider, child) => ExpandableFab(
          distance: 112,
          children: [
            ActionButton(
              onPressed: () {
                if (custom) {
                  showAddList(context, null, false, true, provider.cus.length);
                } else {
                  showAddList(context, null, false, false, 0);
                }
              },
              icon: const Icon(Icons.add),
            ),
            custom
                ? SizedBox()
                : ActionButton(
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final values = await showCalendarDatePicker2Dialog(
                        context: context,
                        config: CalendarDatePicker2WithActionButtonsConfig(
                          firstDayOfWeek: 1,
                          calendarType: CalendarDatePicker2Type.range,
                          selectedDayTextStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                          selectedDayHighlightColor: Colors.purple[800],
                          centerAlignModePicker: true,
                          customModePickerIcon: const SizedBox(),
                        ),
                        dialogSize: const Size(325, 400),
                        borderRadius: BorderRadius.circular(15),
                        value: _dates,
                        dialogBackgroundColor: Colors.white,
                      );
                      if (values != null) {
                        dhv.clear();

                        _dates = values;
                        var start = _dates.first;
                        var end = _dates.last;
                        for (var date = start;
                            date!.isBefore(end!.add(const Duration(days: 1)));
                            date = date.add(const Duration(days: 1))) {
                          String? mor = prefs.getString("mor") ?? "08:00";
                          String? aft = prefs.getString("aft") ?? "13:00";
                          String? nig = prefs.getString("nig") ?? "20:00";
                          debugPrint(mor.substring(0, 2));
                          debugPrint(mor.substring(3, 5));
                          if (provider.mor.isNotEmpty) {
                            print(date);

                            dhv.add(dateHistoryModel(
                                date: date.add(Duration(
                                    hours: int.parse(
                                      mor.substring(0, 2),
                                    ),
                                    minutes: int.parse(mor.substring(3, 5)))),
                                id: _dates.length.toString(),
                                isTaken: false,
                                time: "morning",
                                medicine: provider.mor,
                                type: "normal"));
                          }
                          if (provider.aft.isNotEmpty) {
                            dhv.add(dateHistoryModel(
                                date: date.add(Duration(
                                    hours: int.parse(
                                      aft.substring(0, 2),
                                    ),
                                    minutes: int.parse(aft.substring(3, 5)))),
                                id: _dates.length.toString(),
                                isTaken: false,
                                time: "afternoon",
                                medicine: provider.aft,
                                type: "normal"));
                          }
                          if (provider.nig.isNotEmpty) {
                            dhv.add(dateHistoryModel(
                                date: date.add(Duration(
                                    hours: int.parse(
                                      nig.substring(0, 2),
                                    ),
                                    minutes: int.parse(nig.substring(3, 5)))),
                                id: _dates.length.toString(),
                                time: "night",
                                isTaken: false,
                                medicine: provider.nig,
                                type: "normal"));
                          }
                        }
                        DateHistoryService.clearAllHistories();

                        DateHistoryService.saveDateHistories(dhv);
                      }
                      print(dhv.toList());
                    },
                    icon: const HeroIcon(HeroIcons.calendarDays),
                  ),
            ActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const dateHistory()));
              },
              icon: const HeroIcon(HeroIcons.clipboardDocumentCheck),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: Colors.purple[800],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            backgroundColor: Colors.purple[800],
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.purple[800],
      elevation: 4,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      height: isBig ? 128 : 36,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
