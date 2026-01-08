REM GeoDmsRun.exe [/PProjName] [/LLogFileName] ConfigFileName ItemNames
REM [] betekent optioneel
REM Sluit GUI-variant(GeoDmsGui.exe) af bij aanroepen van GeoDmsRun.exe (indien dit dezelfde is)
REM Resultaten worden weggeschreven in: n:/LD/%confignaam%/results/...
REM Bij nogmaals runnen worden bestanden gewoon overschreven

REM Dit bestand kan worden gebruikt om in 1x alle tabellen te exporteren die nodig zijn voor het referentiebestand die bij elke pull request voor de main branch meegeleverd dient te worden


REM aanpassingen voor machine specifieke paden
Call path/set.bat

"%exe_path%" "/L%log_dir%\HestiaRun.txt"  "%prj_dir%\Runs\HestiaRun_referentietestrun.dms" Jaarreeksen/Export/AlgemeneKPIs /Jaarreeksen/Processen /Jaarreeksen/Energielabels /Jaarreeksen/IsolatieMaatregelen

pause Totaal klaar