within TheSysConExe.Exercises;
model Exe1RadiatorsBuildingEnvelope
  "Building envelope model with two zones and office occupancy"
  extends IDEAS.Examples.Tutorial.Example5(rectangularZoneTemplate(
      n50=2,
      redeclare BaseClases.Comfort comfort(setCoo=occ.setCoo, setHea=occ.setHea),
      redeclare BaseClases.Occupancy occNum(k=occ.k),
      l=sqrt(occ.A),
      w=sqrt(occ.A),
      A_winA=0.5*l*h),
                    rectangularZoneTemplate1(
      n50=2,
      redeclare BaseClases.Comfort comfort(setCoo=occ.setCoo, setHea=occ.setHea),
      redeclare BaseClases.Occupancy occNum(k=occ.k),
      l=sqrt(occ.A),
      w=sqrt(occ.A),
      A_winC=0.5*l*h))
                    annotation (
    experiment(
      StartTime=10000000,
      StopTime=11000000,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));

  BaseClases.Occupancy occ(
    linearise=false,
    A=500,
    setHeaOcc=21 + 273.15,
    setHeaUno=21 + 273.15,
    setCooOcc=23 + 273.15,
    setCooUno=23 + 273.15,
    k=50)
    "Occupancy schedule and setpoints for each of the zones in the building"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

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
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{120,100}})),
    Documentation(info="<html>
<p>
This is the model of the building envelope that Carl developed from 
the construction data provided by <i>BeautifulEnvelopes</i>. At first
glance, it may seem simple, but it is an accurate representation of 
the thermal behaviour of the future building envelope. Take your time 
to get familiar with this building model, understand its components,
simulate it, and plot the results to ensure that everything makes sense. 
</p>
<p>
You can hover your mouse over the different components to see their class
name (in red) and their instance name (grey). An instance is just a particular 
class filled in with specific attributes. You can get further information 
of each class by right clicking the component and selecting  
<i>Open class in new tab</i>. 
<\\p>
<p>
The first component at the top-left of the model is a <code>SimInfoManager<\\code>.
This element reads typical yearly weather data of Uccle, where the building
is to be located. It reads the weather data from a TMY file, and transmits 
this information to other inner components of the model that could require
weather data. 
<\\p>
<p>
The next component is an instance of an <code>Occupancy<\\code> model used to 
designate the heating and cooling setpoints: <code>setHea<\\code> and 
<code>setCoo<\\code>, which are the lower and upper comfort bounds 
allowed in the building. This model allows to simultaneously
define these comfort constraints for both building zones, without having to
redefine these in each of them. The same applies for the occupancy schedules
(number of occupants per time of the day) and the zone areas. The building
presents a symmetric layout: north and south zone have the same
area and number of occupants. 
</p>
<p>
Finally, the north and south zones of the building are each modelled with
a <code>RectangularZoneTemplate<\\code> class of IDEAS. Notice that these
zones are connected through an internal wall, enabling heat exchange between 
them. The floor and ceiling of each zone are connected as well, which 
enforces these components of the zone to have the same properties. 
</p>
<p>
You can simulate the model using the simulate button 
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/simulate.png\" width=\"40\" border=\"1\"/>
at the simulation pane located in the top-right of the Dymola window. 
Before simulating, make sure that the start simulation time is set to 0 
and the stop simulatino time to 28 days. You can check that in the 
simulation setup   
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/simSetup.png\" width=\"40\" border=\"1\"/>.
To see the simulation results, access the Simulation view at the 
bottom-right of the Dymola window. Then, select a bunch of variables that
you'd like to plot from the variable browser. For instance, the graph 
below has been obtained by choosing the comfort setpoints, the indoor
temperatures of both zones and the outdoor temperature. 
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://TheSysConExe/Resources/Images/Exe1RadiatorsBuildingEnvelope.png\" width=\"1600\" border=\"1\"/>
</p>
<p>
Make sure you obtain a similar graph when plotting the same variables and
then plot any variable you need to answer the following questions. 
</p>
<h4>Questions</h4>
<ol>
<li>
Was it expected to have such low temperatures within the building zones?
Why does that happen?
</li>
<li>
What is the influence of increasing or decreasing the zone area? why does that happen? 
You can change the area of the zones at <code>occ.A<\\occ.A>.
</li>
<li>
What is the influence of increasing or decreasing the number of occupants per zone? 
why does that happen? You can change the number of occupants per zone during 
the occupied period at <code>occ.nOcc<\\occ.A>. Notice that the occupancy 
schedule is not constant. If you'd like to see the number of occupants 
per zone plot <code>occ.nOcc<\\occ.A>
</li>
<p>
Now you're ready to start adding thermal systems to the building.
Before continuing, change back the parameters of the area and the number of 
occupants to their originall value.  
<\\p>


</html>"));

end Exe1RadiatorsBuildingEnvelope;
