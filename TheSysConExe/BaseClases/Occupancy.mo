within TheSysConExe.BaseClases;
model Occupancy "Occupancy schedule"
  extends IDEAS.Buildings.Components.Occupants.BaseClasses.PartialOccupants(final useInput=false);

  parameter Modelica.SIunits.Temperature setHeaOcc=21+273.15
      "Heating setpoint when occupied";
  parameter Modelica.SIunits.Temperature setHeaUno=18+273.15
      "Heating setpoint when unoccupied";

  parameter Modelica.SIunits.Temperature setCooOcc=23+273.15
      "Cooling setpoint when occupied";
  parameter Modelica.SIunits.Temperature setCooUno=26+273.15
      "Cooling setpoint when unoccupied";

  parameter Real k "Number of occupants per zone";
  IDEAS.Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Sources.RealExpression occ(y=if calTim.weekDay < 6 and (
        calTim.hour > 7 and calTim.hour < 18) then k else 0)
    "Number of occupants present"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{72,54},{84,66}})));
  Modelica.Blocks.Sources.Constant setHeaOccCnt(k=setHeaOcc)
    "Heating setpoint when occupied"
    annotation (Placement(transformation(extent={{48,-70},{56,-62}})));
  Modelica.Blocks.Sources.Constant setHeaUnoCnt(k=setHeaUno)
    "Heating setpoint when unoccupied"
    annotation (Placement(transformation(extent={{48,-96},{56,-88}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{72,-86},{84,-74}})));
  Modelica.Blocks.Sources.Constant setCooOccCnt(k=setCooOcc)
    "Cooling setpoint when occupied"
    annotation (Placement(transformation(extent={{46,68},{54,76}})));
  Modelica.Blocks.Sources.Constant setCooUnoCnt(k=setCooUno)
    "Cooling setpoint when unoccupied"
    annotation (Placement(transformation(extent={{46,44},{54,52}})));
  Modelica.Blocks.Interfaces.RealOutput setHea(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Heating setpoint"
    annotation (Placement(transformation(extent={{100,-100},{140,-60}}),
        iconTransformation(extent={{100,-80},{140,-40}})));
  Modelica.Blocks.Interfaces.RealOutput setCoo(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Cooling setpoint"
    annotation (Placement(transformation(extent={{100,40},{140,80}}),
        iconTransformation(extent={{100,40},{140,80}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
equation
  connect(occ.y, nOcc)
    annotation (Line(points={{1,0},{120,0}}, color={0,0,127}));
  connect(setCooOccCnt.y, switch1.u1) annotation (Line(points={{54.4,72},{62,72},
          {62,64.8},{70.8,64.8}}, color={0,0,127}));
  connect(setCooUnoCnt.y, switch1.u3) annotation (Line(points={{54.4,48},{62,48},
          {62,55.2},{70.8,55.2}}, color={0,0,127}));
  connect(setHeaUnoCnt.y, switch2.u3) annotation (Line(points={{56.4,-92},{64,-92},
          {64,-84.8},{70.8,-84.8}}, color={0,0,127}));
  connect(setHeaOccCnt.y, switch2.u1) annotation (Line(points={{56.4,-66},{64,-66},
          {64,-75.2},{70.8,-75.2}}, color={0,0,127}));
  connect(occ.y, greaterThreshold.u) annotation (Line(points={{1,0},{20,0},
          {20,-20},{-80,-20},{-80,-80},{-62,-80}}, color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{-39,-80},
          {28,-80},{28,60},{70.8,60}}, color={255,0,255}));
  connect(greaterThreshold.y, switch2.u2)
    annotation (Line(points={{-39,-80},{70.8,-80}}, color={255,0,255}));
  connect(switch1.y,setCoo)
    annotation (Line(points={{84.6,60},{120,60}}, color={0,0,127}));
  connect(switch2.y,setHea)
    annotation (Line(points={{84.6,-80},{120,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
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
          extent={{-30,84},{32,90}},
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
          extent={{-30,16},{32,22}},
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
          extent={{34,-34},{76,-28}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end Occupancy;
