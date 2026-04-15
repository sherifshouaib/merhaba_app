import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/providers/location_viewer_provider.dart';
import 'package:merhaba/main_development.dart';
import 'package:provider/provider.dart';

class LocationViewerView extends StatelessWidget {
  const LocationViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    final locationViewerProvider = Provider.of<LocationViewerProvider>(context);
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.location_viewer_label.getString(context)),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(10),
              child: OSMFlutter(
                controller: locationViewerProvider.mapController,
                osmOption: OSMOption(
                  // userTrackingOption: const UserTrackingOption(
                  //   enableTracking: true,
                  //   unFollowUser: false,
                  // ),
                  zoomOption: const ZoomOption(
                    initZoom: 12,
                    minZoomLevel: 3,
                    maxZoomLevel: 19,
                    stepZoom: 1.0,
                  ),
                  userLocationMarker: UserLocationMaker(
                    personMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.location_pin,
                        color: Colors.blue,
                        size: 60,
                      ),
                    ),
                    directionArrowMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.double_arrow,
                        color: Colors.blue,
                        size: 60,
                      ),
                    ),
                  ),
                  roadConfiguration: const RoadOption(
                    roadColor: Colors.yellowAccent,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await locationViewerProvider.setCurrentLocation();
                    GoRouter.of(
                      context,
                    ).pop(locationViewerProvider.currentLocation);
                  },
                  child: Text(
                    AppLocale.confirm_location_label.getString(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
