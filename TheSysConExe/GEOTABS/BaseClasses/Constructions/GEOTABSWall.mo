within TheSysConExe.GEOTABS.BaseClasses.Constructions;
record GEOTABSWall
  "GEOTABS wall"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    mats={IDEAS.Buildings.Data.Materials.BrickMe(d=0.10),
          IDEAS.Buildings.Data.Insulation.Rockwool(d=0.16),
          IDEAS.Buildings.Data.Materials.BrickMi(d=0.15)});
end GEOTABSWall;
