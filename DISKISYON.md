# Diskisyon sou Aplikasyon Notifikasyon Flutter

## Deskripsyon Aplikasyon an
Aplikasyon sa a se yon demonstrasyon sou kijan pou itilize notifikasyon lokal nan Flutter. Li gen yon ekran prensipal ak plizyè bouton, chak youn deklanche yon tip notifikasyon diferan.

## Tip Notifikasyon yo
Nou itilize bibliyotèk `flutter_local_notifications` pou jere tout notifikasyon yo. Men tip nou implemente yo:

1.  **Notifikasyon Imedya**: Sa a parèt touswit lè itilizatè a peze bouton an. Li itilize metòd `show()` dirèkteman.
2.  **Notifikasyon Pwograme**: Notifikasyon sa a parèt apre yon delè (5 segonn). Nou itilize `Future.delayed()` ak `show()` pou asire ke li parèt apre delè a.
3.  **Notifikasyon Repete**: Sa a pwograme pou repete chak minit. Nou itilize `Timer.periodic()` ak `show()` pou voye notifikasyon regilye.
4.  **Gwo Tèks (Big Text)**: Sa a montre kijan pou aficha anpil tèks nan yon notifikasyon. Itilizatè a ka elaji notifikasyon an pou li tout detay yo. Li itilize `BigTextStyleInformation`.

## Defi ak Solisyon
- **Pèmisyon POST_NOTIFICATIONS**: Android 13+ mande pèmisyon `POST_NOTIFICATIONS` pou afiche notifikasyon. Nou itilize `permission_handler` pou mande pèmisyon sa a lè aplikasyon an lanse.
- **AlarmManager pa mache sou Samsung Android 14+**: Metòd `zonedSchedule()` ak `periodicallyShow()` ki itilize `AlarmManager` Android pa fonksyone sou Samsung S24 (Android 14+). Solisyon nou: itilize **timer Dart natif** (`Future.delayed` ak `Timer.periodic`) ak `show()` dirèkteman.
- **RenderFlex Overflow**: Widget `Row` ki gen ikòn ak tit te depase. Solisyon: anveloppe `Text` nan yon widget `Flexible`.

## Achitekti Kòd la
- **Pattern Singleton**: `NotificationService` itilize pattern Singleton pou garanti yon sèl instance nan tout aplikasyon an.
- **Kanal Notifikasyon**: Chak tip notifikasyon gen pwòp kanal li (channel) pou itilizatè ka kontwole yo separeman nan paramèt Android.
- **Separation of Concerns**: Lojik notifikasyon yo nan `services/notification_service.dart`, epi UI nan `main.dart`.

## Bibliyotèk Itilize
- `flutter_local_notifications` (^21.0.0-dev.1): Pou fonksyonalite notifikasyon debaz.
- `permission_handler` (^11.3.1): Pou mande pèmisyon runtime sou Android 13+.
- `dart:async` (built-in): Pou `Timer.periodic` ak `Future.delayed`.
