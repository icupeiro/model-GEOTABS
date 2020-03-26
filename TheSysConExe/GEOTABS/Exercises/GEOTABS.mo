within TheSysConExe.GEOTABS.Exercises;
model GEOTABS
  extends TheSysConExe.GEOTABS.BaseClasses.Envelope;
  package MediumWater = IDEAS.Media.Water "Water media";
  parameter Real valLea = 1e-10 "valve leakage";
  IDEAS.Fluid.Movers.FlowControlled_dp pumEmi(
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  addPowerToMedium=false,
  use_inputFilter=true,
  riseTime=120,
  dp_nominal=20000,
  inputType=IDEAS.Fluid.Types.InputType.Continuous,
  m_flow_nominal=max(mFlowEmiCoo.k, mFlowEmiHea.k),
  redeclare package Medium = MediumWater,
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Circulation pump for emission system"
    annotation (Placement(transformation(extent={{126,50},{106,70}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemSup(
  redeclare package Medium = MediumWater,
  m_flow_nominal=pumEmi.m_flow_nominal,
  tau=300) "Supply water temperature sensor"
    annotation (Placement(transformation(extent={{150,70},{130,50}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(redeclare package Medium = MediumWater,
    nPorts=1)        "Expansion vessel" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={128,20})));
  IDEAS.Fluid.FixedResistances.Junction jun1(
  redeclare package Medium = MediumWater,
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  m_flow_nominal={embNor.m_flow_nominal,-embNor.m_flow_nominal - embSou.m_flow_nominal,
      -embSou.m_flow_nominal},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
  dp_nominal={0,0,0})       "Junction"
    annotation (Placement(transformation(extent={{80,-40},{100,-60}})));
  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embNor(
  redeclare package Medium = MediumWater,
  redeclare IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_Standard1
    RadSlaCha,
  allowFlowReversal=true,
  m_flow_nominal=pumEmi.m_flow_nominal/2,
  computeFlowResistance=false,
    dp_nominal=0,
  A_floor=zonNor.AZone)   "Embedded pipe of floor heating in north zone"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe embSou(
  redeclare package Medium = MediumWater,
  redeclare IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_Standard1
    RadSlaCha,
  allowFlowReversal=true,
  m_flow_nominal=pumEmi.m_flow_nominal/2,
  computeFlowResistance=false,
    dp_nominal=0,
  A_floor=zonNor.AZone)   "Embedded pipe of floor heating in south zone"
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  IDEAS.Fluid.FixedResistances.Junction jun(
  redeclare package Medium = MediumWater,
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  from_dp=false,
  m_flow_nominal={embNor.m_flow_nominal + embSou.m_flow_nominal,-embNor.m_flow_nominal,
      -embSou.m_flow_nominal},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
  dp_nominal={0,0,0})      "Junction"
    annotation (Placement(transformation(extent={{100,50},{80,70}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemRet(
  redeclare package Medium = MediumWater,
  m_flow_nominal=pumEmi.m_flow_nominal,
  tau=0)   "Return water temperature sensor"
    annotation (Placement(transformation(extent={{130,-40},{110,-60}})));
  IDEAS.Fluid.HeatPumps.ScrollWaterToWater heaPum(
  m2_flow_nominal=pumSou.m_flow_nominal,
  enable_variable_speed=false,
  m1_flow_nominal=pumSin.m_flow_nominal,
  redeclare package Medium1 = MediumWater,
  redeclare package Medium2 = MediumWater,
  TEvaMin=273.15,
  datHeaPum=
      IDEAS.Fluid.HeatPumps.Data.ScrollWaterToWater.Heating.ClimateMaster_TMW036_12kW_4_90COP_R410A(),
  scaling_factor=1,
    dp1_nominal=0,
    dp2_nominal=0)
    "Heat pump model, rescaled for low thermal powers" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={246,-8})));

  IDEAS.Fluid.Sources.Boundary_pT
                            bou1(redeclare package Medium = MediumWater,
    nPorts=1) "Cold water source for heat pump"
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={326,-8})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow
                                       pumSou(
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  inputType=IDEAS.Fluid.Types.InputType.Continuous,
  addPowerToMedium=false,
  use_inputFilter=false,
  dp_nominal=heaPum.dp2_nominal,
  m_flow_nominal=max(mFlowSouCoo.k, mFlowSouHea.k),
  redeclare package Medium = MediumWater,
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Circulation pump at source side"
    annotation (Placement(transformation(extent={{302,32},{282,52}})));
  IDEAS.Fluid.Actuators.Valves.TwoWayPressureIndependent
                                         valNor(
  m_flow_nominal=pumEmi.m_flow_nominal/2,
  dpValve_nominal=pumEmi.dp_nominal,
  redeclare package Medium = MediumWater,
  use_inputFilter=false,
  l=valLea)     "Thermostatic valve for north zone"
                                        annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,30})));
  IDEAS.Fluid.Actuators.Valves.TwoWayPressureIndependent valSou(
  dpValve_nominal=pumEmi.dp_nominal,
  m_flow_nominal=pumEmi.m_flow_nominal/2,
  redeclare package Medium = MediumWater,
  use_inputFilter=false,
  from_dp=true,
  l=valLea) "Thermostatic valve for south zone" annotation (Placement(
      transformation(
      extent={{10,-10},{-10,10}},
      rotation=90,
      origin={90,30})));
  IDEAS.Fluid.Storage.Stratified tan(
  redeclare package Medium = MediumWater,
  m_flow_nominal=pumEmi.m_flow_nominal,
  VTan=vBufTan.k,
  hTan=2,
  dIns=0.1)   "Buffer tank for avoiding excessive heat pump on/off switches"
    annotation (Placement(transformation(extent={{200,-10},{180,10}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow
                                       pumSin(
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  addPowerToMedium=false,
  use_inputFilter=false,
  dp_nominal=heaPum.dp1_nominal,
  inputType=IDEAS.Fluid.Types.InputType.Stages,
  m_flow_nominal=mFlowSin.k,
  redeclare package Medium = MediumWater,
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    "Circulation pump at sink side"
    annotation (Placement(transformation(extent={{236,50},{216,70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTan
    "Temperature sensor of tank volume"
    annotation (Placement(transformation(extent={{200,-28},{220,-8}})));
IDEAS.Fluid.Geothermal.Borefields.OneUTube borFie(
  redeclare package Medium = MediumWater,
  borFieDat=borFieDat,
  dT_dz=0)
  annotation (Placement(transformation(extent={{280,-52},{300,-32}})));

  IDEAS.Utilities.Math.MovingAverage movingAverage6h(period=6*3600)
    annotation (Placement(transformation(extent={{-64,-86},{-44,-66}})));
  Modelica.Blocks.Sources.RealExpression outTem(y=sim.Te)
    annotation (Placement(transformation(extent={{-94,-86},{-74,-66}})));
  Modelica.Blocks.Tables.CombiTable1D heaCur(table=[273.15 - 8,273.15 + 28;
      273.15 + 0,273.15 + 25; 273.15 + 5,273.15 + 23.5; 273.15 + 15,273.15 +
      20.5; 273.15 + 16,273.15 + 20.5])
  "heating curve"
    annotation (Placement(transformation(extent={{-36,-86},{-16,-66}})));
  IDEAS.Controls.Continuous.LimPID conPIhea(
  controllerType=Modelica.Blocks.Types.SimpleController.PI,
  k=1,
  Ti(displayUnit="s") = 30)
  annotation (Placement(transformation(extent={{-8,-86},{12,-66}})));
  Modelica.Blocks.Sources.Constant TemTan(k=30 + 273.15)
    "Buffer tank reference"
    annotation (Placement(transformation(extent={{36,156},{56,176}})));
  Modelica.Blocks.Math.BooleanToInteger booToInt
    "Convert boolean signal into integer "
    annotation (Placement(transformation(extent={{108,150},{128,170}})));
parameter IDEAS.Fluid.Geothermal.Borefields.Data.Borefield.Example borFieDat(
  filDat=IDEAS.Fluid.Geothermal.Borefields.Data.Filling.Bentonite(kFil=1.5),
  soiDat=IDEAS.Fluid.Geothermal.Borefields.Data.Soil.SandStone(kSoi=1.8),
    conDat=IDEAS.Fluid.Geothermal.Borefields.Data.Configuration.Example(
        use_Rb=true,
        Rb=0.144,
        mBor_flow_nominal=0.1,
        dp_nominal=0,
        hBor=hBor.k,
        dBor=0,
        cooBor=[0,0; 0,6; 0,12; 0,18; 6,0; 6,6; 6,12; 6,18; 12,0; 12,6; 12,12; 12,
          18]))
  annotation (Placement(transformation(extent={{-96,126},{-76,146}})));
  Modelica.Blocks.Sources.RealExpression valNorCon(y=TNorCore.T)
  annotation (Placement(transformation(extent={{-100,-54},{-80,-34}})));
  Modelica.Blocks.Sources.RealExpression valSouCon(y=TSouCore.T)
  annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveMotor
                                              threeWayValveMotor(
    tau=300,
  l=valLea,
  m_flow_nominal=pumEmi.m_flow_nominal,
  redeclare package Medium = MediumWater)
                         "3-way mixing valve" annotation (Placement(
      transformation(
      extent={{10,-10},{-10,10}},
      rotation=0,
      origin={190,60})));
  IDEAS.Fluid.FixedResistances.Junction jun2(
  redeclare package Medium = MediumWater,
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  m_flow_nominal={embNor.m_flow_nominal + embSou.m_flow_nominal,-(embNor.m_flow_nominal
       + embSou.m_flow_nominal),-(embNor.m_flow_nominal + embSou.m_flow_nominal)},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
  dp_nominal={0,0,0})       "Junction"
    annotation (Placement(transformation(extent={{158,-40},{178,-60}})));
IDEAS.Controls.ControlHeating.RunningMeanTemperatureEN15251 rmot
  annotation (Placement(transformation(extent={{-96,156},{-76,176}})));
IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveSwitch
  threeWayValveSwitch(
  redeclare package Medium = MediumWater,
  tau=300,
  l=valLea,
  m_flow_nominal=pumSou.m_flow_nominal)
  annotation (Placement(transformation(extent={{256,52},{276,32}})));
  IDEAS.Fluid.FixedResistances.Junction jun3(
  redeclare package Medium = MediumWater,
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  from_dp=false,
  m_flow_nominal={embNor.m_flow_nominal,-embNor.m_flow_nominal - embSou.m_flow_nominal,
      -embSou.m_flow_nominal},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
  dp_nominal={0,0,0})       "Junction"
    annotation (Placement(transformation(extent={{258,-50},{274,-34}})));
IDEAS.Fluid.HeatExchangers.ConstantEffectiveness hex(
  redeclare package Medium1 = MediumWater,
  redeclare package Medium2 = MediumWater,
  m1_flow_nominal=pumEmi.m_flow_nominal,
  m2_flow_nominal=pumSou.m_flow_nominal,
  from_dp1=true,
    dp1_nominal=0,
  from_dp2=true,
    dp2_nominal=0)
  annotation (Placement(transformation(extent={{302,88},{282,108}})));
  Modelica.Blocks.Sources.BooleanExpression cooMode(y=mode.y)
  annotation (Placement(transformation(extent={{-94,-106},{-74,-86}})));
IDEAS.Fluid.Actuators.Valves.Simplified.ThreeWayValveSwitch
  threeWayValveSwitch1(
  redeclare package Medium = MediumWater,
  tau=300,
  l=valLea,
  m_flow_nominal=pumEmi.m_flow_nominal)
  annotation (Placement(transformation(extent={{176,70},{156,50}})));
  IDEAS.Fluid.FixedResistances.Junction jun4(
  redeclare package Medium = MediumWater,
  energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
  m_flow_nominal={embNor.m_flow_nominal + embSou.m_flow_nominal,-(embNor.m_flow_nominal
       + embSou.m_flow_nominal),-(embNor.m_flow_nominal + embSou.m_flow_nominal)},
  portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
  portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
  portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
  dp_nominal={0,0,0})       "Junction"
    annotation (Placement(transformation(extent={{136,-40},{156,-60}})));
  Modelica.Blocks.Sources.RealExpression dpEmi(y=if cooMode.y then 20000
       elseif heaMode.y then 20000*(mFlowEmiHea.y/mFlowEmiCoo.y)^2 else 20000)
  annotation (Placement(transformation(extent={{-94,-140},{-74,-120}})));
  Modelica.Blocks.Sources.RealExpression mFlowSouCon(y=if cooMode.y then
      conPIcoo.y*mFlowSouCoo.y elseif heaMode.y then mFlowSouHea.y else 0)
  annotation (Placement(transformation(extent={{-20,-140},{0,-120}})));
Modelica.Blocks.Sources.RealExpression valMixCon(y=if cooMode.y then 1
       elseif heaMode.y then conPIhea.y else 0)
  annotation (Placement(transformation(extent={{-56,-140},{-36,-120}})));
  Modelica.Blocks.Tables.CombiTable1D cooCur(table=[273.15 + 15,273.15 + 21;
      273.15 + 16,273.15 + 21; 273.15 + 20,273.15 + 20; 273.15 + 24,273.15 +
      19; 273.15 + 30,273.15 + 18])   "heating curve"
  annotation (Placement(transformation(extent={{-36,-112},{-16,-92}})));
  IDEAS.Controls.Continuous.LimPID conPIcoo(
  controllerType=Modelica.Blocks.Types.SimpleController.PI,
  k=1,
  Ti(displayUnit="s") = 30,
  reverseAction=true)
  annotation (Placement(transformation(extent={{-8,-112},{12,-92}})));
  Modelica.Blocks.Sources.RealExpression QBorFie(y=borFie.groTemRes.QBor_flow)
  annotation (Placement(transformation(extent={{350,148},{370,168}})));
  Modelica.Blocks.Continuous.Integrator ene(k=1/3600000)
    "Electrical energy meter with conversion to kWh"
    annotation (Placement(transformation(extent={{382,148},{402,168}})));
  Modelica.Blocks.Sources.Constant mFlowSin(k=0.6)
  "nominal mass flow in the sink pump"
    annotation (Placement(transformation(extent={{-8,156},{12,176}})));
  Modelica.Blocks.Sources.Constant mFlowSouHea(k=0.8)
  "nominal mass flow on the source pump in heating mode"
    annotation (Placement(transformation(extent={{-68,156},{-48,176}})));
  Modelica.Blocks.Sources.Constant mFlowEmiHea(k=1)
    "nominal mass flow in the emission side in heating mode"
    annotation (Placement(transformation(extent={{-68,124},{-48,144}})));
  Modelica.Blocks.Sources.Constant mFlowSouCoo(k=2)
  "nominal mass flow in the source side in cooling mode"
    annotation (Placement(transformation(extent={{-36,156},{-16,176}})));
  Modelica.Blocks.Sources.Constant mFlowEmiCoo(k=2)
  "nominal mass flow in the emission side in cooling mode"
    annotation (Placement(transformation(extent={{-38,124},{-18,144}})));
  Modelica.Blocks.Sources.Constant vBufTan(k=0.5)         "buffer tank volume"
    annotation (Placement(transformation(extent={{-8,124},{12,144}})));
  Modelica.Blocks.Sources.BooleanExpression heaMode(y=not mode.y)
  annotation (Placement(transformation(extent={{-94,-120},{-74,-100}})));
  Modelica.Blocks.Sources.Constant hBor(k=91.8) "borefield height per borehole"
    annotation (Placement(transformation(extent={{-68,92},{-48,112}})));
  IDEAS.Controls.Continuous.LimPID conPIvalNorHea(
  controllerType=Modelica.Blocks.Types.SimpleController.PI,
  k=1,
  Ti(displayUnit="s") = 30,
  yMin=0.01)
  annotation (Placement(transformation(extent={{-68,-28},{-48,-8}})));
  Modelica.Blocks.Sources.Constant conSP(k=273.15 + 22) "concrete setpoint"
    annotation (Placement(transformation(extent={{-100,-28},{-80,-8}})));
  IDEAS.Controls.Continuous.LimPID conPIvalSouHea(
  controllerType=Modelica.Blocks.Types.SimpleController.PI,
  k=1,
  Ti(displayUnit="s") = 30,
  yMin=0.01)
  annotation (Placement(transformation(extent={{-68,10},{-48,30}})));
IDEAS.Utilities.Math.Average conAvg(nin=2) "concrete average temperature"
  annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  IDEAS.Controls.Continuous.LimPID conPIvalSouCoo(
  controllerType=Modelica.Blocks.Types.SimpleController.PI,
  k=1,
  Ti(displayUnit="s") = 30,
  yMin=0.01,
  reverseAction=true)
  annotation (Placement(transformation(extent={{-36,10},{-16,30}})));
  IDEAS.Controls.Continuous.LimPID conPIvalNorCoo(
  controllerType=Modelica.Blocks.Types.SimpleController.PI,
  k=1,
  Ti(displayUnit="s") = 30,
  yMin=0.01,
  reverseAction=true)
  annotation (Placement(transformation(extent={{-36,-28},{-16,-8}})));
  Modelica.Blocks.Sources.RealExpression yValSou(y=if heaMode.y then
      conPIvalSouHea.y elseif cooMode.y then conPIvalSouCoo.y else 0.2)
  annotation (Placement(transformation(extent={{48,64},{68,84}})));
  Modelica.Blocks.Sources.RealExpression yValNor(y=if heaMode.y then
      conPIvalNorHea.y elseif cooMode.y then conPIvalNorCoo.y else 0.2)
  annotation (Placement(transformation(extent={{12,46},{32,66}})));
Modelica.Blocks.Logical.Hysteresis mode(uLow=273.15 + 22 - 0.5, uHigh=273.15
       + 22 + 1)
  annotation (Placement(transformation(extent={{64,-122},{84,-102}})));
Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TSouCore
  annotation (Placement(transformation(extent={{-110,24},{-90,46}})));
Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TNorCore
  annotation (Placement(transformation(extent={{-110,48},{-90,70}})));
protected
  Modelica.Blocks.Logical.OnOffController onOffCon(bandwidth=4)
  "On off controller for switching on and off the pump of the production system"
    annotation (Placement(transformation(extent={{74,148},{94,168}})));
equation
  connect(senTemSup.port_b,pumEmi. port_a)
    annotation (Line(points={{130,60},{126,60}}, color={0,127,255}));
  connect(embNor.port_b,jun1. port_1) annotation (Line(points={{60,0},{66,0},{66,
          -50},{80,-50}}, color={0,127,255}));
  connect(embSou.port_b,jun1. port_3) annotation (Line(points={{100,0},{104,0},{
          104,-20},{90,-20},{90,-40}}, color={0,127,255}));
  connect(zonSou.gainEmb[1],embSou. heatPortEmb[1]) annotation (Line(points={{
          10,-39},{74,-39},{74,10},{90,10}}, color={191,0,0}));
  connect(zonNor.gainEmb[1],embNor. heatPortEmb[1]) annotation (Line(points={{
          10,21},{28,21},{28,10},{50,10}}, color={191,0,0}));
  connect(pumEmi.port_b,jun. port_1)
    annotation (Line(points={{106,60},{100,60}}, color={0,127,255}));
  connect(bou.ports[1],pumEmi. port_a)
    annotation (Line(points={{128,30},{128,60},{126,60}}, color={0,127,255}));
  connect(jun1.port_2,senTemRet. port_b)
    annotation (Line(points={{100,-50},{110,-50}}, color={0,127,255}));
connect(jun.port_3, valSou.port_a)
  annotation (Line(points={{90,50},{90,40}}, color={0,127,255}));
connect(valSou.port_b, embSou.port_a) annotation (Line(points={{90,20},{90,14},
        {76,14},{76,0},{80,0}}, color={0,127,255}));
  connect(valNor.port_a,jun. port_2)
    annotation (Line(points={{50,40},{50,60},{80,60}}, color={0,127,255}));
  connect(valNor.port_b,embNor. port_a) annotation (Line(points={{50,20},{
          50,16},{34,16},{34,0},{40,0}}, color={0,127,255}));
  connect(pumSin.port_a,heaPum. port_b1)
    annotation (Line(points={{236,60},{240,60},{240,2}}, color={0,127,255}));
  connect(tan.heaPorVol[1],senTan. port)
    annotation (Line(points={{190,0},{190,-18},{200,-18}}, color={191,0,0}));
connect(borFie.port_b,pumSou. port_a) annotation (Line(points={{300,-42},{306,
        -42},{306,42},{302,42}}, color={0,127,255}));
connect(bou1.ports[1],pumSou. port_a) annotation (Line(points={{316,-8},{306,
        -8},{306,42},{302,42}}, color={0,127,255}));
  connect(outTem.y, movingAverage6h.u)
    annotation (Line(points={{-73,-76},{-66,-76}},
                                                 color={0,0,127}));
  connect(movingAverage6h.y, heaCur.u[1])
    annotation (Line(points={{-43,-76},{-38,-76}},
                                                 color={0,0,127}));
connect(heaCur.y[1], conPIhea.u_s)
  annotation (Line(points={{-15,-76},{-10,-76}},
                                             color={0,0,127}));
connect(senTemSup.T, conPIhea.u_m) annotation (Line(points={{140,49},{140,-116},
          {2,-116},{2,-88}},
                          color={0,0,127},
      visible=false));
  connect(tan.port_a,pumSin. port_b) annotation (Line(points={{200,0},{208,0},{208,
          60},{216,60}}, color={0,127,255}));
  connect(tan.port_b, heaPum.port_a1) annotation (Line(points={{180,0},{186,0},
        {186,-50},{240,-50},{240,-18}},  color={0,127,255}));
  connect(TemTan.y, onOffCon.reference)
    annotation (Line(points={{57,166},{64,166},{64,164},{72,164}},
                                                 color={0,0,127}));
  connect(onOffCon.u, senTan.T) annotation (Line(points={{72,152},{68,152},{
        68,122},{290,122},{290,-2},{304,-2},{304,-18},{220,-18}},color={0,0,127},
      visible=false));

  connect(onOffCon.y,booToInt. u)
    annotation (Line(points={{95,158},{100,158},{100,160},{106,160}},
                                               color={255,0,255}));
  connect(booToInt.y, heaPum.stage) annotation (Line(points={{129,160},{338,160},
          {338,-78},{243,-78},{243,-20}},                color={255,127,0},
      visible=false));
connect(tan.port_b, jun2.port_2)
  annotation (Line(points={{180,0},{180,-50},{178,-50}},
                                                       color={0,127,255}));
connect(heaPum.port_a2, threeWayValveSwitch.port_a1)
  annotation (Line(points={{252,2},{252,42},{256,42}}, color={0,127,255}));
connect(threeWayValveSwitch.port_b,pumSou. port_b)
  annotation (Line(points={{276,42},{282,42}}, color={0,127,255}));
connect(heaPum.port_b2, jun3.port_1) annotation (Line(points={{252,-18},{252,
        -42},{258,-42}}, color={0,127,255}));
connect(jun3.port_2, borFie.port_a)
  annotation (Line(points={{274,-42},{280,-42}}, color={0,127,255}));
connect(threeWayValveSwitch.port_a2, hex.port_a2)
  annotation (Line(points={{266,52},{266,92},{282,92}}, color={0,127,255}));
connect(hex.port_b2, jun3.port_3) annotation (Line(points={{302,92},{344,92},{344,
          -64},{266,-64},{266,-50}},    color={0,127,255}));
connect(cooMode.y, threeWayValveSwitch.switch) annotation (Line(points={{-73,-96},
        {266,-96},{266,34}},      color={255,0,255},
    visible=false));
connect(threeWayValveSwitch1.port_b, senTemSup.port_a)
  annotation (Line(points={{156,60},{150,60}}, color={0,127,255}));
connect(jun2.port_1, jun4.port_2)
  annotation (Line(points={{158,-50},{156,-50}}, color={0,127,255}));
connect(jun4.port_1, senTemRet.port_a)
  annotation (Line(points={{136,-50},{130,-50}}, color={0,127,255}));
connect(threeWayValveSwitch1.switch, threeWayValveSwitch.switch) annotation (
    Line(points={{166,52},{166,-80},{266,-80},{266,34}}, color={255,0,255},
      visible=false));
connect(pumEmi.dp_in, dpEmi.y)
  annotation (Line(points={{116,72},{116,-130},{-73,-130}},
                                                       color={0,0,127},
      visible=false));
connect(threeWayValveSwitch1.port_a2, hex.port_b1) annotation (Line(points={{
        166,70},{166,104},{282,104}}, color={0,127,255}));
connect(jun4.port_3, hex.port_a1) annotation (Line(points={{146,-40},{146,130},
        {314,130},{314,104},{302,104}}, color={0,127,255}));
connect(mFlowSouCon.y, pumSou.m_flow_in) annotation (Line(
    points={{1,-130},{292,-130},{292,54}},
    color={0,0,127},
    visible=false));
connect(booToInt.y,pumSin. stage) annotation (Line(points={{129,160},{192,160},{
          192,158},{226,158},{226,72}},
                                      color={255,127,0},
      visible=false));
connect(senTemSup.T, conPIcoo.u_m)
  annotation (Line(points={{140,49},{140,-114},{2,-114}},
                                                       color={0,0,127},
      visible=false));
connect(cooCur.y[1], conPIcoo.u_s)
  annotation (Line(points={{-15,-102},{-10,-102}},
                                             color={0,0,127}));
connect(cooCur.u[1], movingAverage6h.y) annotation (Line(points={{-38,-102},{-42,
          -102},{-42,-76},{-43,-76}},
                                    color={0,0,127}));
connect(QBorFie.y, ene.u)
  annotation (Line(points={{371,158},{380,158}}, color={0,0,127}));
  connect(threeWayValveMotor.port_b, threeWayValveSwitch1.port_a1)
    annotation (Line(points={{180,60},{176,60}}, color={0,127,255}));
  connect(threeWayValveMotor.port_a1, tan.port_a)
    annotation (Line(points={{200,60},{200,0},{200,0}}, color={0,127,255}));
  connect(threeWayValveMotor.port_a2, jun2.port_3) annotation (Line(points={{190,50},
        {190,28},{168,28},{168,-40}},       color={0,127,255}));
  connect(valMixCon.y, threeWayValveMotor.ctrl) annotation (Line(
      points={{-35,-130},{190,-130},{190,70.8}},
      color={0,0,127},
      visible=false));
connect(valNorCon.y, conPIvalNorHea.u_m)
  annotation (Line(points={{-79,-44},{-58,-44},{-58,-30}}, color={0,0,127}));
connect(conSP.y, conPIvalNorHea.u_s)
  annotation (Line(points={{-79,-18},{-70,-18}}, color={0,0,127}));
connect(conSP.y, conPIvalSouHea.u_s) annotation (Line(points={{-79,-18},{-76,
        -18},{-76,20},{-70,20}}, color={0,0,127}));
connect(valSouCon.y, conPIvalSouHea.u_m)
  annotation (Line(points={{-79,4},{-58,4},{-58,8}}, color={0,0,127}));
connect(valNorCon.y, conAvg.u[1]) annotation (Line(
    points={{-79,-44},{-62,-44},{-62,49},{-42,49}},
    color={0,0,127},
    visible=false));
connect(valSouCon.y, conAvg.u[2]) annotation (Line(
    points={{-79,4},{-79,27},{-42,27},{-42,51}},
    color={0,0,127},
    visible=false));
connect(conSP.y, conPIvalNorCoo.u_s) annotation (Line(points={{-79,-18},{-76,
        -18},{-76,-2},{-38,-2},{-38,-18}}, color={0,0,127}));
connect(conSP.y, conPIvalSouCoo.u_s) annotation (Line(points={{-79,-18},{-76,
        -18},{-76,-2},{-38,-2},{-38,20}}, color={0,0,127}));
connect(valNorCon.y, conPIvalNorCoo.u_m)
  annotation (Line(points={{-79,-44},{-26,-44},{-26,-30}}, color={0,0,127}));
connect(valSouCon.y, conPIvalSouCoo.u_m)
  annotation (Line(points={{-79,4},{-26,4},{-26,8}}, color={0,0,127}));
connect(yValNor.y, valNor.y) annotation (Line(points={{33,56},{34,56},{34,30},
        {38,30}}, color={0,0,127}));
connect(yValSou.y, valSou.y) annotation (Line(points={{69,74},{74,74},{74,30},
        {78,30}}, color={0,0,127}));
connect(mode.u, conAvg.y) annotation (Line(points={{62,-112},{62,-31},{-19,
        -31},{-19,50}}, color={0,0,127}));
connect(zonNor.gainEmb[2], TNorCore) annotation (Line(points={{10,21},{16,21},
        {16,76},{-88,76},{-88,59},{-100,59}}, color={191,0,0}));
connect(zonSou.gainEmb[2], TSouCore) annotation (Line(points={{10,-39},{10,
        -56},{-110,-56},{-110,34},{-100,34},{-100,35}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},
            {420,180}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-140},{420,180}})),
  experiment(
    StopTime=31536000,
    Interval=3600,
    Tolerance=0.001,
    __Dymola_fixedstepsize=10,
    __Dymola_Algorithm="Euler"));
end GEOTABS;
