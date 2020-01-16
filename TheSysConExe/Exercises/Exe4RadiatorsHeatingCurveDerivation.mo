within TheSysConExe.Exercises;
model Exe4RadiatorsHeatingCurveDerivation "Heating curve derivation"
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
needed to cope with the building envelope heat losses 
while maximizing the energy efficiency of the production and 
emission systems. 
</p>
<p>
In a controller with a heating curve, the supply (or return) 
temperature is determined depending on the ambient temperature. 
It is important to note that both, supply or return temperatures
can be used as far as one is consistent in the implementation. 
The heating curve characteristic (slope and offset) can be 
determined analytically if the geometrical data and material 
properties of the building are available. For instance, in 
steady state we obtain:
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/HeatingCurveEquation.png\" width=\"600\" border=\"1\"/>
</p>
<p>
This is a static model of the building that defines what the 
supply temperature must be T<sub>w</sub>, for a desired zone temperature
T<sub>zone</sub>, and a given ambient temperature T<sub>amb</sub>. 
As you can see, the slope of the heating curve depends on the ratio 
between the heat transfer coefficient from the zone to the surroundings 
and the heat transfer coefficient of the radiators (i.e. from the 
supply temperature to the zone).  
The offset of the heating curve is determined by &#916;T<sub>amb</sub>.
This offset indicates that the net heat demand differs from the 
transmission losses, which happens because of the internal and solar 
heat gains. It is worth noting that we are making an important 
assumption here by considering this offset a constant, whereas
the heat gains are continuously varying. 
</p>
<p>
Tunning these parameters from construction data is 
usually quite complex and, most of the times, the curve is derived 
by trial and error. Luckily, we already have available a model of 
the building envelope that can be used to derive such curve.  
</p>
<p>
The figure below shows an schematic of how a controller with
a heating curve works.  
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/HeatingCurveControl.png\" width=\"1800\" border=\"1\"/>
</p>
<p>
Basically, we want to infer what is the supply temperature 
setpoint that we should use for a certain outdoor temperature. 
As we count with an ideal boiler, we can directly identify 
the heating curve by developing a controller that modifies 
the supply temperature from indoor temperature readings. Then,
we can plot the supplied temperature as a function of the 
outdoor temperature to directly obtain the heating curve. 
A PID controller can be used for such task. 
Once the heating curve
is obtained, we will implement it in the following exercise.   
</p>
<p>
Therefore, the main task of this exercise is to set up the 
PID controller of the ideal boiler supply temperature to 
perfectly cope with the heat losses of the building envelope. 
Tunning a PID controller is not an easy task and may be 
interesting to understand how it works before starting hands on. 
The following figure shows how a PID controller works:
</p>
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/pidControl.png\" width=\"1000\" border=\"1\"/>
</p>
<p>
<i>Source: </i>
<a href=\"https://en.wikipedia.org/wiki/PID_controller\">
Wikipedia 2019</a>
</p>
<p>
From the figure, we derive that:
</p>
<p align=\"center\" style=\"font-style:italic;\">
u(t) = K<sub>p</sub> &nbsp; ( e(t) + 1 &frasl; T<sub>i</sub> &nbsp; &int; e(t') dt' + T<sub>d</sub> de(t')&frasl;dt' ),
</p>
<p>
where
<i>u(t)</i> is the control signal,
<i>e(t) = r(t) - y(t) is the control error,
with r(t) being the set point and y(t) being
the measured quantity,
<i>K<sub>p</sub></i> is the gain,
<i>T<sub>i</sub></i> is the time constant of the integral term and
<i>T<sub>d</sub></i> is the time constant of the derivative term.
</p>
<p>
Note that the units of <i>K<sub>p</sub></i> are the inverse of the units of the control error,
while the units of <i>T<sub>i</sub></i> and <i>T<sub>d</sub></i> are seconds.
</p>
<p>
You can follow the instructions in the information window of
<a href=\"modelica://Modelica.Blocks.Continuous.LimPID\">
Modelica.Blocks.Continuous.LimPID</a>
as an strategy to properly set up the PID parameters. A PI controller
may be enough for the intended application. Also, set the limits 
of the controller output to realistic values, for instance 
20 and 60 &#176;C.
</p>

<p>
Before plotting the supply temperature as a function of the
ambient temperature, add a low pass filter (
<a href=\"modelica://Modelica.Blocks.Continuous.Filter\">
Modelica.Blocks.Continuous.Filter</a> )
to these variables 
with a cut-off frequency of around 3 hours. We are not interested
in lower frequencies that will only hamper the identification of
the heating curve, whereas cutting off higher frequencies can 
lead to loss of information.
You'll need to use the 
<a href=\"modelica://IDEAS.BoundaryConditions.WeatherData.Bus\">
IDEAS.BoundaryConditions.WeatherData.Bus</a> 
class to interface the ambient temperature of the 
<code>SimInfoManager</code> with the low-pass filter. 

Finally, plot the filtered variables one against the other. You
can select an independent variable other than time by looking 
that variable in the <i>Variable Browser</i>, then right click, 
and choose <i>Independent Variable</i>.
</p>

<p>
<h4>Questions</h4>
<ol>
<li>
When you plot the filtered supply temperature as a function of
the filtered surrounding temperature you'll probably not get a 
straight line but a cloud of points. However, this cloud 
already trends to decrease the supply temperature when the 
outside temperature increases. Try to derive the heating curve 
by drawing an straight line from the cloud of points and writing 
down two points of the line: A(x<sub>A</sub>,y<sub>A</sub>) and 
B(x<sub>B</sub>,y<sub>B</sub>). You are 
probably interested in drawing your line slightly above the cloud
to follow a conservative approach: you want to decrease the supply
temperature when the outdoor temperature decreases, but always 
ensuring that the supply temperature will suffice to cover the 
heat demand. 
</li>
<li>
Which are the values of the energy use of the boiler, and the total 
discomfort in the north and south zones at the end of the simulation? 
</li>
</ol>

</html>"),
    experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end Exe4RadiatorsHeatingCurveDerivation;
