within TheSysConExe.BaseClases;
model EnvFloPumHP "Building envelope, floor heating, pump, and heat pump"
  extends envFloPum;
  Modelica.Blocks.Continuous.Integrator ene(k=1/3600000)
    "Electrical energy meter with conversion to kWh"
    annotation (Placement(transformation(extent={{272,74},{292,94}})));
  IDEAS.Fluid.HeatPumps.ScrollWaterToWater heaPum(
    m2_flow_nominal=pumPrim.m_flow_nominal,
    enable_variable_speed=false,
    m1_flow_nominal=pum.m_flow_nominal,
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumWater,
    datHeaPum=
        IDEAS.Fluid.HeatPumps.Data.ScrollWaterToWater.Heating.Viessmann_BW301A21_28kW_5_94COP_R410A(),
    scaling_factor=0.05,
    dp1_nominal=10000,
    dp2_nominal=10000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heat pump model, rescaled for low thermal powers" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={246,-8})));

  IDEAS.Fluid.Sources.Boundary_pT
                            bou1(
    nPorts=2,
    redeclare package Medium = MediumWater,
    T=283.15) "Cold water source for heat pump"
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={326,-8})));
  IDEAS.Fluid.Movers.FlowControlled_dp pumPrim(
    inputType=IDEAS.Fluid.Types.InputType.Stages,
    dp_nominal=10000,
    m_flow_nominal=embNor.m_flow_nominal + embSou.m_flow_nominal,
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Circulation pump at primary side"
    annotation (Placement(transformation(extent={{296,32},{276,52}})));
equation
  connect(heaPum.port_a2,pumPrim. port_b)
    annotation (Line(points={{252,2},{252,42},{276,42}}, color={0,127,255}));
  connect(heaPum.port_b2,bou1. ports[1]) annotation (Line(points={{252,-18},{252,
          -48},{304,-48},{304,-10},{316,-10}}, color={0,127,255}));
  connect(pumPrim.port_a,bou1. ports[2]) annotation (Line(points={{296,42},{304,
          42},{304,-6},{316,-6}}, color={0,127,255}));
  connect(heaPum.P,ene. u) annotation (Line(points={{246,3},{248,3},{248,84},{270,
          84}}, color={0,0,127}));
  connect(jun1.port_2,heaPum. port_a1) annotation (Line(points={{100,-50},{240,-50},
          {240,-18}}, color={0,127,255}));
end EnvFloPumHP;
