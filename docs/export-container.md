---

---
# Instructies voor het maken van een export container in GeoDMS

Het is handig om een export container (of te wel een nieuwe folder) te maken in GeoDMS zodat bijvoorbeeld tussenresultaten in één  oogopslag te volgen of te zien zijn en er niet elke keer weer een nieuwe folder geopend moetworden gezien met elke 'Reopen current Configuration' de folders weer dichtgaan. 

## Voorbeeld: container samenvatting investeringsbeslissingen

Om de uitleg te verduidelijken wordt er een voorbeeld gebruikt. In dit voorbeeld is het probleem dat de tussenstappen in de investeringsbeslissing van een woning niet eenvoudig in één overzicht zichtbaar zijn. Daardoor is het lastig om te bepalen wanneer een beleidsaanpassing niet het gewenste effect heeft op de uitkomsten.
De oplossing hiervoor is het creëren van een container die per woning inzicht biedt (domein = BO) in de onderstaande overzichten:
- bouwdeel- en/of productactief; is een woning bouwdeelactief, productactief of beiden
- aantal unieke ambities; aantal unieke isolatiepakketten waar een woning uit kan kiezen
- aantal geschikte opties; aantal combinaties van een uniek isolatiepakket met een installatie per categorie (ketel, hybride, all electric)
- wel/niet geschikte optie gekozen, doet de woning daadwerkelijk een investering
- gekozen isolatieambitie; welke isolatieambitie is gekozen

### Waar moet de container in te komen staan en hoe wordt de container gemaakt?
Gezien de container een inzicht per woning moet geven zal die in het domein 'BO' moeten komen te staan. Deze kan je vinden in de TussenrResultaten > StartJaar > BebouwingsComponenten > Woning > BO.
Met CTRL+E kan je de code van het domein 'BO' openen. 'BO' staat voor bebouwingsobject en is een unit waar alle woningen in een studiegebied in zitten. Een unit in GeoDMS heeft twee betekenissen:
1. domain-unit; definieert een entiteit die kenmerken (of te wel attributes) kan hebben
2. value-unit; beschrijft hoe waarden van een gegevensitem moeten worden geïnterpreteerd (bijv. eenheid)

In dit geval verwijst 'unit' naar een domeinunit. Binnen de 'BO'-unit kan de betreffende container worden aangemaakt. De exacte locatie binnen de unit maakt niet veel uit, maar in dit geval is ervoor gekozen om deze aan de onderkant te plaatsen.

Bij het maken van een container worden accolades gebruikt.

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

