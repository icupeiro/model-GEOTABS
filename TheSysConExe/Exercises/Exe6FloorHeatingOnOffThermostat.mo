within TheSysConExe.Exercises;
model Exe6FloorHeatingOnOffThermostat
  "Building with floor heating as emission system and heat pump as production system"
  extends BaseClases.EnvFloPumHP;
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
In alignment with the green mission of <i>The Sysis Consultants</i>
you want to propose another alternative more environmentally friendly. 
You know that a heat pump will replace the in-place consumption 
of fossil fuel with cleaner energy coming from the electric grid. 
Additionally, the Geleitsbeek river of Uccle very nearby and can be 
used as the cold source of the heat pump. You are aware that the 
coefficient of performance (COP) of a heat pump, heavily depends on
the supply water temperature. Therefore, you decide to change 
your emission system of this new proposal from radiators to floor 
heating. The area of a floor heating emission system is substantially
increased when compared to the radiators, which allows to decrease
the supply water temperature. On the other hand, the floor heating
system is more challenging to control because of the larger thermal
inertia associated with the higher thermal mass. But you don't panic,
breath deeply, and proceed as in the previous exercises to define
your new proposal. 
</p>
<p>
<h4>Questions</h4>
<ol>
<li>
Can you think of other advantages of other advantages of 
providing thermal comfort using electric energy from the grid?
how can such a setup help in the overall efficiency of an 
smart-grid?
</li>
</ol>
</p>
</html>"));
end Exe6FloorHeatingOnOffThermostat;
