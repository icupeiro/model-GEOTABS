within TheSysConExe.BaseClases;
model envFloPumHP
  "Building envelope, floor heating, pump, and heat pump"
  extends envFloPum;
  Modelica.Blocks.Continuous.Integrator ene(k=1/3600000)
    "Electrical energy meter with conversion to kWh"
    annotation (Placement(transformation(extent={{272,74},{292,94}})));
  IDEAS.Fluid.HeatPumps.ScrollWaterToWater heaPum(
    m2_flow_nominal=pumPri.m_flow_nominal,
    enable_variable_speed=false,
    m1_flow_nominal=pumEmi.m_flow_nominal,
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumWater,
    datHeaPum=
        IDEAS.Fluid.HeatPumps.Data.ScrollWaterToWater.Heating.ClimateMaster_TMW036_12kW_4_90COP_R410A(),
    scaling_factor=1,
    dp1_nominal=pumEmi.dp_nominal/4,
    dp2_nominal=pumPri.dp_nominal/4,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Heat pump model, rescaled for low thermal powers" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={246,-8})));

  IDEAS.Fluid.Sources.Boundary_pT
                            bou1(
    redeclare package Medium = MediumWater)
              "Cold water source for heat pump"
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={326,-8})));
  IDEAS.Fluid.Movers.FlowControlled_dp pumPri(
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    use_inputFilter=false,
    dp_nominal=heaPum.dp1_nominal,
    m_flow_nominal=pumEmi.m_flow_nominal,
    redeclare package Medium = MediumWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Circulation pump at primary side"
    annotation (Placement(transformation(extent={{296,32},{276,52}})));
equation
  connect(heaPum.port_a2, pumPri.port_b)
    annotation (Line(points={{252,2},{252,42},{276,42}}, color={0,127,255}));
  connect(heaPum.P,ene. u) annotation (Line(points={{246,3},{248,3},{248,84},{270,
          84}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{340,100}})));
end envFloPumHP;
