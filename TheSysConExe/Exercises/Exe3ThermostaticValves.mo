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
  annotation (Documentation(info="<html>
<p>
As you have probably realised from the previous exercise, the thermal 
behaviour of the on-off control logic was quite reactive, leading to 
sudden temperature changes within the building zones. This can be avoided
by using thermostatic that regulate the mass flow rate through each 
zone radiator.
A thermostatic radiator valve (TRV) contains a plug, typically made of
wax, which expands or contracts with the surrounding temperature. This
plug is connected to a pin which in turn is connected to a valve. The 
valve gradually closes as the temperature of the surrounding area increases
(P-control), limiting the amount of hot water entering the radiator. This
allows a maximum temperature to be set for each room. The IDEAS library
already counts with 
<a href=\"modelica://IDEAS.Fluid.Actuators.Valves.TwoWayTRV\">
a thermostatic radiator valve model</a>
that has been implemented for each of the zones of the building. 
The following figure shows the equivalence between how a thermostatic 
valve looks in reality and how it looks in the IDEAS library. 
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/TRV.png\" width=\"1000\" border=\"1\"/>
</p>
<p>
You may want to open the IDEAS model of the TRV into a new tab to 
examine how it works. Look into the <code>yExp</code> block that 
defines the characteristic of the valve opening and set the parameters
<code>TSet</code> and <code>P</code> of each valve accordingly. 
You can perform several simulations and use trial and error to 
improve your results. 
</p>
<p>
It may also be interesting to include the on-off control logic from 
the previous exercise to switch on the distribution pump only when 
necessary. Notice that in Dymola you can simply <code>Ctrl+C</code>
and <code>Ctrl+P</code> blocks and connections at the same time. 
Finally, you can lower down the boiler supply temperature to   
</p>
</html>"));
end Exe3ThermostaticValves;
