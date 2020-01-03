within TheSysConExe.Exercises;
model Exe3ThermostaticValves "Building control through thermostatic valves"
  extends BaseClases.envRadPumBoi;
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valNor(
    m_flow_nominal=radNor.m_flow_nominal,
    dpValve_nominal=20000,
    redeclare package Medium = MediumWater)
    "Thermostatic valve for north zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,30})));
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valSou(
    dpValve_nominal=20000,
    m_flow_nominal=radSou.m_flow_nominal,
    redeclare package Medium = MediumWater)
    "Thermostatic valve for south zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,30})));
  Modelica.Blocks.Sources.Constant const(k=60 + 273.15)
    annotation (Placement(transformation(extent={{220,40},{240,60}})));
equation
  connect(valNor.port_b, radNor.port_a)
    annotation (Line(points={{50,20},{50,0}}, color={0,127,255}));
  connect(valSou.port_b, radSou.port_a)
    annotation (Line(points={{90,20},{90,0}}, color={0,127,255}));
  connect(rectangularZoneTemplate.TSensor, valNor.T) annotation (Line(
        points={{11,32},{26,32},{26,30},{39.4,30}}, color={0,0,127}));
  connect(rectangularZoneTemplate1.TSensor, valSou.T) annotation (Line(
        points={{11,-28},{32,-28},{32,12},{79.4,12},{79.4,30}}, color={0,0,
          127}));
  connect(jun.port_3, valSou.port_a)
    annotation (Line(points={{90,50},{90,40}}, color={0,127,255}));
  connect(jun.port_2, valNor.port_a)
    annotation (Line(points={{80,60},{50,60},{50,40}}, color={0,127,255}));
  connect(const.y, boi.TSet) annotation (Line(points={{241,50},{256,50},{
          256,28},{222,28}}, color={0,0,127}));
end Exe3ThermostaticValves;
