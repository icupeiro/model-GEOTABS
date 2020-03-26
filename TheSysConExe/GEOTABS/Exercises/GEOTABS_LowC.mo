within TheSysConExe.GEOTABS.Exercises;
model GEOTABS_LowC
  extends GEOTABS(zonNor(redeclare
        TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSCeiling_lowC
        conTypCei, redeclare
        TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSFloor_lowC
        conTypFlo), zonSou(redeclare
        TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSCeiling_lowC
        conTypCei, redeclare
        TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSFloor_lowC
        conTypFlo));
end GEOTABS_LowC;
