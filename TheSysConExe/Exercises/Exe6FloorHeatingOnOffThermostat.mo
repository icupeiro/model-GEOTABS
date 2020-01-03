within TheSysConExe.Exercises;
model Exe6FloorHeatingOnOffThermostat
  "Building with floor heating as emission system and heat pump as production system"
  extends BaseClases.EnvFloPumHP;
equation
  connect(jun.port_2, embNor.port_a) annotation (Line(points={{80,60},{50,
          60},{50,20},{34,20},{34,0},{40,0}}, color={0,127,255}));
  connect(jun.port_3, embSou.port_a) annotation (Line(points={{90,50},{90,
          20},{76,20},{76,0},{80,0}}, color={0,127,255}));
  connect(heaPum.port_b1, senTemSup.port_a) annotation (Line(points={{240,2},
          {238,2},{238,60},{168,60}}, color={0,127,255}));
end Exe6FloorHeatingOnOffThermostat;
