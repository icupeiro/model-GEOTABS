within TheSysConExe.Solutions;
model Sol7FloorHeatingThermostaticValves
  "Solution of exercise with floor heating, thermostatic valves, and heat pump"
  extends Exercises.Exe7FloorHeatingThermostaticValves(
    valNor(P=0.5),
    valSou(P=0.5),
    heaPum(scaling_factor=0.05));
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valNor(
    m_flow_nominal=embNor.m_flow_nominal,
    dpValve_nominal=20000,
    redeclare package Medium = MediumWater,
    P=0.5)
    "Thermostatic valve for north zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,30})));
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valSou(
    dpValve_nominal=20000,
    m_flow_nominal=embSou.m_flow_nominal,
    redeclare package Medium = MediumWater,
    P=0.5)
    "Thermostatic valve for south zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,30})));
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
  connect(rectangularZoneTemplate.TSensor,valNor. T) annotation (Line(
        points={{11,32},{26,32},{26,30},{39.4,30}}, color={0,0,127}));
  connect(jun.port_3, valSou.port_a)
    annotation (Line(points={{90,50},{90,40}}, color={0,127,255}));
  connect(rectangularZoneTemplate1.TSensor, valSou.T) annotation (Line(
        points={{11,-28},{30,-28},{30,14},{72,14},{72,30},{79.4,30}}, color=
         {0,0,127}));
  connect(valSou.port_b, embSou.port_a) annotation (Line(points={{90,20},{
          90,14},{76,14},{76,0},{80,0}}, color={0,127,255}));
  connect(valNor.port_a, jun.port_2)
    annotation (Line(points={{50,40},{50,60},{80,60}}, color={0,127,255}));
  connect(valNor.port_b, embNor.port_a) annotation (Line(points={{50,20},{
          50,16},{34,16},{34,0},{40,0}}, color={0,127,255}));
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
  connect(onOffCon.u, rectangularZoneTemplate.TSensor) annotation (Line(
        points={{-2,74},{-10,74},{-10,60},{20,60},{20,32},{11,32}}, color={
          0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{340,120}})));
end Sol7FloorHeatingThermostaticValves;
