within TheSysConExe.GEOTABS.BaseClasses;
model Envelope
  extends BaseClases.BuildingEnvelope(zonNor(
      n50=1.3,
      T_start=22 + 273.15,
      redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50Tight
        interzonalAirFlow,
      redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum(nOccFix=occ.k),
      occTyp(QlatPp=0),
      l=2*sqrt(occ.A),
      w=sqrt(occ.A)/2,
      A_winA=0.4*zonNor.l*zonNor.h,
      fracA=0,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSWall
        conTypA,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSWall
        conTypB,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSWall
        conTypD,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSCeiling
        conTypCei,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSFloor
        conTypFlo), zonSou(
      n50=1.3,
      T_start=22 + 273.15,
      redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50Tight
        interzonalAirFlow,
      redeclare IDEAS.Buildings.Components.Occupants.Fixed occNum(nOccFix=occ.k),
      occTyp(QlatPp=0),
      l=2*sqrt(occ.A),
      w=sqrt(occ.A)/2,
      A_winC=0.4*zonSou.l*zonSou.h,
      fracC=0,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSWall
        conTypB,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSWall
        conTypC,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSWall
        conTypD,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSCeiling
        conTypCei,
      redeclare TheSysConExe.GEOTABS.BaseClasses.Constructions.GEOTABSFloor
        conTypFlo));

  BaseClases.Occupancy occ(
    linearise=false,
    A=500,
    setHeaOcc=21 + 273.15,
    setHeaUno=21 + 273.15,
    setCooOcc=24.5 + 273.15,
    setCooUno=24.5 + 273.15,
    k=30)
    "Occupancy schedule and setpoints for each of the zones in the building"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  annotation (experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_fixedstepsize=15,
      __Dymola_Algorithm="Euler"));
end Envelope;
