within TheSysConExe.Exercises;
model Exe7FloorHeatingThermostaticValves
  "Building with floor heating, thermostatic valves, and heat pump"
  extends BaseClases.envFloPumHP;
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valNor(
    m_flow_nominal=embNor.m_flow_nominal,
    dpValve_nominal=pumEmi.dp_nominal*0.9,
    redeclare package Medium = MediumWater,
    use_inputFilter=false,
    from_dp=true)
    "Thermostatic valve for north zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,30})));
  IDEAS.Fluid.Actuators.Valves.TwoWayTRV valSou(
    dpValve_nominal=pumEmi.dp_nominal*0.9,
    m_flow_nominal=embSou.m_flow_nominal,
    redeclare package Medium = MediumWater,
    use_inputFilter=false,
    from_dp=true)
    "Thermostatic valve for south zone" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,30})));
equation
  connect(zonNor.TSensor, valNor.T) annotation (Line(points={{11,32},{26,32},{
          26,30},{39.4,30}}, color={0,0,127}));
  connect(jun.port_3, valSou.port_a)
    annotation (Line(points={{90,50},{90,40}}, color={0,127,255}));
  connect(zonSou.TSensor, valSou.T) annotation (Line(points={{11,-28},{30,-28},
          {30,14},{72,14},{72,30},{79.4,30}}, color={0,0,127}));
  connect(valSou.port_b, embSou.port_a) annotation (Line(points={{90,20},{
          90,14},{76,14},{76,0},{80,0}}, color={0,127,255}));
  connect(valNor.port_a, jun.port_2)
    annotation (Line(points={{50,40},{50,60},{80,60}}, color={0,127,255}));
  connect(valNor.port_b, embNor.port_a) annotation (Line(points={{50,20},{
          50,16},{34,16},{34,0},{40,0}}, color={0,127,255}));
  connect(heaPum.port_b1,senTemSup.port_a)  annotation (Line(points={{240,2},
          {240,60},{168,60},{168,60}}, color={0,127,255}));
  connect(senTemRet.port_a, heaPum.port_a1) annotation (Line(points={{140,-50},
          {240,-50},{240,-18}}, color={0,127,255}));
  annotation (Documentation(info="<html>
<p>
This exercise is equivalent to 
<a href=\"modelica://TheSysConExe.Exercises.Exe3RadiatorsThermostaticValves\">
TheSysConExe.Exercises.Exe3RadiatorsThermostaticValves</a> 
in the sense that valves are introduced to control the water flow
through the emission system in each zone, seeking a better temperature
control. Normally, a motorized valve would be used to control the 
water flow. However, we still model the valve in this exercise as 
a TRV since the working principle is the same and the resulting model
is more efficient. 
</p>
<p>
First, add the on-off control already implemented in the previous 
exercise. Then, tune the parameters in each valve to properly follow
the heating setopoint and simulate to answer the following questions. 
</p>

<h4>Questions</h4>
<ol>
<li>
How the zone temperature profiles compare with the previous exercise? 
</li>
<li>
In fact, we have probably achieved an smoother temperature control. 
We may even expect it to be more efficient, however, we see that both, the energy
use and thermal discomfort have considerably increased. What is the reason
for that?
<p>
Hint: plot the following variables to help you elaborate an answer:
The heat pump condenser temperature <code>heaPum.con.T</code>, the heat pump
heat flow rate <code>heaPum.QCon_flow</code>, the floor heating heat 
flow rate in the north zone <code>embNor.QTot</code>, the floor heating heat
flow rate in the south zone <code>embSou.QTot</code>, and the
heat pump COP <code>heaPum.com.COP</code>.
</p>
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
      OutputCPUtime=true,
      OutputFlatModelica=false));
end Exe7FloorHeatingThermostaticValves;
