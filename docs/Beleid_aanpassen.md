---
---

# Instructie voor het aanpassen van toegepast beleid in Hestia

Een van de toepassingen van Hestia is het onderzoeken van de effecten van beleid. Beleid wordt in Hestia ingelezen uit het beleid.csv bestand, waarbij elke rij in het bestand een (deel van een) beleidsinstrument voorstelt. Standaard staat in dit bestand actief en historisch bestaand landelijk beleid. In het functioneel ontwerp staat beschreven welke typen beleid bestaan, en wat de mogelijkheden en beperkingen van elk type zijn.

## Aanpassen of toevoegen beleidsregel

1. Open `Beleid.csv` uit
    ```
    [Hestia map]/Runs/Beleid.csv
    ```
    Pas hierbij op met het gebruik van Excel of vergelijkbaar, omdat bij het importeren van de .csv de informatie soms verkeerd geïnterpreteerd wordt, bijvoorbeeld door een andere instelling van de betekenis van komma's en punten. 
    Een minder foutgevoelige, maar minder overzichtelijke optie is het gebruik van een simpele text editor zoals Notepad++.

2. Pas een regel aan of voeg er een toe. Bij het toevoegen van een nieuwe regel is het het minst foutgevoelig om een vergelijkbare te kopiëren.
3. Sla `Beleid.csv` op. Let er hierbij op dat de formatting hetzelfde is gebleven, zeker bij het gebruik van Excel.

## Testen of het nieuwe beleid wordt begrepen door Hestia

1. Open **GeoDMS** en laad `HestiaRun.dms` in. Als het al open stond, herlaad via `Alt+R` of via **menu** &rarr;








