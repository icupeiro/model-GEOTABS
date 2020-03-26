within TheSysConExe.GEOTABS.BaseClasses.Mode;
model ModeSelector
  // -1 cooling, 0 rest, 1 heating
  Modelica.Blocks.Interfaces.RealInput thre
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=cooSwi)
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=heaSwi)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput heat
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.BooleanOutput rest
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput cool
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Components.Step restWait(
    use_activePort=true,
    nOut=1,
    nIn=4,
    initialStep=false)
           annotation (Placement(transformation(extent={{52,16},{60,24}})));
  Components.Step restDecide(
    initialStep=false,
    use_activePort=false,
    nIn=1,
    nOut=3) annotation (Placement(transformation(extent={{52,-14},{60,-6}})));
  Components.Transition T1(delayedTransition=true, waitTime=waitTime)
    annotation (Placement(transformation(extent={{52,2},{60,10}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       heaSwi)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        cooSwi)
    annotation (Placement(transformation(extent={{-50,-28},{-30,-8}})));
  Components.Transition T3(use_conditionPort=true)
    annotation (Placement(transformation(extent={{16,64},{24,56}})));
  Components.Transition T2(use_conditionPort=true)
    annotation (Placement(transformation(extent={{36,12},{44,4}})));
  Components.Transition T4(use_conditionPort=true)
    annotation (Placement(transformation(extent={{52,-38},{60,-30}})));
  Components.Step coolWait(
    use_activePort=true,
    nOut=1,
    initialStep=false,
    nIn=3) annotation (Placement(transformation(extent={{52,-56},{60,-48}})));
  Components.Step coolDecide(
    initialStep=false,
    use_activePort=false,
    nIn=1,
    nOut=2) annotation (Placement(transformation(extent={{52,-88},{60,-80}})));
  Components.Transition T5(delayedTransition=true, waitTime=waitTime)
    annotation (Placement(transformation(extent={{52,-70},{60,-62}})));
  Components.Step heatWait(
    use_activePort=true,
    nOut=1,
    initialStep=false,
    nIn=3) annotation (Placement(transformation(extent={{52,76},{60,84}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-14,-2},{6,18}})));
  Components.Step heatDecide(
    initialStep=false,
    use_activePort=false,
    nIn=1,
    nOut=2) annotation (Placement(transformation(extent={{52,46},{60,54}})));
  Components.Transition T6(delayedTransition=true, waitTime=waitTime)
    annotation (Placement(transformation(extent={{52,64},{60,72}})));
  Components.Transition T7(use_conditionPort=true)
    annotation (Placement(transformation(extent={{52,34},{60,42}})));
  Components.Transition T8(use_conditionPort=true)
    annotation (Placement(transformation(extent={{16,-66},{24,-74}})));
  Components.Transition T9(use_conditionPort=true)
    annotation (Placement(transformation(extent={{36,-56},{44,-64}})));
  Components.Transition T10(use_conditionPort=true)
    annotation (Placement(transformation(extent={{36,72},{44,64}})));

  Components.Step ini(
    initialStep=true,
    nOut=1,
    use_activePort=true)
    annotation (Placement(transformation(extent={{70,34},{78,42}})));
  Components.Transition T11(
                           delayedTransition=true, waitTime=waitTime)
    annotation (Placement(transformation(extent={{88,20},{96,28}})));

  Components.Step iniDecide(
    nOut=3,
    use_activePort=false,
    nIn=1,
    initialStep=false)
    annotation (Placement(transformation(extent={{88,4},{96,12}})));
  Components.Transition T12(
                           use_conditionPort=true)
    annotation (Placement(transformation(extent={{78,-8},{86,-16}})));
  Components.Transition T13(
                           use_conditionPort=true)
    annotation (Placement(transformation(extent={{92,-26},{100,-18}})));
  Components.Transition T14(
                           use_conditionPort=true)
    annotation (Placement(transformation(extent={{84,66},{92,58}})));
  Modelica.Blocks.Logical.Or  and2
    annotation (Placement(transformation(extent={{86,32},{98,44}})));
  parameter Real heaSwi=273.15 + 10 "Comparison with respect to threshold";
  parameter Real cooSwi=273.15 + 14 "Comparison with respect to threshold";
  parameter Modelica.SIunits.Time waitTime=86400
    "Wait time before transition fires (> 0 required)";
equation

  connect(restWait.outPort[1], T1.inPort)
    annotation (Line(points={{56,15.4},{56,12.7},{56,10}}, color={0,0,0}));
  connect(T1.outPort, restDecide.inPort[1])
    annotation (Line(points={{56,1},{56,-2},{56,-6}},
                                              color={0,0,0}));
  connect(restDecide.outPort[1], T4.inPort) annotation (Line(points={{54.6667,
          -14.6},{54.6667,-22},{56,-22},{56,-30}},
                                            color={0,0,0}));
  connect(coolWait.activePort, cool) annotation (Line(points={{60.72,-52},{60.72,
          -56},{92,-56},{92,-50},{110,-50}}, color={255,0,255}));
  connect(T4.outPort, coolWait.inPort[1])
    annotation (Line(points={{56,-39},{56,-48},{54.6667,-48}},
                                                          color={0,0,0}));
  connect(coolWait.outPort[1], T5.inPort)
    annotation (Line(points={{56,-56.6},{56,-59.3},{56,-62}}, color={0,0,0}));
  connect(T5.outPort, coolDecide.inPort[1])
    annotation (Line(points={{56,-71},{56,-75.5},{56,-80}}, color={0,0,0}));
  connect(greaterEqualThreshold.u, lessThreshold.u) annotation (Line(points={{-52,
          20},{-62,20},{-62,60},{-52,60}}, color={0,0,127}));
  connect(lessEqualThreshold.u, greaterThreshold.u) annotation (Line(points={{-52,
          -18},{-62,-18},{-62,-60},{-52,-60}}, color={0,0,127}));
  connect(greaterThreshold.y, T4.conditionPort) annotation (Line(points={{-29,-60},
          {10,-60},{10,-34},{51,-34}}, color={255,0,255}));
  connect(restDecide.outPort[2], T3.inPort) annotation (Line(points={{56,-14.6},
          {54,-14.6},{54,-20},{20,-20},{20,18},{20,38},{20,56}}, color={0,0,0}));
  connect(lessThreshold.y, T3.conditionPort)
    annotation (Line(points={{-29,60},{15,60}}, color={255,0,255}));
  connect(heatWait.activePort, heat) annotation (Line(points={{60.72,80},{80,80},
          {80,50},{110,50}}, color={255,0,255}));
  connect(T3.outPort, heatWait.inPort[1]) annotation (Line(points={{20,65},{20,
          66},{20,96},{54.6667,96},{54.6667,84}},   color={0,0,0}));
  connect(restDecide.outPort[3], T2.inPort) annotation (Line(points={{57.3333,
          -14.6},{50,-14.6},{50,-16},{40,-16},{40,4}},
                                                color={0,0,0}));
  connect(T2.outPort, restWait.inPort[1]) annotation (Line(points={{40,13},{
          40,30},{54.5,30},{54.5,24}},color={0,0,0}));
  connect(and1.y, T2.conditionPort)
    annotation (Line(points={{7,8},{22,8},{35,8}}, color={255,0,255}));
  connect(heatWait.outPort[1], T6.inPort)
    annotation (Line(points={{56,75.4},{56,73.7},{56,72}}, color={0,0,0}));
  connect(T6.outPort, heatDecide.inPort[1])
    annotation (Line(points={{56,63},{56,58.5},{56,54}}, color={0,0,0}));
  connect(heatDecide.outPort[1], T7.inPort)
    annotation (Line(points={{55,45.4},{56,43.7},{56,42}}, color={0,0,0}));
  connect(T7.outPort, restWait.inPort[2])
    annotation (Line(points={{56,33},{56,24},{55.5,24}},       color={0,0,0}));
  connect(greaterEqualThreshold.y, T7.conditionPort) annotation (Line(points={{-29,
          20},{-16,20},{-16,38},{51,38}}, color={255,0,255}));
  connect(lessEqualThreshold.y, and1.u2)
    annotation (Line(points={{-29,-18},{-16,-18},{-16,0}}, color={255,0,255}));
  connect(greaterEqualThreshold.y, and1.u1) annotation (Line(points={{-29,20},{-24,
          20},{-16,20},{-16,8}}, color={255,0,255}));
  connect(coolDecide.outPort[1], T8.inPort) annotation (Line(points={{55,-88.6},
          {55,-92},{20,-92},{20,-74}}, color={0,0,0}));
  connect(lessEqualThreshold.y, T8.conditionPort) annotation (Line(points={{-29,
          -18},{-24,-18},{-16,-18},{-16,-70},{15,-70}}, color={255,0,255}));
  connect(T8.outPort, restWait.inPort[3]) annotation (Line(points={{20,-65},{
          28,-65},{28,-64},{30,-64},{30,32},{58,32},{58,24},{56.5,24}}, color={0,
          0,0}));
  connect(coolDecide.outPort[2], T9.inPort)
    annotation (Line(points={{57,-88.6},{40,-88.6},{40,-64}}, color={0,0,0}));
  connect(T9.outPort, coolWait.inPort[2]) annotation (Line(points={{40,-55},{
          40,-55},{40,-44},{56,-44},{56,-48}},
                                            color={0,0,0}));
  connect(greaterThreshold.y, T9.conditionPort)
    annotation (Line(points={{-29,-60},{35,-60}}, color={255,0,255}));
  connect(T10.outPort, heatWait.inPort[2]) annotation (Line(points={{40,73},{
          40,73},{40,90},{56,90},{56,84}},
                                        color={0,0,0}));
  connect(heatDecide.outPort[2], T10.inPort) annotation (Line(points={{57,45.4},
          {50,45.4},{50,46},{40,46},{40,64}}, color={0,0,0}));
  connect(lessThreshold.y, T10.conditionPort) annotation (Line(points={{-29,60},
          {2,60},{2,68},{35,68}}, color={255,0,255}));
  connect(ini.outPort[1], T11.inPort)
    annotation (Line(points={{74,33.4},{74,30},{92,30},{92,28}},
                                                 color={0,0,0}));
  connect(T11.outPort, iniDecide.inPort[1])
    annotation (Line(points={{92,19},{92,15.5},{92,12}}, color={0,0,0}));
  connect(iniDecide.outPort[1], T12.inPort) annotation (Line(points={{90.6667,
          3.4},{88,3.4},{88,-16},{82,-16}}, color={0,0,0}));
  connect(T12.outPort, restWait.inPort[4]) annotation (Line(points={{82,-7},{
          80,-7},{80,-4},{80,24},{57.5,24}}, color={0,0,0}));
  connect(and1.y, T12.conditionPort) annotation (Line(points={{7,8},{24,8},{
          24,-2},{78,-2},{44,-2},{44,-12},{77,-12}}, color={255,0,255}));
  connect(iniDecide.outPort[2], T13.inPort) annotation (Line(points={{92,3.4},
          {92,-7.3},{96,-7.3},{96,-18}}, color={0,0,0}));
  connect(T13.outPort, coolWait.inPort[3]) annotation (Line(points={{96,-27},{
          76,-27},{76,-48},{57.3333,-48}},  color={0,0,0}));
  connect(greaterThreshold.y, T13.conditionPort) annotation (Line(points={{
          -29,-60},{10,-60},{10,-22},{91,-22}}, color={255,0,255}));
  connect(iniDecide.outPort[3], T14.inPort) annotation (Line(points={{93.3333,
          3.4},{93.3333,2},{82,2},{82,58},{88,58}}, color={0,0,0}));
  connect(T14.outPort, heatWait.inPort[3]) annotation (Line(points={{88,67},{88,
          68},{88,68},{88,68},{88,94},{57.3333,94},{57.3333,84}},    color={0,
          0,0}));
  connect(T14.conditionPort, lessThreshold.y) annotation (Line(points={{83,62},
          {6,62},{6,60},{-29,60}}, color={255,0,255}));
  connect(and2.y, rest) annotation (Line(points={{98.6,38},{100,38},{100,0},{
          110,0}}, color={255,0,255}));
  connect(ini.activePort, and2.u1) annotation (Line(points={{78.72,38},{84.8,
          38},{84.8,38}}, color={255,0,255}));
  connect(restWait.activePort, and2.u2) annotation (Line(points={{60.72,20},{
          78,20},{78,33.2},{84.8,33.2}}, color={255,0,255}));
  connect(thre, greaterEqualThreshold.u) annotation (Line(points={{-100,0},{-62,
          0},{-62,20},{-52,20}}, color={0,0,127}));
  connect(thre, lessEqualThreshold.u) annotation (Line(points={{-100,0},{-62,0},
          {-62,-18},{-52,-18}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModeSelector;
