within TheSysConExe.Solutions;
model Sol8FloorHeatingBufferTank
  "Solution of exercise with floor heating, heat pump, and a buffer tank"
  extends Exercises.Exe8FloorHeatingBufferTank(valSou(P=0.2), valNor(P=0.2));
  Modelica.Blocks.Math.BooleanToInteger booToInt
    "Convert boolean signal into integer "
    annotation (Placement(transformation(extent={{46,112},{66,132}})));
  Modelica.Blocks.Sources.Constant TemSupRef(k=30 + 273.15)
    "Supply temperature reference"
    annotation (Placement(transformation(extent={{-66,112},{-46,132}})));
protected
  Modelica.Blocks.Logical.OnOffController onOffCon(bandwidth=4)
    "On off controller for switching on and off the pump of the production system"
    annotation (Placement(transformation(extent={{6,112},{26,132}})));
equation
  connect(onOffCon.y,booToInt. u)
    annotation (Line(points={{27,122},{44,122}},
                                               color={255,0,255}));
  connect(booToInt.y, heaPum.stage) annotation (Line(points={{67,122},{82,
          122},{82,110},{338,110},{338,-76},{243,-76},{243,-20}},
                                                         color={255,127,0}));
  connect(TemSupRef.y, onOffCon.reference) annotation (Line(points={{-45,
          122},{-10,122},{-10,128},{4,128}}, color={0,0,127}));
  connect(onOffCon.u, senTemSup.T) annotation (Line(points={{4,116},{0,116},
          {0,104},{180,104},{180,44},{158,44},{158,49}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{340,140}})),
      Icon(coordinateSystem(extent={{-100,-100},{340,140}})));
end Sol8FloorHeatingBufferTank;
