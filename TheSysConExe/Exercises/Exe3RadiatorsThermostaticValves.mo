within TheSysConExe.Exercises;
model Exe3RadiatorsThermostaticValves
  "Building control through thermostatic valves"
  extends BaseClases.envRadPumBoi;
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valNor(
    m_flow_nominal=radNor.m_flow_nominal,
    dpValve_nominal=pum.dp_nominal*0.9,
    redeclare package Medium = MediumWater,
    use_inputFilter=false,
    from_dp=true)
    "Thermostatic valve for north zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,30})));
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valSou(
    dpValve_nominal=pum.dp_nominal*0.9,
    m_flow_nominal=radSou.m_flow_nominal,
    redeclare package Medium = MediumWater,
    use_inputFilter=false,
    from_dp=true)
    "Thermostatic valve for south zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,30})));
  Modelica.Blocks.Sources.Constant const(k=60 + 273.15)
    "Supply temperature setpoint"
    annotation (Placement(transformation(extent={{220,40},{240,60}})));
equation
  connect(valNor.port_b, radNor.port_a)
    annotation (Line(points={{50,20},{50,0}}, color={0,127,255}));
  connect(valSou.port_b, radSou.port_a)
    annotation (Line(points={{90,20},{90,0}}, color={0,127,255}));
  connect(zonNor.TSensor, valNor.T) annotation (Line(points={{11,32},{26,32},{
          26,30},{39.4,30}}, color={0,0,127}));
  connect(jun.port_3, valSou.port_a)
    annotation (Line(points={{90,50},{90,40}}, color={0,127,255}));
  connect(jun.port_2, valNor.port_a)
    annotation (Line(points={{80,60},{50,60},{50,40}}, color={0,127,255}));
  connect(const.y, boi.TSet) annotation (Line(points={{241,50},{256,50},{
          256,28},{222,28}}, color={0,0,127}));
  connect(zonSou.TSensor, valSou.T) annotation (Line(points={{11,-28},{32,-28},
          {32,8},{72,8},{72,30},{79.4,30}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
As you have probably realised from the previous exercise, the thermal 
behaviour of the on-off control logic was quite reactive, leading to 
sudden temperature changes within the building zones. This can be avoided
by using thermostatic valves that regulate the mass flow rate through each 
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
The following figure shows the equivalence between a real thermostatic 
valve and a thermostatic radiator valve in the IDEAS library. 
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/TRV.png\" width=\"1000\" border=\"1\"/>
</p>
<p>
You may want to open the IDEAS model of the TRV into a new tab to 
examine how it works. Look into the <code>yExp</code> block that 
defines the valve opening characteristic and set the parameters
<code>TSet</code> and <code>P</code> of each valve accordingly. 
You can perform several simulations and use trial and error to 
improve your results. 
</p>
<p>
It may also be interesting to include the on-off control logic from 
the previous exercise to switch on the distribution pump only when 
necessary. In Dymola you can simply <code>Ctrl+C</code>
and <code>Ctrl+P</code> blocks and connections at the same time. 
If you do so, recall to change the input type of the pump as well. 
Finally, you can lower down the boiler supply temperature as in the 
previous exercise to lower down energy usage as much as possible.   
</p>
<h4>Questions</h4>
<ol>
<li>
Once you have properly tunned the parameters in each valve. 
Which are the values of the energy use of the boiler, and the total 
discomfort in the north and south zones at the end of the simulation? 
does them make sense? How do they compare with the previous exercise?
</li>
<li>
How do the zone temperature profiles compare with the previous exercise? 
</li>
</ol>
</html>"),
    experiment(StopTime=2419200, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end Exe3RadiatorsThermostaticValves;
