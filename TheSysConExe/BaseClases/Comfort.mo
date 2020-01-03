within TheSysConExe.BaseClases;
model Comfort
  "Computes the discomfort given comfort setpoints and zone temperature"
  extends IDEAS.Buildings.Components.Comfort.BaseClasses.PartialComfort;

  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{48,50},{68,70}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=1/3600)
    "Returns the upper discomfort in K-h"
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Modelica.Blocks.Math.MultiSum cooDif(k={1,-1}, nu=2)
    "Difference from cooling setpoint"
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
    annotation (Placement(transformation(extent={{16,50},{36,70}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{10,18},{30,38}})));
  Modelica.Blocks.Interfaces.RealOutput uppDis "Upper discomfort"
    annotation (Placement(transformation(extent={{140,48},{164,72}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{48,-50},{68,-30}})));
  Modelica.Blocks.Continuous.Integrator integrator1(k=1/3600)
    "Returns the lower discomfort in K-h"
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  Modelica.Blocks.Math.MultiSum heaDif(k={-1,1}, nu=2)
    "Difference from heating setpoint"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=0)
    annotation (Placement(transformation(extent={{16,-50},{36,-30}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{8,-80},{28,-60}})));
  Modelica.Blocks.Interfaces.RealOutput lowDis "Lower discomfort"
    annotation (Placement(transformation(extent={{140,-52},{164,-28}})));
  Modelica.Blocks.Math.MultiSum sumDis(k={1,1}, nu=2)
    "Sum of lower and upper discomfort"
    annotation (Placement(transformation(extent={{110,0},{130,20}})));
  Modelica.Blocks.Interfaces.RealOutput totDis "Total discomfort"
    annotation (Placement(transformation(extent={{140,-2},{164,22}})));
  Modelica.Blocks.Interfaces.RealInput setCoo(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Cooling setpoint"
    annotation (Placement(transformation(extent={{-120,-30},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput setHea(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Heating setpoint"
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
equation

  connect(cooDif.y, greaterThreshold.u)
    annotation (Line(points={{1.7,60},{14,60}},    color={0,0,127}));
  connect(switch.u2, greaterThreshold.y)
    annotation (Line(points={{46,60},{37,60}},color={255,0,255}));
  connect(integrator.u, switch.y)
    annotation (Line(points={{78,60},{69,60}}, color={0,0,127}));
  connect(integrator.y, uppDis)
    annotation (Line(points={{101,60},{152,60}},color={0,0,127}));
  connect(heaDif.y, greaterThreshold1.u)
    annotation (Line(points={{1.7,-40},{14,-40}},    color={0,0,127}));
  connect(switch1.u2, greaterThreshold1.y)
    annotation (Line(points={{46,-40},{37,-40}},color={255,0,255}));
  connect(integrator1.u, switch1.y)
    annotation (Line(points={{78,-40},{69,-40}}, color={0,0,127}));
  connect(integrator1.y, lowDis)
    annotation (Line(points={{101,-40},{152,-40}},color={0,0,127}));
  connect(sumDis.y, totDis)
    annotation (Line(points={{131.7,10},{152,10}},
                                                color={0,0,127}));
  connect(integrator.y, sumDis.u[1]) annotation (Line(points={{101,60},{104,60},
          {104,13.5},{110,13.5}},
                          color={0,0,127}));
  connect(integrator1.y, sumDis.u[2]) annotation (Line(points={{101,-40},{104,-40},
          {104,6.5},{110,6.5}}, color={0,0,127}));
  connect(heaDif.y, switch1.u1) annotation (Line(points={{1.7,-40},{8,-40},{8,-18},
          {40,-18},{40,-32},{46,-32}},             color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{29,-70},{40,-70},{40,-48},
          {46,-48}},        color={0,0,127}));
  connect(const.y, switch.u3) annotation (Line(points={{31,28},{40,28},{40,52},{
          46,52}}, color={0,0,127}));
  connect(cooDif.y, switch.u1) annotation (Line(points={{1.7,60},{8,60},{8,80},{
          40,80},{40,68},{46,68}},        color={0,0,127}));
  connect(TAir, cooDif.u[1]) annotation (Line(points={{-110,100},{-80,100},
          {-80,63.5},{-20,63.5}},
                             color={0,0,127}));
  connect(TAir, heaDif.u[1]) annotation (Line(points={{-110,100},{-80,100},
          {-80,-36.5},{-20,-36.5}},
                               color={0,0,127}));
  connect(setCoo, cooDif.u[2]) annotation (Line(points={{-110,-20},{-60,-20},
          {-60,56.5},{-20,56.5}}, color={0,0,127}));
  connect(setHea, heaDif.u[2]) annotation (Line(points={{-110,-60},{-40,-60},
          {-40,-43.5},{-20,-43.5}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,120}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{140,120}}), graphics={
        Rectangle(
          extent={{-100,120},{100,-100}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-94,34},{-26,40}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-30,34},{-24,90}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-30,84},{38,90}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{32,34},{38,90}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{32,34},{76,40}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-94,-34},{-24,-28}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-30,-34},{-24,22}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-30,16},{38,22}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{32,-34},{38,22}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{34,-34},{92,-28}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-94,-50},{-26,-32},{-12,42},{14,54},{48,-42},{84,-56}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-94,-34},{-94,-50},{-94,-50},{-88,-48},{-80,-46},{-70,-44},{-56,
              -40},{-46,-36},{-44,-34},{-94,-34}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-24,-12},{-24,16},{-16,16},{-18,10},{-20,0},{-22,-6},{-24,-12}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{28,16},{32,16},{28,16}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{26,16},{32,16},{32,2},{30,8},{26,16}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{50,-34},{82,-34},{92,-34},{92,-58},{84,-56},{64,-48},{58,-44},
              {52,-38},{50,-34}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<ul>
<li></li>
</ul>
</html>"));
end Comfort;
