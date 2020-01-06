within TheSysConExe.Exercises;
model Exe4HeatingCurveDerivation "Derivation of the building heating curve"
  extends BaseClases.envRadPumBoi;
  Modelica.Blocks.Continuous.LimPID conPID
    "PID controller for the supply temperature from ideal boiler"
    annotation (Placement(transformation(extent={{200,-82},{220,-62}})));
equation
  connect(jun.port_3, radSou.port_a)
    annotation (Line(points={{90,50},{90,0}}, color={0,127,255}));
  connect(jun.port_2, radNor.port_a)
    annotation (Line(points={{80,60},{50,60},{50,0}}, color={0,127,255}));
  connect(occ.setHea, conPID.u_s) annotation (Line(points={{-58,44},{-46,44},
          {-46,-72},{198,-72}}, color={0,0,127}));
  connect(conPID.y, boi.TSet) annotation (Line(points={{221,-72},{240,-72},
          {240,28},{222,28}}, color={0,0,127}));
  connect(rectangularZoneTemplate.TSensor, conPID.u_m) annotation (Line(
        points={{11,32},{20,32},{20,46},{-20,46},{-20,-94},{210,-94},{210,
          -84}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
From the previous exercises we have concluded that decreasing
the supply temperature setpoint of the production system is 
interesting to increase the efficiency. 
So far, a fixed temeprature setpoint has been used. 
In reality, it is common to use a heating curve to modify 
the supply temperature setpoint depending on the outdoor 
temperature. This allows to use the minimum supply temperature
needed to cope with the building envelope heating losses 
while maximizing the energy efficiency of the production and 
emission systems. 
</p>
<p>
In a controller with a heating curve the supply (or return) 
temperature is determined depending on the ambient temperature. 
It is important to note that both, supply or return temperatures
can be used as far as one is consistent in the implementation. 
The heating curve characteristic can be determined analytically 
if the material properties of the building are available. However,
this approach is usually quite complex and, most 
of the times, the curve is derived by trial and error. Luckily,
we already have available a model of the building envelope that
we can use to derive such curve.  
</p>
<p>
Basically, we want to infer what is the supply temperature 
setpoint that we should use for a certain outdoor temperature. 
As we count with an ideal boiler, we can directly identify 
the heating curve by developing a controller that modifies 
the supply temperature from indoor temperature readings. Then,
we can plot the supplied temperature as a function of the 
outdoor temperature to directly obtain the heating curve. 
A PID controller can be used for such task. Take into account
that such control approach is not commonly used in practice, 
and is only implemented here as an approach to eventually 
obtain a heating curve of this building.  
</p>
<p>
The figure below shows an schematic of how a controller with
a heating curve works.  
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/HeatingCurveControl.png\" width=\"1800\" border=\"1\"/>
</p>

</html>"));
end Exe4HeatingCurveDerivation;
