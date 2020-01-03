within TheSysConExe.Solutions;
model Sol5HeatingCurveImplementation
  "Solution to the heating curve exercise"
  extends Exercises.Exe5HeatingCurveImplementation(
    heaCurTab(table=[266,335; 286,315]),
    valNor(P=0.2),
    valSou(P=0.2));

  Modelica.Blocks.Continuous.Filter lowPasFilTe(
    analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
    filterType=Modelica.Blocks.Types.FilterType.LowPass,
    f_cut=1/(3*3600))  "Low pass filter for the outdoor temperature"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
protected
  IDEAS.BoundaryConditions.WeatherData.Bus weaDatBus
    "Weather data bus connectable to weaBus connector from Buildings Library"
    annotation (Placement(transformation(extent={{-62,72},{-42,92}})));
equation
  connect(sim.weaDatBus,weaDatBus)  annotation (Line(
      points={{-80.1,90},{-68,90},{-68,82},{-52,82}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaDatBus.TDryBul,lowPasFilTe. u) annotation (Line(
      points={{-52,82},{-38,82},{-38,70},{-2,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(lowPasFilTe.y, heaCurTab.u[1]) annotation (Line(points={{21,70},{
          40,70},{40,50},{-40,50},{-40,-80},{258,-80},{258,40},{254,40}},
        color={0,0,127}));
end Sol5HeatingCurveImplementation;
