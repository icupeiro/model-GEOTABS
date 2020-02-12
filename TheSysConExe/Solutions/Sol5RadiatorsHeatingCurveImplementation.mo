within TheSysConExe.Solutions;
model Sol5RadiatorsHeatingCurveImplementation
  "Solution to the heating curve exercise"
  extends Exercises.Exe5RadiatorsHeatingCurveImplementation(
    heaCurTab(table=[266,325; 286,310]),
    valNor(P=0.1),
    valSou(P=0.1),
    pum(inputType=IDEAS.Fluid.Types.InputType.Stages));

  Modelica.Blocks.Continuous.Filter lowPasFilTe(
    analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
    filterType=Modelica.Blocks.Types.FilterType.LowPass,
    f_cut=1/(3*3600))  "Low pass filter for the outdoor temperature"
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Blocks.Math.BooleanToInteger booToInt
    "Convert boolean signal into integer "
    annotation (Placement(transformation(extent={{42,70},{62,90}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-42,70},{-22,90}})));
  Modelica.Blocks.Sources.Constant OffSet(k=0.0001)
    "Offset from heating set point"
    annotation (Placement(transformation(extent={{-74,92},{-54,112}})));
protected
  IDEAS.BoundaryConditions.WeatherData.Bus weaDatBus
    "Weather data bus connectable to weaBus connector from Buildings Library"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
protected
  Modelica.Blocks.Logical.OnOffController onOffCon(bandwidth=1)
    "On off controller for switching on and off the pump of the emission system according to zone temperature readings"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
equation
  connect(booToInt.y, pum.stage) annotation (Line(points={{63,80},{80,80},{
          80,98},{130,98},{130,72}}, color={255,127,0}));
  connect(onOffCon.y,booToInt. u)
    annotation (Line(points={{21,80},{40,80}}, color={255,0,255}));
  connect(add.y,onOffCon. reference) annotation (Line(points={{-21,80},{-12,
          80},{-12,86},{-2,86}}, color={0,0,127}));
  connect(occ.setHea,add. u2) annotation (Line(points={{-58,44},{-52,44},{
          -52,74},{-44,74}}, color={0,0,127}));
  connect(add.u1,OffSet. y) annotation (Line(points={{-44,86},{-48,86},{-48,
          102},{-53,102}}, color={0,0,127}));
  connect(onOffCon.u, zonNor.TSensor) annotation (Line(points={{-2,74},{-10,74},
          {-10,60},{20,60},{20,32},{11,32}}, color={0,0,127}));
  connect(sim.weaDatBus, weaDatBus) annotation (Line(
      points={{-80.1,90},{-80,90},{-80,66},{-90,66},{-90,0},{-60,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaDatBus.TDryBul, lowPasFilTe.u) annotation (Line(
      points={{-60,0},{-60,-80},{-42,-80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(lowPasFilTe.y, heaCurTab.u[1]) annotation (Line(points={{-19,-80},{
          258,-80},{258,40},{254,40}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{260,120}})), Icon(
        coordinateSystem(extent={{-100,-100},{100,120}})),
    experiment(StopTime=2419200, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end Sol5RadiatorsHeatingCurveImplementation;
