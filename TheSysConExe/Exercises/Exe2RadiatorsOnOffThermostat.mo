within TheSysConExe.Exercises;
model Exe2RadiatorsOnOffThermostat
  "Building control by switching emission system on and off"
  extends BaseClases.envRadPumBoi;
  Modelica.Blocks.Sources.Constant const(k=60 + 273.15)
    "Supply temperature setpoint"
    annotation (Placement(transformation(extent={{220,40},{240,60}})));
equation
  connect(jun.port_3, radSou.port_a)
    annotation (Line(points={{90,50},{90,0}}, color={0,127,255}));
  connect(jun.port_2, radNor.port_a)
    annotation (Line(points={{80,60},{50,60},{50,0}}, color={0,127,255}));
  connect(const.y, boi.TSet) annotation (Line(points={{241,50},{256,50},{
          256,28},{222,28}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2419200, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=false,
      OutputFlatModelica=false),
    Documentation(info="<html>
<p>
You have extended the previous model with a very simple heating system 
to provide thermal comfort in both zones of the building. The heating 
system is composed of an emission system and a production system. 
The emission system has one radiator per zone 
(<code>radNor<\\code> and <code>radSou<\\code>) and one pump 
(<code>pum<\\code>) to circulate the heating fluid (<code>MediumWater<\\code>). 
The production system is an ideal boiler that allows to externally set 
the supply temperature of the water to a desired predefined setpoint. 
</p>
<p>
Notice that, if you simulate this model as such, you will obtain extremely high 
indoor temperatures. The reason is that the pump 
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
depending on the indoor temperature reading. If the indoor temperature 
lowers down the temperature setpoint minus a certain offset, then the
pump is switched on. If the indoor temperature surpases the temperature
setpoint plus a certain offset, then the pump is switched off. The figure
below shows an schematic of this controller and an abstraction of the 
expected output. 
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/feedbackControl.png\" width=\"1600\" border=\"1\"/>
</p>
It's important to note that, in this case, we are not controlling the 
production system (the boiler). Instead, we only control the circulation 
pump and assume that the boiler has its own control logic to switch on 
when required and provide the established constant supply temperature.
To enable the pump to read an external control input you may want 
to modify the <i>\"inputType\"</i> parameter of the pump in the General view and 
change it to <i>\"Use integer input to select state\"</i>.
</p>
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
</ol>

<p>
You can use the <code>setHea</code> of the <code>occ</code> block as 
heating temperature setpoint. You may want to add an offset to this 
temperature setpoint before using it as the reference of your on-off 
controller to avoid an excesive discomfort.  
</p>
<p>
Before start tunning your controller, you should
understand how these blocks work, what they actually do, and how
they can be used within the control logic. Once that is clear, drag and drop
the blocks from the Package Browser and connect them to build the controller. 
It must be pointed out that there are several ways to implement the same 
control logic. If you find other blocks that may lead to an equivalent result, 
you are very encouraged to try them out!
</p>

<h4>Questions</h4>
<ol>
<li>
In the previous exercise it was clear that there was thermal discomfort 
and no energy consumption since the thermal systems were missing. However,
from now on you will use the energy use and thermal discomfort as key performance indicators 
to compare between the proposed thermal systems and control logics.  
It is possible to quantify the thermal energy consumed as well as the 
total discomfort in each of the zones by integrating the instantaneous power
and the temperature deviations out of the comfort range. The former is 
usually expressed in units of kW*h, the latter is expressed in units
of K*h. This model already computes these quantities and the corresponding
unit changes, you can access them at <code>ene.y<\\occ.A>, 
<code>rectangularZoneTemplate.comfort.totDis<\\occ.A>, and 
<code>rectangularZoneTemplate1.comfort.totDis<\\occ.A>. 
Which are the values of the energy use of the boiler, and the total 
discomfort in the north and zouth zones at the end of the simulation? 
does them make sense? 
</li>
<li>
Is there a substantial thermal discomfort difference between both zones? 
Why does that happen? 
</li>
<li>
What happens if you change the zone where the thermostat is located? 
</li>
<li>
Play around with the supply temperature of the boiler by changing 
the <code>k</code> parameter of block <code>const</code>. Is it necessary 
to have such a high supply temperature setpoint or can it be lowered down? 
Is there a minimum supply temperature setpoint to cope with the building
envelope heating losses? In case yes, which one? 
</li>
<li>
Is there an added value on lowering down the supply temperature setpoint? 
Would it be interesting to vary the supply temperature setpoint? in case
yes, why and how would you vary it? 
</li>
</ol>

</html>"));
end Exe2RadiatorsOnOffThermostat;
