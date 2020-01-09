within TheSysConExe.Exercises;
model Exe6FloorHeatingOnOffThermostat
  "Building with floor heating as emission system and heat pump as production system"
  extends BaseClases.envFloPumHP;
equation
  connect(jun.port_2, embNor.port_a) annotation (Line(points={{80,60},{50,
          60},{50,20},{34,20},{34,0},{40,0}}, color={0,127,255}));
  connect(jun.port_3, embSou.port_a) annotation (Line(points={{90,50},{90,
          20},{76,20},{76,0},{80,0}}, color={0,127,255}));
  connect(heaPum.port_b1, senTemSup.port_a) annotation (Line(points={{240,2},
          {238,2},{238,60},{168,60}}, color={0,127,255}));
  annotation (Documentation(info="<html>
<p>
Congratulations! You have already made a proposal for the thermal 
systems of the building of <i>BeautifulEnvelopes</i>. This proposal
consists of a gas boiler as production system and radiators as 
emission system. 
In alignment with the green mission of <i>The Sysis Consultants</i>,
you want to propose another alternative more environmentally friendly. 
You know that a heat pump will replace the local consumption 
of fossil fuel and substitute it with cleaner energy coming from the electric grid. 
Additionally, the Geleitsbeek river of Uccle is located very nearby 
and can be used as the cold source of the heat pump. You are aware 
that the coefficient of performance (COP) of a heat pump heavily 
depends on the supply water temperature. Therefore, you decide to change 
the emission system of this new proposal from radiators to floor 
heating. The area of a floor heating emission system is substantially
increased when compared to the radiators, which allows to decrease
the supply water temperature. On the other hand, the floor heating
system is more challenging to control because of the larger thermal
inertia associated with the higher thermal mass. But you don't panic,
breath deeply, and proceed as in the previous exercises to define
your new proposal. 
</p>
<p>
First of all, take some time to understand how the model has changed.
The radiator models have been changed by models of pipes embedded in 
the floor of the zones. This model is used for floor heating and 
for Termally Activated Building Systems (TABS). Also, if you open 
the floor tab of each zone you will realize that its material 
structure has been replaced by an insulated floor heating type with 
heat injection between a layer of 7cm of insulation and a layer of 
5cm screed. This type also includes 10cm of concrete. A graphical 
representation of this floor type and a radiant floor under construction
is shown in the figures below. 
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/floorHeating.png\" width=\"1000\" border=\"1\"/>
</p>
<p>
<i>Source left figure: </i>
<a href=\"https://www.quora.com/What-is-the-best-flooring-for-radiant-heat-systems\">
Citygas</a>
</p>
<p>
<i>Source right figure: </i>
<a href=\"http://www.spiderex.it/\">
Spiderex</a>
</p>
<p>
Start by implementing an on-off control logic similar to 
<a href=\"modelica://TheSysConExe.Exercises.Exe2RadiatorsOnOffThermostat\">
TheSysConExe.Exercises.Exe2OnOffThermostat</a>. 
This time, take into account that you should swtch on and off the 
compressor of the heat pump. The circulation pumps should always be on.
The pump of the primary
circuit will activate the water circulation through the emission 
system. The pump of the secondary circuit will activate the water circulation
from the Geleitsbeek river through the evaporator of the heat
pump. Finally, the heat pump compressor will activate the refrigerant 
thermodynamic circuit that will transfer heat from the cold to the hot source. 
The performance data used for the implemented heat pump are 
for a 21 kW heat pump, which is much more than we require for our system. 
Therefore, set the heat pump scaling factor to a value able to 
cope with the heat losses but such that do not oversizes the nominal 
power of the heat pump. For instance, if you use 0.1 as scaling factor, 
the model will rescale the heat pump behaviour to a thermal power of 10 %
from the original heat pump of 21 kW. You can open the heat pump model
and go to the information tab for more specification of how this model works. 
</p>
<p>
<h4>Questions</h4>
<ol>
<li>
According to the chosen scaling factor, what would be the nominal 
power of the heat pump required for this instalation? 
</li>
<p>
Note: watch out with large scaling factors. These will lead not only to higher
installation costs because of an oversized heat pump, but also to decrease the 
system performance. The latest may be caused by the temperature protection 
of the heat pump model that disables the heat pump when temperature exceeds a 
predefined threshold. 
</p>
<li>
Which are the values of the energy use of the heat pump compressor? 
What is the total discomfort in the north and south zones at the end of the simulation? 
Does them make sense? How do they compare with the previous exercises?
Implement your own energy meters to compare the electricity used by the 
compressor with the electricity used by the primary and secondary pumps. 
</li>
<li>
You have probably observed that the overall energy use has been 
considerably reduced when compared against the case of boiler + radiators. 
However, we are still able to balance the heat losses of the building
since comfort is achieved. If we consider a rough energy balance we 
inmediately appreciate that we are providing the building with 
(approximately) the same amount of thermal energy while using much
less primary energy than before. Where is the extra source of 
energy coming from?  
</li>
<li>
Can you think of other advantages of 
providing thermal comfort using electric energy from the grid?
how can this setup help in the overall efficiency of a 
smart-grid?
</li>
</ol>
</p>
</html>"),
    experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end Exe6FloorHeatingOnOffThermostat;
