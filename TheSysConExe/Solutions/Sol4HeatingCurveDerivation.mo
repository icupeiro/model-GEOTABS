within TheSysConExe.Solutions;
model Sol4HeatingCurveDerivation
  "Solution of the exercise on the derivation of the building heating curve"
  extends Exercises.Exe4RadiatorsHeatingCurveDerivation(
                                               conPID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=100,
      Ti=600,
      yMax=273.15 + 60,
      yMin=273.15 + 20,
      initType=Modelica.Blocks.Types.InitPID.InitialState));
  Modelica.Blocks.Continuous.Filter lowPasFilTe(
    analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
    filterType=Modelica.Blocks.Types.FilterType.LowPass,
    f_cut=1/(3*3600))  "Low pass filter for the outdoor temperature"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Blocks.Continuous.Filter lowPasFilSup(
    analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
    filterType=Modelica.Blocks.Types.FilterType.LowPass,
    f_cut=1/(3*3600))  "Low pass filter for the supply temperature"
    annotation (Placement(transformation(extent={{150,-10},{170,10}})));
protected
  IDEAS.BoundaryConditions.WeatherData.Bus weaDatBus
    "Weather data bus connectable to weaBus connector from Buildings Library"
    annotation (Placement(transformation(extent={{-62,72},{-42,92}})));
equation
  connect(sim.weaDatBus, weaDatBus) annotation (Line(
      points={{-80.1,90},{-68,90},{-68,82},{-52,82}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaDatBus.TDryBul, lowPasFilTe.u) annotation (Line(
      points={{-52,82},{-38,82},{-38,70},{-2,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTemSup.T, lowPasFilSup.u) annotation (Line(points={{158,49},{
          158,28},{134,28},{134,0},{148,0}}, color={0,0,127}));
  annotation (
    experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end Sol4HeatingCurveDerivation;
