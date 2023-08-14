# Datová akademie: Projekt 1
## SQL projekt pojednávající o vývoji cen potravin a výškách mezd v letech 2006 - 2018
### Cílem tohoto projektu je připravit datové podklady a zodpovědět 5 výzkumných otázek:
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

### Postup zpracování:
Vytvoření celkem 7 `.sql` souborů:
  + 2 soubory pro tvorbu tabulek,
  + 5 souborů pro dotazování prostřednictvím vytvořených tabulek.

Vstupní datové sady pocházejí z *Portálu otevřených dat ČR*.

### Odpovědi na 5 výzkumných otázek:
1. **Ano,** mzdy rostou ve všech odvětvích.
2. V závislosti na roce, ceně produktu a výši průměného platu je možné zakoupit následující množství vybraných potravin: 

| rok / potravina | mléko [l] | chléb [kg] |
|:----------------|:---------:|:----------:|
| 2006            |   1 466   |   1 313    |
| 2018            |   1 670   |   1 365    |

3. Nejpomaleji zdražuje **cukr krystalový**. V tomto případě dokonce došlo ke zlevnění.  
4. **Ne,** v žádném roce nebyl meziroční nárůst cen potravin výrazně vyšší než růst mezd.
5. Výška HDP nemá přímý vliv na změny ve mzdách a cenách potravin. 
Pro hledání vzájemného vztahu mezi hodnotami by byla vhodná následná statistická analýza.
V rychlosti jsem pomocí Excelu stanovila korelační koeficienty - 
při sledování hodnot v témže roce vychází korelace mezi HDP a mzdami i mezi HDP a cenami mezi 0,41 - 0,44, tzn. značí střední závislost.
Při posuzování vlivu HDP na ceny v následujícím roce vychází téměř úplná nezávislost (-0,03); 
pro HDP a budoucí mzdy naopak 0,68, tzn. vyznačuje vysokou závislost. 
Korelace však neznamená kauzalitu! Tj. nevypovídá nutně o vzájemném ovlivňování.

### Závěrem
Určitě místy existují efektivnější způsoby řešení, budu vděčná za feedback! Díky :)
### Discord
marketa9432