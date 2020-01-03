within TheSysConExe.Solutions;
model Sol2OnOffThermostat
  "Solution of exercise 2 for building control with on-off thermostat for the pump"
  extends Exercises.Exe2OnOffThermostat(pum(inputType=IDEAS.Fluid.Types.InputType.Stages));
  Modelica.Blocks.Math.BooleanToInteger booToInt
    "Convert boolean signal into integer "
    annotation (Placement(transformation(extent={{42,70},{62,90}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-42,70},{-22,90}})));
  Modelica.Blocks.Sources.Constant OffSet(k=0.5)
    "Offset from heating set point"
    annotation (Placement(transformation(extent={{-74,92},{-54,112}})));
protected
  Modelica.Blocks.Logical.OnOffController onOffCon(bandwidth=1)
    "On off controller for switching on and off the pump of the emission system according to zone temperature readings"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
equation
  connect(booToInt.y, pum.stage) annotation (Line(points={{63,80},{80,80},{
          80,98},{130,98},{130,72}}, color={255,127,0}));
  connect(onOffCon.y, booToInt.u)
    annotation (Line(points={{21,80},{40,80}}, color={255,0,255}));
  connect(add.y, onOffCon.reference) annotation (Line(points={{-21,80},{-12,
          80},{-12,86},{-2,86}}, color={0,0,127}));
  connect(occ.setHea, add.u2) annotation (Line(points={{-58,44},{-52,44},{
          -52,74},{-44,74}}, color={0,0,127}));
  connect(add.u1, OffSet.y) annotation (Line(points={{-44,86},{-48,86},{-48,
          102},{-53,102}}, color={0,0,127}));
  connect(onOffCon.u, rectangularZoneTemplate.TSensor) annotation (Line(
        points={{-2,74},{-10,74},{-10,60},{20,60},{20,32},{11,32}}, color={
          0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{260,120}})),
      Icon(coordinateSystem(extent={{-100,-100},{260,120}})),
    experiment(StopTime=2419200),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end Sol2OnOffThermostat;
