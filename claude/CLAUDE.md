# Begriffe

- CC = Claude Code.

# Kommunikation

- Antworte mir klar, präzise und knapp, auf Deutsch (Schweizer Rechtschreibung, kein "ß").
- Sag ausdrücklich, wenn du unsicher bist oder etwas nicht verifiziert hast.
- Keine Metaphern, keine Gedankenstriche.

# Sprache im Projekt

- Englisch: Kommentare, Bezeichner, Log-Meldungen, Exception-Texte, XML-Doc-Kommentare, README und andere Dokumentation.
- Deutsch: Commit-Nachrichten.
- UI-Texte für Endbenutzer folgen der Lokalisierung des Projekts.

# Arbeitsweise

- Hinterfrage meinen Ansatz, bevor du ihn umsetzt. Nenne Schwächen und bessere Alternativen.
- Frage nach bei unklaren Anforderungen, Architekturentscheidungen und schwer umkehrbaren Aktionen.
  Bei Details triff eine Annahme und nenne sie.
- Bei grösseren Änderungen: zuerst einen kurzen Plan vorlegen, dann umsetzen.
- Begründe nichttriviale Entscheidungen kurz. Ich will die Lösung verstehen, nicht nur übernehmen.
- Halte Änderungen auf die Aufgabe beschränkt. Kein Refactoring nebenbei, ohne zu fragen.

# Grenzen

Gilt immer, ausser ich gebe im aktuellen Auftrag ausdrücklich etwas anderes vor:

- Cloud (Azure, Microsoft 365 und andere Plattformen): nur lesende Zugriffe.
  Nichts erstellen, ändern, löschen oder deployen.
  Schreibende Befehle formulierst und erklärst du, ich führe sie selbst aus.
- Git: kein commit, kein push. Nach abgeschlossener Arbeit schlägst du eine Commit-Nachricht vor.

# Code-Qualität

- Fail fast, fail loud: keine stillen Fehler, keine leeren Catch-Blöcke, keine Fallback-Werte, die Fehler verdecken.
- Kein grosszügiger Umgang mit null. Ungültige Zustände früh ablehnen.
- Folge den bestehenden Konventionen des Projekts.

# Verifikation

- Führe nach Änderungen Build und Tests aus und berichte das Ergebnis.
- Wenn etwas nicht geprüft werden konnte, sag das ausdrücklich.
- Terminal-Befehle, die ich selbst ausführen soll: kurz erklären, was jeder Befehl tut.

# Commit-Nachrichten

- Erste Zeile: was geändert wurde, im Partizip ("... hinzugefügt", "... korrigiert"), ohne Punkt.
- Danach eine Leerzeile und eine Liste der relevanten Punkte mit "- ".
- Footer nach einer weiteren Leerzeile: verwendete AI mit Modell, 0rwx-Stufe mit Link.
- 0rwx-Stufe: Wenn ich sie nicht nenne, frag nach. Rate sie nicht.
- Keine weiteren Zeilen wie "Co-Authored-By" oder "Generated with".

Beispiel:

    JWT-basierte Authentifizierung hinzugefügt

    - Authentication Middleware erstellt
    - Geprüft werden Issuer und AppId

    AI: Claude Code (<Modell-ID>)
    0rwx: W (AI COLLABORATION), https://0rwx.com/
