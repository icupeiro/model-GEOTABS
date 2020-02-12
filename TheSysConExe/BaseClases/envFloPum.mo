within TheSysConExe.BaseClases;
model envFloPum "Envelope, floor heating, and pump"
  extends Exercises.Exe1RadiatorsBuildingEnvelope(zonNor(
      linIntRad=true,
      redeclare IDEAS.Buildings.Data.Constructions.InsulatedFloorHeating
        conTypFlo(mats={IDEAS.Buildings.Data.Materials.Concrete(d=0.10),
            IDEAS.Buildings.Data.Insulation.Pur(d=0.07),
            IDEAS.Buildings.Data.Materials.Screed(d=0.10),
            IDEAS.Buildings.Data.Materials.Tile(d=0.01)}),
      hasEmb=true), zonSou(redeclare
        IDEAS.Buildings.Data.Constructions.InsulatedFloorHeating conTypFlo(mats
          ={IDEAS.Buildings.Data.Materials.Concrete(d=0.10),
            IDEAS.Buildings.Data.Insulation.Pur(d=0.07),
            IDEAS.Buildings.Data.Materials.Screed(d=0.10),
            IDEAS.Buildings.Data.Materials.Tile(d=0.01)}), hasEmb=true));

  package MediumWater = IDEAS.Media.Water "Water Medium";
  IDEAS.Fluid.Movers.FlowControlled_dp pumEmi(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    dp_nominal=20000,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    m_flow_nominal=embNor.m_flow_nominal + embSou.m_flow_nominal,
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Circulation pump for emission system"
    annotation (Placement(transformation(extent={{140,50},{120,70}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemSup(redeclare package Medium =
        MediumWater, m_flow_nominal=pumEmi.m_flow_nominal,
    tau=0) "Supply water temperature sensor"
    annotation (Placement(transformation(extent={{168,70},{148,50}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(          redeclare package Medium =
        MediumWater, nPorts=1)
                     "Expansion vessel" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={148,90})));
  IDEAS.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal={embNor.m_flow_nominal,-embNor.m_flow_nominal - embSou.m_flow_nominal,
        -embSou.m_flow_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    dp_nominal={pumEmi.dp_nominal/100,0,pumEmi.dp_nominal/100})
                            "Junction"
    annotation (Placement(transformation(extent={{80,-40},{100,-60}})));
  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embNor(
    redeclare package Medium = MediumWater,
    redeclare IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_Standard1
      RadSlaCha,
    allowFlowReversal=true,
    m_flow_nominal=0.16,
    dp_nominal=pumEmi.dp_nominal/4,
    A_floor=zonNor.AZone) "Embedded pipe of floor heating in north zone"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embSou(
    redeclare package Medium = MediumWater,
    redeclare IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_Standard1
      RadSlaCha,
    allowFlowReversal=true,
    m_flow_nominal=0.16,
    dp_nominal=pumEmi.dp_nominal/4,
    A_floor=zonNor.AZone) "Embedded pipe of floor heating in south zone"
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  IDEAS.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal={embNor.m_flow_nominal + embSou.m_flow_nominal,-embNor.m_flow_nominal,
        -embSou.m_flow_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    dp_nominal={pumEmi.dp_nominal/100,0,0})
                           "Junction"
    annotation (Placement(transformation(extent={{100,50},{80,70}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemRet(
    redeclare package Medium = MediumWater,
    m_flow_nominal=pumEmi.m_flow_nominal,
    tau=0) "Return water temperature sensor"
    annotation (Placement(transformation(extent={{140,-40},{120,-60}})));
equation
  connect(senTemSup.port_b, pumEmi.port_a)
    annotation (Line(points={{148,60},{140,60}}, color={0,127,255}));
  connect(embNor.port_b,jun1. port_1) annotation (Line(points={{60,0},{66,0},{66,
          -50},{80,-50}}, color={0,127,255}));
  connect(embSou.port_b,jun1. port_3) annotation (Line(points={{100,0},{104,0},{
          104,-20},{90,-20},{90,-40}}, color={0,127,255}));
  connect(zonSou.gainEmb[1], embSou.heatPortEmb[1]) annotation (Line(points={{
          10,-39},{74,-39},{74,10},{90,10}}, color={191,0,0}));
  connect(zonNor.gainEmb[1], embNor.heatPortEmb[1]) annotation (Line(points={{
          10,21},{28,21},{28,10},{50,10}}, color={191,0,0}));
  connect(pumEmi.port_b, jun.port_1)
    annotation (Line(points={{120,60},{100,60}}, color={0,127,255}));

  connect(bou.ports[1], pumEmi.port_a)
    annotation (Line(points={{148,80},{148,60},{140,60}}, color={0,127,255}));
  connect(jun1.port_2, senTemRet.port_b)
    annotation (Line(points={{100,-50},{120,-50}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{180,100}})));
end envFloPum;
