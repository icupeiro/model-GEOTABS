within TheSysConExe.Solutions;
model Sol6FloorHeatingOnOffThermostat
  "Solution of exercise with floor heating, heat pump, and on off thermostat"
  extends Exercises.Exe6FloorHeatingOnOffThermostat(pumEmi(inputType=IDEAS.Fluid.Types.InputType.Constant),
      heaPum(scaling_factor=0.3),
    bou1(T=278.15),
    pumPri(m_flow_nominal=pumEmi.m_flow_nominal));
  Modelica.Blocks.Math.BooleanToInteger booToInt
    "Convert boolean signal into integer "
    annotation (Placement(transformation(extent={{42,70},{62,90}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-42,70},{-22,90}})));
  Modelica.Blocks.Sources.Constant OffSet(k=0.5)
    "Offset from heating set point"
    annotation (Placement(transformation(extent={{-74,92},{-54,112}})));
  Modelica.Blocks.Continuous.Integrator enePumSec(k=1/3600000)
    "Electrical energy meter with conversion to kWh"
    annotation (Placement(transformation(extent={{138,-10},{158,10}})));
  Modelica.Blocks.Continuous.Integrator enePumPrim(k=1/3600000)
    "Electrical energy meter with conversion to kWh"
    annotation (Placement(transformation(extent={{274,-10},{294,10}})));
protected
  Modelica.Blocks.Logical.OnOffController onOffCon(bandwidth=1)
    "On off controller for switching on and off the pump of the production and emission systems"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
equation
  connect(onOffCon.y,booToInt. u)
    annotation (Line(points={{21,80},{40,80}}, color={255,0,255}));
  connect(add.y,onOffCon. reference) annotation (Line(points={{-21,80},{-12,
          80},{-12,86},{-2,86}}, color={0,0,127}));
  connect(occ.setHea,add. u2) annotation (Line(points={{-58,44},{-52,44},{
          -52,74},{-44,74}}, color={0,0,127}));
  connect(add.u1,OffSet. y) annotation (Line(points={{-44,86},{-48,86},{-48,
          102},{-53,102}}, color={0,0,127}));
  connect(booToInt.y, heaPum.stage) annotation (Line(points={{63,80},{82,80},{82,
          112},{338,112},{338,-74},{243,-74},{243,-20}}, color={255,127,0}));
  connect(onOffCon.u, rectangularZoneTemplate.TSensor) annotation (Line(
        points={{-2,74},{-10,74},{-10,60},{20,60},{20,32},{11,32}}, color={
          0,0,127}));
  connect(pumPri.P, enePumPrim.u) annotation (Line(points={{275,51},{260,51},{
          260,0},{272,0}}, color={0,0,127}));
  connect(pumEmi.P, enePumSec.u) annotation (Line(points={{119,69},{114,69},{
          114,0},{136,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{340,120}})),
    experiment(StopTime=2419200, __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false));
end Sol6FloorHeatingOnOffThermostat;
