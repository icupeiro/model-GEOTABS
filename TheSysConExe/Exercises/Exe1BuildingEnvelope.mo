within TheSysConExe.Exercises;
model Exe1BuildingEnvelope
  "Building envelope model with two zones and office occupancy"
  extends IDEAS.Examples.Tutorial.Example5(rectangularZoneTemplate(
      redeclare BaseClases.Comfort comfort(setCoo=occ.setCoo, setHea=occ.setHea),
      redeclare BaseClases.Occupancy occNum(k=occ.k),
      l=sqrt(occ.A),
      w=sqrt(occ.A),
      AZone=occ.A), rectangularZoneTemplate1(
      redeclare BaseClases.Comfort comfort(setCoo=occ.setCoo, setHea=occ.setHea),
      redeclare BaseClases.Occupancy occNum(k=occ.k),
      l=sqrt(occ.A),
      w=sqrt(occ.A),
      AZone=occ.A)) annotation (
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));

  BaseClases.Occupancy occ(
    linearise=false,
    A=50,
    setHeaOcc=21 + 273.15,
    setHeaUno=21 + 273.15,
    setCooOcc=23 + 273.15,
    setCooUno=23 + 273.15,
    k=5)
    "Occupancy schedule and setpoints for each of the zones in the building"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

  annotation (
    experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{120,100}})));

end Exe1BuildingEnvelope;
