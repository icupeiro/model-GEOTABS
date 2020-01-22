within TheSysConExe.Solutions;
model Sol8FloorHeatingBufferTank
  "Solution of exercise with floor heating, heat pump, and a buffer tank"
  extends Exercises.Exe8FloorHeatingBufferTank(
    valSou(P=0.2),
    valNor(P=0.2),
    heaPum(dp2_nominal=1000, scaling_factor=0.05),
    pumSec(dp_nominal=20000),
    pumEmi(inputType=IDEAS.Fluid.Types.InputType.Stages));
  Modelica.Blocks.Math.BooleanToInteger booToInt
    "Convert boolean signal into integer "
    annotation (Placement(transformation(extent={{46,112},{66,132}})));
  Modelica.Blocks.Sources.Constant TemSupRef(k=35 + 273.15)
    "Supply temperature reference"
    annotation (Placement(transformation(extent={{-66,112},{-46,132}})));
  Modelica.Blocks.Math.BooleanToInteger booToInt1
    "Convert boolean signal into integer "
    annotation (Placement(transformation(extent={{42,70},{62,90}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-42,70},{-22,90}})));
  Modelica.Blocks.Sources.Constant OffSet(k=0.5)
    "Offset from heating set point"
    annotation (Placement(transformation(extent={{-74,76},{-54,96}})));
protected
  Modelica.Blocks.Logical.OnOffController onOffCon(bandwidth=4)
    "On off controller for switching on and off the pump of the production system"
    annotation (Placement(transformation(extent={{6,112},{26,132}})));
protected
  Modelica.Blocks.Logical.OnOffController onOffCon1(bandwidth=1)
    "On off controller for switching on and off the pump of the production and emission systems"
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
equation
  connect(onOffCon.y,booToInt. u)
    annotation (Line(points={{27,122},{44,122}},
                                               color={255,0,255}));
  connect(booToInt.y, heaPum.stage) annotation (Line(points={{67,122},{82,
          122},{82,110},{338,110},{338,-76},{243,-76},{243,-20}},
                                                         color={255,127,0}));
  connect(TemSupRef.y, onOffCon.reference) annotation (Line(points={{-45,
          122},{-10,122},{-10,128},{4,128}}, color={0,0,127}));
  connect(onOffCon1.y, booToInt1.u)
    annotation (Line(points={{21,80},{40,80}}, color={255,0,255}));
  connect(add.y, onOffCon1.reference) annotation (Line(points={{-21,80},{-12,80},
          {-12,86},{-2,86}}, color={0,0,127}));
  connect(occ.setHea,add. u2) annotation (Line(points={{-58,44},{-52,44},{
          -52,74},{-44,74}}, color={0,0,127}));
  connect(onOffCon1.u, rectangularZoneTemplate.TSensor) annotation (Line(points=
         {{-2,74},{-10,74},{-10,60},{20,60},{20,32},{11,32}}, color={0,0,127}));
  connect(add.u1, OffSet.y)
    annotation (Line(points={{-44,86},{-53,86}}, color={0,0,127}));
  connect(booToInt1.y, pumEmi.stage)
    annotation (Line(points={{63,80},{130,80},{130,72}}, color={255,127,0}));
  connect(onOffCon.u, senTan.T) annotation (Line(points={{4,116},{-8,116},{-8,
          106},{212,106},{212,14},{226,14},{226,-10},{220,-10}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{340,140}})),
    experiment(
      StopTime=2419200,
      __Dymola_fixedstepsize=10,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(Advanced(
        InlineMethod=0,
        InlineOrder=2,
        InlineFixedStep=0.001)));
end Sol8FloorHeatingBufferTank;
