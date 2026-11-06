# custom_train_timetable

Personal iOS timetable and configurable Home Screen widget.

Long-press the widget, choose **Edit Widget**, and select a station. Existing 東十条,
王子神谷, and 代々木上原 configurations are preserved. Added on 2026-11-02:

- **馬喰町**: Tokyo-terminating Sobu Rapid trains, 38 weekday / 31 weekend-holiday departures.
- **馬喰横山**: Shinjuku-terminating trains and all westbound Toei express trains,
  8 weekday / 23 weekend-holiday departures. Destinations and express labels appear in the widget.
- Line-color accents: Sobu Rapid blue (`#007AC0`) and Toei Shinjuku green (`#B0BF1E`).

Schedules are bundled offline, checked 2026-11-02. The new stations use Tokyo time,
Japanese holidays through 2027, and the previous service day for departures before 03:00.
The JR Tokyo-turnback construction timetable (115 departures) applies only to the
2026-11-07 service day. Refresh the bundled timetable after future timetable revisions.

Sources: [JR East](https://timetables.jreast.co.jp/timetable/list1220.html),
[Toei weekday](https://www.kotsu.metro.tokyo.jp/subway/timetable/shinjuku/S09WD.html),
[Toei weekend/holiday](https://www.kotsu.metro.tokyo.jp/subway/timetable/shinjuku/S09WH.html),
[Cabinet Office holidays](https://www8.cao.go.jp/chosei/shukujitsu/gaiyou.html).

Validation: five scheduling unit tests and the new-station UI test passed on iOS 26.2.
The widget entity query was also run to verify both new stations are suggested and
resolve by ID while retaining the legacy station choices and default.

Added on 2026-11-06: **三田 → 東日本橋** and **東日本橋 → 三田**,
filtered to Asakusa Line エアポート快特 services in the app and widget.
Weekday and weekend/holiday schedules are bundled from the Toei timetables:
[三田 weekdays](https://www.kotsu.metro.tokyo.jp/subway/timetable/asakusa/A08ND.html),
[三田 weekends](https://www.kotsu.metro.tokyo.jp/subway/timetable/asakusa/A08NH.html),
[東日本橋 weekdays](https://www.kotsu.metro.tokyo.jp/subway/timetable/asakusa/A15SD.html),
and [東日本橋 weekends](https://www.kotsu.metro.tokyo.jp/subway/timetable/asakusa/A15SH.html).
