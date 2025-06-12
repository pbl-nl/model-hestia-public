---

---
# Exportcontainer in GeoDMS: instructies en werkwijze

Het is handig om in GeoDMS een exportcontainer (oftewel een nieuwe folder) aan te maken, zodat tussenresultaten in één oogopslag zichtbaar zijn. Zo voorkom je dat je telkens opnieuw folders moet openen, aangezien deze bij elke 'Reopen current Configuration' weer worden gesloten.

## Voorbeeld: container samenvatting investeringsbeslissingen

Om de uitleg te verduidelijken wordt er een voorbeeld gebruikt. In dit voorbeeld is de beperking dat de tussenstappen in de investeringsbeslissing van een woning niet eenvoudig in één overzicht zichtbaar zijn. Daardoor is het lastig om te bepalen wanneer een beleidsaanpassing niet het gewenste effect heeft op de uitkomsten.
De oplossing hiervoor is het creëren van een container die per woning inzicht biedt (domein = BO) in de onderstaande gewenste overzichten:
1. bouwdeel- en/of productactief; is een woning bouwdeelactief, productactief of beiden
2. aantal unieke ambities; aantal unieke isolatiepakketten waar een woning uit kan kiezen
3. aantal geschikte opties; aantal combinaties van een uniek isolatiepakket met een installatie per categorie (ketel, hybride, all electric)
4. wel/niet geschikte optie gekozen, doet de woning daadwerkelijk een investering
5. gekozen isolatieambitie; welke isolatieambitie is gekozen

### Locatie en creatie van de container

Gezien de container een inzicht per woning moet geven zal die in het domein 'BO' moeten komen te staan. Deze kan je vinden in TussenrResultaten > StartJaar > BebouwingsComponenten > Woning > BO.
Met `Ctrl+E` kan je de code van het domein 'BO' openen. 'BO' staat voor bebouwingsobject en is een unit waar alle woningen in een studiegebied in zitten. Een unit in GeoDMS heeft twee betekenissen:
1. **domain-unit**; definieert een entiteit die kenmerken (of te wel attributes) kan hebben
2. **value-unit**; beschrijft hoe waarden van een gegevensitem moeten worden geïnterpreteerd (bijv. eenheid)

In dit geval verwijst 'unit' naar een domeinunit. Binnen de 'BO'-unit kan de betreffende container worden aangemaakt. De exacte locatie binnen de unit maakt niet veel uit, maar in dit geval is ervoor gekozen om deze aan de onderkant te plaatsen.


### Inhoud van de container: wat moet erin?

Hieronder wordt het codeblok van de container weergegeven. Het doel is om de werkwijze stap voor stap te doorlopen.
```
container InvesteringenSamenvatting
		{
			attribute<bool> ProductActief 			(BO) := Activatie/ProductActief;
			attribute<bool> BouwdeelActief 			(BO) := Activatie/BouwdeelActief;
			attribute<bool> BouwdeelOfProductActief	(BO) := ProductActief || BouwdeelActief;
			attribute<bool> BouwdeelEnProductActief (BO) := ProductActief && BouwdeelActief;
		
			attribute<uint32> 	AantalUniekeAmbities 		(BO) := count(BouwdeelActieveWoning/UniekAmbitie/Bo_rel, BouwdeelActieveWoning/UniekAmbitie/Bo_rel);
			attribute<uint32> 	AantalInvesteringsopties 	(BO) := count(ActieveWoning/xInvesteringsOptie/Bo_rel, ActieveWoning/xInvesteringsOptie/Bo_rel), IntegrityCheck = 'ProductActief && BouwdeelActief ? this <= 3 * AantalUniekeAmbities : ProductActief && not(BouwdeelActief) ? this <= 3 :  this <=5', Descr = 'Isolatieambitites x GebouwoptieCategorie';
			attribute<bool> 	InvesteringGedaan			(BO) := any(ActieveWoning/Choice_per_ActieveWoning/isSelected, invert(ActieveWoning/Choice_per_ActieveWoning/xInvesteringsOptie_rel))[invert(ActieveWoning/Bo_rel)];
		}
```

Bij het aanmaken van een container worden accolades gebruikt, zoals te zien is in de bovenstaande syntax.

**Attributen** zijn data-items die verwijzen naar arrays van datawaarden. Conceptueel gezien zijn attributen kenmerken van een entiteit, vergelijkbaar met een kolom in een tabel.

In de overzichten is het **eerste** aspect de evaluatie of een woning een bouwdeel en/of een actief product heeft. De eerste vier attributen zijn gekoppeld aan deze evaluatiecriteria.

De **value-unit** wordt tussen `<>` geplaatst en krijgt de waarde `bool`, omdat de uitkomst **True** of **False** zal zijn. Vervolgens wordt de naam van de parameter aangegeven, gevolgd door de domeinunit, in dit geval (BO). De definitie wordt afgesloten met een `;`.

Met `/` navigeer je naar de betreffende container waarin de benodigde informatie is opgeslagen.
Het symbool `||` betekent 'of', terwijl `&&` wordt gebruikt om 'en' aan te geven.

Het **tweede** aspect geeft aan uit hoeveel unieke isolatieambities (unieke isolatiepakketten) een woning kan kiezen. 

<details>
<summary><b>Lees meer</b> over unieke isolatieambities</summary>
	
In totaal zijn er een enorme hoeveelheid combinaties die in theorie genomen zouden kunnen worden maar om de looptijd van een modelrun te beperken is er een voorselectie gemaakt. Hierdoor zijn er vijf relevante sets toepasbaar en worden gekozen op het spectrum van veel isoleter to niets doen. De niveaus zijn:
1. Geen (alle bouwdelen behouden huidige isolatiegraad)
2. Laag
3. Midden
4. Hoog
5. Extreem (zo veel mogelijk isolatiemaatregelen)
   
</details>

De functie `count` wordt gebruikt om het aantal unieke ambities van de betreffende attribute te tellen. Vervolgens wordt genavigeerd naar de container **BouwdeelActieveWoning**, aangezien het isolatiespoor gekoppeld is aan een woning die BouwdeelActief is, ongeacht of deze ProductActief is.

Door verder te navigeren naar **Bo_rel** blijft de structuur van de elementen binnen het domein consistent, ongeacht de omvang van het domein. De value-unit wordt gedefinieerd als een `uint32`-parameter.

Net als in het tweede aspect wordt in het **derde** aspect de `count`-functie gebruikt om het aantal geschikte opties te tellen. Dit betreft een uniek isolatiepakket met een installatie, gespecificeerd per categorie (ketel, hybride, all-electric).

<details>
<summary><b>Lees meer</b> over aantal geschikte opties</summary>
	
De aantal geschikte opties is afhankelijkvan de volgorde en verhoudingen tussen de stappen in het afwegingsschema. Het afwegingsschema kan worden geinterpreteerd als volg:
	- ProductActief en BouwdeelActief = 3 x 5 = 15 unieke combinaties
	- ProductActief en niet BouwdeelActief = 3 unieke combinaties
	- niet ProductActief en BouwdeelActief = 5 unieke combinaties
	- niet ProductActief en niet BouwdeelActief = 0 unieke combinaties
 
</details>

Verder staat in de definitie een **IntegrityCheck** wat wordt gebruikt om te controleren of een (tussen)resultaat aan bepaalde eisen voldoet, bijvoorbeeld dat alle waarden binnen een bepaald bereik moeten liggen of dat er geen gegevens mogen ontbreken. In de definitie refereert ‘this’ naar zichzelf .

In het **vierde** aspect wordt beoordeeld of een woning daadwerkelijk een investering doet. De uitkomst is wederom **True** of **False**, waardoor de **value-unit** voor deze attribuut ook wordt ingesteld als `bool`.


  
_De uitlegfragmenten in de 'Lees meer'-dropdowns zijn afkomstig uit het functioneel ontwerp van Hestia 1.0, waar een uitgebreidere toelichting te vinden is.  
Meer informatie over de syntax en de betekenis van functies is te vinden op [GeoDMS.nl](https://geodms.nl/)._
