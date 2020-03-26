within TheSysConExe.GEOTABS.BaseClasses.Constructions;
record GEOTABSFloor "GEOTABS floor"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    incLastLay = IDEAS.Types.Tilt.Floor,
    locGain={3,4},
    mats={TheSysConExe.GEOTABS.BaseClasses.Constructions.Materials.Concrete(d=0.10),
    IDEAS.Buildings.Data.Insulation.Rockwool(d=0.21),
    TheSysConExe.GEOTABS.BaseClasses.Constructions.Materials.Concrete(d=0.14),
    TheSysConExe.GEOTABS.BaseClasses.Constructions.Materials.Concrete(d=0.03),
    TheSysConExe.GEOTABS.BaseClasses.Constructions.Materials.Concrete(d=0.03)});
end GEOTABSFloor;
