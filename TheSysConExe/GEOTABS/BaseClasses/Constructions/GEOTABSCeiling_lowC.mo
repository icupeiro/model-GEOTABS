within TheSysConExe.GEOTABS.BaseClasses.Constructions;
record GEOTABSCeiling_lowC "GEOTABS ceiling"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay = IDEAS.Types.Tilt.Ceiling,
    mats={TheSysConExe.GEOTABS.BaseClasses.Constructions.Materials.Concrete_lowC(d=0.05),
    IDEAS.Buildings.Data.Insulation.Rockwool(d=0.21),
    TheSysConExe.GEOTABS.BaseClasses.Constructions.Materials.Concrete_lowC(d=0.19),
    TheSysConExe.GEOTABS.BaseClasses.Constructions.Materials.Concrete_lowC(d=0.06)});
end GEOTABSCeiling_lowC;
