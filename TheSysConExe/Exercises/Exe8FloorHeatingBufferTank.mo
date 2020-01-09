within TheSysConExe.Exercises;
model Exe8FloorHeatingBufferTank
  "Exercise with floor heating, heat pump, and a buffer tank to decouple emission circuit from production circuit"
  extends BaseClases.envFloPumHP;
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valNor(
    m_flow_nominal=embNor.m_flow_nominal,
    dpValve_nominal=20000,
    redeclare package Medium = MediumWater)
    "Thermostatic valve for north zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,30})));
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valSou(
    dpValve_nominal=20000,
    m_flow_nominal=embSou.m_flow_nominal,
    redeclare package Medium = MediumWater)
    "Thermostatic valve for south zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,30})));
  IDEAS.Fluid.Storage.Stratified
                           tan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=pum.m_flow_nominal,
    VTan=0.1,
    hTan=0.5,
    dIns=0.1) "Buffer tank for avoiding excessive heat pump on/off switches"
    annotation (Placement(transformation(extent={{212,50},{192,70}})));
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
  connect(tan.port_b, senTemSup.port_a)
    annotation (Line(points={{192,60},{168,60}}, color={0,127,255}));
  connect(tan.port_a, heaPum.port_b1) annotation (Line(points={{212,60},{
          240,60},{240,2}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{340,140}})),
      Icon(coordinateSystem(extent={{-100,-100},{340,140}})),
    Documentation(info="<html>
<p>
Attempting to solve the problem encountered in the previous exercise, 
you decide to include a buffer tank that decouples the HP functioning
from the emission circuit. 
</p>
<h4>Questions</h4>
<ol>
<li>
How does exactly the buffer tank helps to solve the problem of the 
previous exercise? 
</li>
<li>
What is the energy consumed by the compressor of the heat pump? and
the total discomfort in each of the zones?
</li>
<li>
You come back to the catalogues of the providers that are partnered with
<i>The Sysis Consultants</i> to check prices and you find out the cost of 
installing floor heating is approximately of 30 &#8364;/m2. For heat pumps, 
your preferred supplier is 
<a href=\"https://www.pzpheating.com/userfiles/files/Price-list_EN_01_04_2014.pdf\">
PZP HEATING a.s.</a> 
Go into this catalogue to propose a particular model of a heat pump and
buffer tank. What is the estimated total price of this
installation?
</li>
<li>
What is the extra cost in the initial investment of implementing 
this thermal installation when compared to installation of 
<a href=\"modelica://TheSysConExe.Exercises.Exe5RadiatorsHeatingCurveImplementation\">
TheSysConExe.Exercises.Exe5RadiatorsHeatingCurveImplementation</a>?  
</li>
<li>
If the gas price is 0.07 &#8364;/(kW*h) and the electricity price 0.2 &#8364;/(kW*h),
how many winter months like the one simulated are required to pay back
this extra investment cost? 
Is it interesting from the economical point of view?
Is it interesting from the environmental point of view? 
</li>
</ol>
</html>"));
end Exe8FloorHeatingBufferTank;
