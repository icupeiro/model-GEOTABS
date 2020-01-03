within TheSysConExe.Exercises;
model Exe4HeatingCurveDerivation "Derivation of the building heating curve"
  extends BaseClases.envRadPumBoi;
  Modelica.Blocks.Continuous.LimPID conPID
    "PID controller for the supply temperature from ideal boiler"
    annotation (Placement(transformation(extent={{200,-82},{220,-62}})));
equation
  connect(jun.port_3, radSou.port_a)
    annotation (Line(points={{90,50},{90,0}}, color={0,127,255}));
  connect(jun.port_2, radNor.port_a)
    annotation (Line(points={{80,60},{50,60},{50,0}}, color={0,127,255}));
  connect(occ.setHea, conPID.u_s) annotation (Line(points={{-58,44},{-46,44},
          {-46,-72},{198,-72}}, color={0,0,127}));
  connect(conPID.y, boi.TSet) annotation (Line(points={{221,-72},{240,-72},
          {240,28},{222,28}}, color={0,0,127}));
  connect(rectangularZoneTemplate.TSensor, conPID.u_m) annotation (Line(
        points={{11,32},{20,32},{20,46},{-20,46},{-20,-94},{210,-94},{210,
          -84}}, color={0,0,127}));
end Exe4HeatingCurveDerivation;
