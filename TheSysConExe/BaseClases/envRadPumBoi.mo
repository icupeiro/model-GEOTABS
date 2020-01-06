within TheSysConExe.BaseClases;
partial model envRadPumBoi "Envelope, radiators, pump and boiler"
  extends Exercises.Exe1BuildingEnvelope(occ(
      setCooOcc=23 + 273.15,
      setCooUno=23 + 273.15));
  package MediumWater = IDEAS.Media.Water "Water Medium";
  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radNor(
    redeclare package Medium = MediumWater,
    Q_flow_nominal=1000,
    T_a_nominal=333.15,
    T_b_nominal=323.15,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Radiator for north zone" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-10})));
  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radSou(
    redeclare package Medium = MediumWater,
    Q_flow_nominal=1000,
    T_a_nominal=333.15,
    T_b_nominal=323.15,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Radiator for south zone" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,-10})));
  IDEAS.Fluid.Movers.FlowControlled_dp pum(
    dp_nominal=20000,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    m_flow_nominal=radNor.m_flow_nominal + radSou.m_flow_nominal,
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Circulation pump at secondary side"
    annotation (Placement(transformation(extent={{140,50},{120,70}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemSup(redeclare package Medium =
        MediumWater, m_flow_nominal=pum.m_flow_nominal)
    "Supply water temperature sensor"
    annotation (Placement(transformation(extent={{168,70},{148,50}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        MediumWater) "Expansion vessel" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={110,82})));
  IDEAS.Fluid.HeatExchangers.Heater_T boi(
    redeclare package Medium = MediumWater,
    m_flow_nominal=pum.m_flow_nominal,
    dp_nominal=10000) "Ideal boiler with prescribed supply temperature"
    annotation (Placement(transformation(extent={{220,10},{200,30}})));
  Modelica.Blocks.Continuous.Integrator ene(k=1/3600000)
    "Energy meter with conversion to kWh"
    annotation (Placement(transformation(extent={{220,72},{240,92}})));
  IDEAS.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumWater,
    m_flow_nominal={radNor.m_flow_nominal,-radNor.m_flow_nominal - radSou.m_flow_nominal,
        -radSou.m_flow_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    dp_nominal={500,0,500}) "Junction"
    annotation (Placement(transformation(extent={{80,-40},{100,-60}})));
  IDEAS.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = MediumWater,
    m_flow_nominal={radNor.m_flow_nominal + radSou.m_flow_nominal,-radNor.m_flow_nominal,
        -radSou.m_flow_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    dp_nominal={1000,0,0}) "Junction"
    annotation (Placement(transformation(extent={{100,50},{80,70}})));
equation
  connect(radNor.heatPortCon, rectangularZoneTemplate.gainCon) annotation (
      Line(points={{42.8,-8},{20,-8},{20,27},{10,27}}, color={191,0,0}));
  connect(radNor.heatPortRad, rectangularZoneTemplate.gainRad) annotation (
      Line(points={{42.8,-12},{16,-12},{16,24},{10,24}}, color={191,0,0}));
  connect(radSou.heatPortCon, rectangularZoneTemplate1.gainCon) annotation (
     Line(points={{82.8,-8},{66,-8},{66,-33},{10,-33}}, color={191,0,0}));
  connect(radSou.heatPortRad, rectangularZoneTemplate1.gainRad) annotation (
     Line(points={{82.8,-12},{70,-12},{70,-36},{10,-36}}, color={191,0,0}));
  connect(bou.ports[1], pum.port_b) annotation (Line(points={{110,72},{110,
          60},{120,60}}, color={0,127,255}));
  connect(senTemSup.port_b, pum.port_a)
    annotation (Line(points={{148,60},{140,60}}, color={0,127,255}));
  connect(boi.port_b, senTemSup.port_a) annotation (Line(points={{200,20},{
          180,20},{180,60},{168,60}}, color={0,127,255}));
  connect(boi.Q_flow,ene. u) annotation (Line(points={{199,28},{192,28},{
          192,82},{218,82}}, color={0,0,127}));
  connect(radNor.port_b, jun1.port_1) annotation (Line(points={{50,-20},{50,
          -50},{80,-50}}, color={0,127,255}));
  connect(radSou.port_b, jun1.port_3)
    annotation (Line(points={{90,-20},{90,-40}}, color={0,127,255}));
  connect(jun1.port_2, boi.port_a) annotation (Line(points={{100,-50},{220,
          -50},{220,20}}, color={0,127,255}));
  connect(pum.port_b, jun.port_1)
    annotation (Line(points={{120,60},{100,60}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{260,100}})),
                                                    Icon(coordinateSystem(
          extent={{-100,-100},{260,100}})),
    experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end envRadPumBoi;
