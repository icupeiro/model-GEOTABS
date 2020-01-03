within TheSysConExe.Exercises;
model Exe2OnOffThermostat
  "Building control by switching emission system on and off"
  extends BaseClases.envRadPumBoi;
  Modelica.Blocks.Sources.Constant const(k=60 + 273.15)
    annotation (Placement(transformation(extent={{220,40},{240,60}})));
equation
  connect(jun.port_3, radSou.port_a)
    annotation (Line(points={{90,50},{90,0}}, color={0,127,255}));
  connect(jun.port_2, radNor.port_a)
    annotation (Line(points={{80,60},{50,60},{50,0}}, color={0,127,255}));
  connect(const.y, boi.TSet) annotation (Line(points={{241,50},{256,50},{
          256,28},{222,28}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end Exe2OnOffThermostat;
