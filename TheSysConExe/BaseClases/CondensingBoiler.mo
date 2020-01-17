within TheSysConExe.BaseClases;
model CondensingBoiler
  "Condensing Boiler with prescribed outlet temperature and efficiency data"
  extends IDEAS.Fluid.HeatExchangers.Heater_T;
  Modelica.Blocks.Tables.CombiTable1D effTab(table=[303.463,1.06418; 305.338,1.0609;
        306.223,1.05939; 307.16,1.05763; 308.358,1.05611; 309.921,1.05359; 310.702,
        1.05183; 311.588,1.04981; 312.369,1.04754; 313.098,1.04528; 313.827,1.0425;
        314.556,1.03973; 315.025,1.03771; 315.546,1.03544; 316.067,1.03318; 316.535,
        1.03091; 317.473,1.02612; 317.942,1.02385; 318.463,1.02133; 319.296,1.01704;
        320.181,1.01301; 320.806,1.01024; 321.379,1.00797; 322.004,1.0057; 322.629,
        1.00318; 323.254,1.00116; 324.088,0.99864; 324.713,0.99663; 325.442,0.99461;
        326.275,0.99284; 327.056,0.99158; 327.733,0.98982; 328.567,0.98881; 329.348,
        0.98755; 330.077,0.98654; 331.431,0.98402; 332.317,0.98201; 333.046,0.981],
      columns={2})
    "Condensing boiler efficiency curve as a function of return temperature"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Blocks.Interfaces.RealOutput Q_real(unit="W")
    "Actual thermal power of the condensing boiler"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  IDEAS.Fluid.Sensors.Temperature senTemRet(redeclare package Medium = Medium)
    "Return temperature sensor"
    annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
equation
  connect(outCon.Q_flow, product.u1) annotation (Line(points={{41,8},{48,8},{48,
          -24},{58,-24}}, color={0,0,127}));
  connect(effTab.y[1], product.u2) annotation (Line(points={{41,-60},{48,-60},{
          48,-36},{58,-36}}, color={0,0,127}));
  connect(product.y, Q_real) annotation (Line(points={{81,-30},{90,-30},{90,-80},
          {110,-80}}, color={0,0,127}));
  connect(effTab.u[1], senTemRet.T)
    annotation (Line(points={{18,-60},{-53,-60}}, color={0,0,127}));
  connect(senTemRet.port, preDro.port_a) annotation (Line(points={{-60,-70},{
          -60,-80},{-80,-80},{-80,0},{-50,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-44,-42},{-64,-42},{-64,54},{62,54},{62,-42},{42,-42},{42,
              -52}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{28,-50}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{28,-52},{28,-42},{-2,-42}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{6,-42},{6,24}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-42,-54},{-36,-42},{-30,-54},{-26,-42},{-20,-54},{-16,-42},{-10,
              -54},{-6,-42},{0,-52}},
          color={0,0,0},
          thickness=1),
        Rectangle(
          extent={{-42,-10},{-4,-36}},
          lineColor={238,46,47},
          lineThickness=1,
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,-12},{50,-38}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{66,-78},{100,-82}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{66,-82},{70,-60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{28,-80},{96,-104}},
          lineColor={0,0,127},
          textString="Q_real")}),           Diagram(coordinateSystem(
          preserveAspectRatio=false)));

end CondensingBoiler;
