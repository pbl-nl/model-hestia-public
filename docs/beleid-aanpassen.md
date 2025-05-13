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

2. Pas een regel aan of voeg er een toe. Bij het toevoegen van een nieuwe regel is het het minst foutgevoelig om een vergelijkbare te kopiëren. In het functioneel ontwerp staat in detail beschreven wat de mogelijkheden voor isolatiemaatregelen en installaties zijn. Ook staat hierin welke mogelijkheden er per beleidsmaatregel zijn om voorwaarden toe te voegen.
3. Sla `Beleid.csv` op. Let er hierbij op dat de formatting hetzelfde is gebleven, zeker bij het gebruik van Excel.

## Testen of het nieuwe beleid wordt begrepen door Hestia

1. Open **GeoDMS** en laad `HestiaRun.dms` in. Als het al open stond, herlaad met `Alt+R` of via **File** &rarr; **Reopen current Configuration**
2. Navigeer binnen GeoDMS naar `/Invoer/Beleid`
3. Open de map die hoort bij het type beleid dat is aangepast (**Verbod, Activatie, Normering** of **Subsidie**) en controleer of de onderstaande dingen juist zijn geïnterpreteerd in Hestia.
<details open>
<summary><b>Verbod</b></summary>
    
- **ParseDoelgroep**: Dit is een tabel die per beleidsregel met boolean waarden aangeeft voor welk type eigendom dit geldt (bijv. koophuizen, huurhuizen). Ga na of dit is zoals verwacht, m.a.w. dat er bij de doelgroepen van de nieuwe beleidsregel `True` staat en bij alle andere `False`. 
- **ParseGrondslag**: Ga hier na of de juiste verwarmingsinstallaties de waarde `True` en `False` hebben.
- **ParseVoorwaarde**: Ga hier in de submap **HuidigLabel** na of de juiste hudige energielabels de waarde `True` en `False` hebben.
  
</details>

## Testen of het nieuwe beleid effect heeft










