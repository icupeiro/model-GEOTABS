within TheSysConExe.Exercises;
model Exe5RadiatorsHeatingCurveImplementation
  "Implementation of the heating curve derived in the previous exercise"
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
  Modelica.Blocks.Tables.CombiTable1D heaCurTab(              columns={2})
    "Heating curve table"
    annotation (Placement(transformation(extent={{252,30},{232,50}})));
equation
  connect(valNor.port_b, radNor.port_a)
    annotation (Line(points={{50,20},{50,0}}, color={0,127,255}));
  connect(valSou.port_b, radSou.port_a)
    annotation (Line(points={{90,20},{90,0}}, color={0,127,255}));
  connect(zonNor.TSensor, valNor.T) annotation (Line(points={{11,32},{26,32},{
          26,30},{39.4,30}}, color={0,0,127}));
  connect(jun.port_3,valSou. port_a)
    annotation (Line(points={{90,50},{90,40}}, color={0,127,255}));
  connect(jun.port_2,valNor. port_a)
    annotation (Line(points={{80,60},{50,60},{50,40}}, color={0,127,255}));
  connect(boi.TSet, heaCurTab.y[1]) annotation (Line(points={{222,28},{228,
          28},{228,40},{231,40}},
                             color={0,0,127}));
  connect(zonSou.TSensor, valSou.T) annotation (Line(points={{11,-28},{32,-28},
          {32,8},{72,8},{72,30},{79.4,30}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Now it is about time for you to see if there is an 
added value on implementing the heating curve derived in 
the previous exercise to obtain some good operational 
savings for your clients. 
The <code>heaCurTab</code> is the heating curve table 
where we are going to define the heating curve derived in 
the previous exercise. Take some time to understand how 
this block works. Then, fill in the <code>table</code>
matrix of this block in the format 
[x<sub>A</sub>,y<sub>A</sub>; x<sub>B</sub>,y<sub>B</sub>].
Connect the outdoor temperature to the input of the table,
preferrably filtered with the same low-pass filter used 
before. Finally, add up the controller developed in exercises
<a href=\"modelica://TheSysConExe.Exercises.Exe2RadiatorsOnOffThermostat\">
TheSysConExe.Exercises.Exe2OnOffThermostat</a> and
<a href=\"modelica://TheSysConExe.Exercises.Exe3RadiatorsThermostaticValves\">
TheSysConExe.Exercises.Exe3ThermostaticValves</a>, 
to switch on and off the pump only when necessary, and to 
provide smooth indoor air temperature variations with the 
thermostatic valves. 
</p>
<h4>Questions</h4>
<ol>
<li>
Which are the values of the energy use of the boiler, and the total 
discomfort in the north and south zones at the end of the simulation? 
does them make sense? How do they compare with the previous exercises?

<li>
You go through the catalogues of the providers that are partnered with
<i>The Sysis Consultants</i> and obtain the following data (all in 
nominal values): 

<table style=\"width:100%\" border: \"1px solid black\">
  <tr>
    <th>Description</th>
    <th>Price (&#8364;)</th> 
  </tr>
  <tr>
    <td>Pump (Capacity=2.6 l/min) </td>
    <td>83</td>
  </tr>
  <tr>
    <td>Pump (Capacity=4.4 l/min) </td>
    <td>104</td>
  </tr>
  <tr>
    <td>Pump (Capacity=30 l/min) </td>
    <td>370</td>
  </tr>
  <tr>
    <td>Pump (Capacity=140 l/min) </td>
    <td>561</td>
  </tr>
  <tr>
    <td>Thermostatic radiator valve </td>
    <td>18</td>
  </tr>
  <tr>
    <td>Radiator (1 kW)</td>
    <td> 48</td>
  </tr>
  <tr>
    <td>Radiator (2 kW)</td>
    <td> 155</td>
  </tr>
  <tr>
    <td>Radiator (10 kW)</td>
    <td> 470</td>
  </tr>
  <tr>
    <td>Radiator (15 kW)</td>
    <td> 590</td>
  </tr>
  <tr>
    <td>Boiler (7 kW) without outdoor reset control</td>
    <td> 206</td>
  </tr>
  <tr>
    <td>Boiler (7 kW) with outdoor reset control</td>
    <td> 214</td>
  </tr>
  <tr>
    <td>Boiler (16 kW) without outdoor reset control</td>
    <td> 307</td>
  </tr>
  <tr>
    <td>Boiler (16 kW) with outdoor reset control</td>
    <td> 345</td>
  </tr>
  <tr>
    <td>Boiler (20 kW) without outdoor reset control</td>
    <td> 453</td>
  </tr>
  <tr>
    <td>Boiler (20 kW) with outdoor reset control</td>
    <td> 481</td>
  </tr>
  <tr>
    <td>Boiler (30 kW) without outdoor reset control</td>
    <td> 602</td>
  </tr>
  <tr>
    <td>Boiler (30 kW) with outdoor reset control</td>
    <td> 634</td>
  </tr>

</table>

Which elements would you advise to buy for the installation? What is the estimated total cost of the installation?
</li>
</ol>
</p>
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
end Exe5RadiatorsHeatingCurveImplementation;
