within TheSysConExe.Exercises;
model Exe2OnOffThermostat
  "Building control by switching emission system on and off"
  extends BaseClases.envRadPumBoi;
  Modelica.Blocks.Sources.Constant const(k=60 + 273.15)
    annotation (Placement(transformation(extent={{220,40},{240,60}})));
equation
  connect(jun.port_3, radSou.port_a)
    annotation (Line(points={{90,50},{90,0}}, color={0,127,255}));
  connect(jun.port_2, radNor.port_a)
    annotation (Line(points={{80,60},{50,60},{50,0}}, color={0,127,255}));
  connect(const.y, boi.TSet) annotation (Line(points={{241,50},{256,50},{
          256,28},{222,28}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false),
    Documentation(info="<html>
<p>
You have extended the previous model with a very simple heating system 
to provide thermal comfort in both zones of the building. This first
proposal is composed of an emission system that has one radiator per zone 
(<code>radNor<\\code> and <code>radSou<\\code>) and one pump 
(<code>pum<\\code>) to circulate the heating fluid (<code>MediumWater<\\code>). 
The production system is an ideal boiler that allows to externally set 
the supply temperature of the water to a desired predefined setpoint. 
</p>
<p>
Notice that, if you simulate this model, you will obtain extremely high 
indoor temperatures. The reason is that the pump of the emission system 
is always working and thus the emission system is continuously 
circulating water at the established boiler supply
temperature. As a result, we obtain very large heating discomfort while 
consuming a lot of energy. The control logic of the system is missing. 
</p>
<p>
A typical control logic is an on-off controller with hysteresis that 
switches on and off the circulation pump of the emission system. A 
thermostat senses the indoor temperature in one of the zones and 
compares against a predefined indoor temperature setpoint. The controller
reacts to the sensed value by switching on and off the circulation pump
depending on the indoor temperature value. If the indoor temperature 
lowers down the temperature setpoint minus a certain offset, then the
pump is switched on. If the indoor temperature surpases the temperature
setpoint plus a certain offset, then the pump is switched off. An 
schematic of this controller is represented in the following figure. 
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/feedbackControl.png\" width=\"1000\" border=\"1\"/>
</p>
It's important to note that, in this case, we are not controlling the 
production system (the boiler). Instead, we only control the circulation 
pump and fix a constant supply temperature for the production system.
To enable the circulation pump to read an external control input you may
modify the <i>inputType</i> parameter of the pump in the General view and 
change it to <i>Use integer input to select state</i>.

<p>
You can implement the described control logic by using the following 
blocks:
</p>
<ol>
<li>
<code>Modelica.Blocks.Logical.OnOffController</code>
</li>
<li>
<code>Modelica.Blocks.Math.BooleanToInteger</code>
</li>
<li>
<code>Modelica.Blocks.Math.Add</code>
</li>
<li>
<code>Modelica.Blocks.Sources.Constant</code>
</li>

<p>
You can use the <code>setHea</code> of the <code>occ</code> block as 
heating temperature setpoint. You may want to add an offset to this 
temperature setpoint before using it as the reference of your on-off 
controller to avoid an excesive discomfort.  
<p>
</p>
Before start dragging and dropping these blocks into your model start 
by understanding how these blocks work, what they actually do, and how
they can be used within the control logic. Once that is clear, instantiate
the blocks and connect them to build the controller. It must be pointed
out that there are several ways to implement the same control logic. If 
you find other blocks that may lead to an equivalent result you are very
encouraged to try them out!
</p>

<h4>Questions</h4>
<ol>
<li>
In the previous exercise it was clear that there was thermal discomfort 
and no energy consumption since the thermal systems were missing. However,
from now on you will use these two variables as key performance indicators 
to compare between the thermal systems and control logics proposed.  
It is possible to quantify the thermal energy consumed as well as the 
total discomfort in the building by integrating the instantaneous power
and the temperature deviations out of the comfort range. The former is 
usually expressed in units of kW*h, the latter is expressed in units
of K*h. This model already computes these quantities and the corresponding
unit changes, you can access them at <code>ene.y<\\occ.A> and 
<code>rectangularZoneTemplate.comfort.totDis<\\occ.A>, respectively. Which are 
these values at the end of the simulation? does them make sense? 
</li>
</html>"));
end Exe2OnOffThermostat;
