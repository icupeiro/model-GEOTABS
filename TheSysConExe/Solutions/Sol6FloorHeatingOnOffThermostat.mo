within TheSysConExe.Solutions;
model Sol6FloorHeatingOnOffThermostat
  "Solution of exercise with floor heating, heat pump, and on off thermostat"
  extends Exercises.Exe6FloorHeatingOnOffThermostat;
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
    "On off controller for switching on and off the pump of the production and emission systems"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
equation
  connect(booToInt.y, pum.stage) annotation (Line(points={{63,80},{82,80},{82,98},
          {130,98},{130,72}},        color={255,127,0}));
  connect(onOffCon.y,booToInt. u)
    annotation (Line(points={{21,80},{40,80}}, color={255,0,255}));
  connect(add.y,onOffCon. reference) annotation (Line(points={{-21,80},{-12,
          80},{-12,86},{-2,86}}, color={0,0,127}));
  connect(occ.setHea,add. u2) annotation (Line(points={{-58,44},{-52,44},{
          -52,74},{-44,74}}, color={0,0,127}));
  connect(add.u1,OffSet. y) annotation (Line(points={{-44,86},{-48,86},{-48,
          102},{-53,102}}, color={0,0,127}));
  connect(booToInt.y, heaPum.stage) annotation (Line(points={{63,80},{82,80},{82,
          112},{338,112},{338,-74},{243,-74},{243,-20}}, color={255,127,0}));
  connect(booToInt.y, pumPrim.stage) annotation (Line(points={{63,80},{82,80},{82,
          106},{300,106},{300,62},{286,62},{286,54}}, color={255,127,0}));
  connect(onOffCon.u, rectangularZoneTemplate.TSensor) annotation (Line(
        points={{-2,74},{-10,74},{-10,60},{20,60},{20,32},{11,32}}, color={
          0,0,127}));
end Sol6FloorHeatingOnOffThermostat;
