within ;
package TheSysConExe "Thermal systems control exercise"

  package BaseClases "Base clases for thermal systems exercise"
    extends Modelica.Icons.BasesPackage;

    model Comfort
      "Computes the discomfort given comfort setpoints and zone temperature"
      extends IDEAS.Buildings.Components.Comfort.BaseClasses.PartialComfort;

      Modelica.Blocks.Logical.Switch switch
        annotation (Placement(transformation(extent={{48,50},{68,70}})));
      Modelica.Blocks.Continuous.Integrator integrator(k=1/3600)
        "Returns the upper discomfort in K-h"
        annotation (Placement(transformation(extent={{80,50},{100,70}})));
      Modelica.Blocks.Math.MultiSum cooDif(k={1,-1}, nu=2)
        "Difference from cooling setpoint"
        annotation (Placement(transformation(extent={{-20,50},{0,70}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
        annotation (Placement(transformation(extent={{16,50},{36,70}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{10,18},{30,38}})));
      Modelica.Blocks.Interfaces.RealOutput uppDis "Upper discomfort"
        annotation (Placement(transformation(extent={{140,48},{164,72}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{48,-50},{68,-30}})));
      Modelica.Blocks.Continuous.Integrator integrator1(k=1/3600)
        "Returns the lower discomfort in K-h"
        annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
      Modelica.Blocks.Math.MultiSum heaDif(k={-1,1}, nu=2)
        "Difference from heating setpoint"
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=0)
        annotation (Placement(transformation(extent={{16,-50},{36,-30}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{8,-80},{28,-60}})));
      Modelica.Blocks.Interfaces.RealOutput lowDis "Lower discomfort"
        annotation (Placement(transformation(extent={{140,-52},{164,-28}})));
      Modelica.Blocks.Math.MultiSum sumDis(k={1,1}, nu=2)
        "Sum of lower and upper discomfort"
        annotation (Placement(transformation(extent={{110,0},{130,20}})));
      Modelica.Blocks.Interfaces.RealOutput totDis "Total discomfort"
        annotation (Placement(transformation(extent={{140,-2},{164,22}})));
      Modelica.Blocks.Interfaces.RealInput setCoo(
        final quantity="ThermodynamicTemperature",
        final unit="K",
        displayUnit="degC") "Cooling setpoint"
        annotation (Placement(transformation(extent={{-120,-30},{-100,-10}})));
      Modelica.Blocks.Interfaces.RealInput setHea(
        final quantity="ThermodynamicTemperature",
        final unit="K",
        displayUnit="degC") "Heating setpoint"
        annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
    equation

      connect(cooDif.y, greaterThreshold.u)
        annotation (Line(points={{1.7,60},{14,60}},    color={0,0,127}));
      connect(switch.u2, greaterThreshold.y)
        annotation (Line(points={{46,60},{37,60}},color={255,0,255}));
      connect(integrator.u, switch.y)
        annotation (Line(points={{78,60},{69,60}}, color={0,0,127}));
      connect(integrator.y, uppDis)
        annotation (Line(points={{101,60},{152,60}},color={0,0,127}));
      connect(heaDif.y, greaterThreshold1.u)
        annotation (Line(points={{1.7,-40},{14,-40}},    color={0,0,127}));
      connect(switch1.u2, greaterThreshold1.y)
        annotation (Line(points={{46,-40},{37,-40}},color={255,0,255}));
      connect(integrator1.u, switch1.y)
        annotation (Line(points={{78,-40},{69,-40}}, color={0,0,127}));
      connect(integrator1.y, lowDis)
        annotation (Line(points={{101,-40},{152,-40}},color={0,0,127}));
      connect(sumDis.y, totDis)
        annotation (Line(points={{131.7,10},{152,10}},
                                                    color={0,0,127}));
      connect(integrator.y, sumDis.u[1]) annotation (Line(points={{101,60},{104,60},
              {104,13.5},{110,13.5}},
                              color={0,0,127}));
      connect(integrator1.y, sumDis.u[2]) annotation (Line(points={{101,-40},{104,-40},
              {104,6.5},{110,6.5}}, color={0,0,127}));
      connect(heaDif.y, switch1.u1) annotation (Line(points={{1.7,-40},{8,-40},{8,-18},
              {40,-18},{40,-32},{46,-32}},             color={0,0,127}));
      connect(const1.y, switch1.u3) annotation (Line(points={{29,-70},{40,-70},{40,-48},
              {46,-48}},        color={0,0,127}));
      connect(const.y, switch.u3) annotation (Line(points={{31,28},{40,28},{40,52},{
              46,52}}, color={0,0,127}));
      connect(cooDif.y, switch.u1) annotation (Line(points={{1.7,60},{8,60},{8,80},{
              40,80},{40,68},{46,68}},        color={0,0,127}));
      connect(TAir, cooDif.u[1]) annotation (Line(points={{-110,100},{-80,100},
              {-80,63.5},{-20,63.5}},
                                 color={0,0,127}));
      connect(TAir, heaDif.u[1]) annotation (Line(points={{-110,100},{-80,100},
              {-80,-36.5},{-20,-36.5}},
                                   color={0,0,127}));
      connect(setCoo, cooDif.u[2]) annotation (Line(points={{-110,-20},{-60,-20},
              {-60,56.5},{-20,56.5}}, color={0,0,127}));
      connect(setHea, heaDif.u[2]) annotation (Line(points={{-110,-60},{-40,-60},
              {-40,-43.5},{-20,-43.5}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{140,120}})),           Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{140,120}}), graphics={
            Rectangle(
              extent={{-100,120},{100,-100}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255}),
            Rectangle(
              extent={{-94,34},{-26,40}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-30,34},{-24,90}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-30,84},{38,90}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{32,34},{38,90}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{32,34},{76,40}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-94,-34},{-24,-28}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{-30,-34},{-24,22}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{-30,16},{38,22}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{32,-34},{38,22}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{34,-34},{92,-28}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Line(
              points={{-94,-50},{-26,-32},{-12,42},{14,54},{48,-42},{84,-56}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Polygon(
              points={{-94,-34},{-94,-50},{-94,-50},{-88,-48},{-80,-46},{-70,-44},{-56,
                  -40},{-46,-36},{-44,-34},{-94,-34}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-24,-12},{-24,16},{-16,16},{-18,10},{-20,0},{-22,-6},{-24,-12}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{28,16},{32,16},{28,16}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{26,16},{32,16},{32,2},{30,8},{26,16}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{50,-34},{82,-34},{92,-34},{92,-58},{84,-56},{64,-48},{58,-44},
                  {52,-38},{50,-34}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<ul>
<li></li>
</ul>
</html>"));
    end Comfort;

    model Occupancy "Occupancy schedule"
      extends IDEAS.Buildings.Components.Occupants.BaseClasses.PartialOccupants(final useInput=false);

      parameter Modelica.SIunits.Temperature setHeaOcc=21+273.15
          "Heating setpoint when occupied";
      parameter Modelica.SIunits.Temperature setHeaUno=18+273.15
          "Heating setpoint when unoccupied";

      parameter Modelica.SIunits.Temperature setCooOcc=23+273.15
          "Cooling setpoint when occupied";
      parameter Modelica.SIunits.Temperature setCooUno=26+273.15
          "Cooling setpoint when unoccupied";

      parameter Real k "Number of occupants";
      IDEAS.Utilities.Time.CalendarTime calTim(zerTim=IDEAS.Utilities.Time.Types.ZeroTime.NY2019)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Modelica.Blocks.Sources.RealExpression occ(y=if calTim.weekDay < 6 and (
            calTim.hour > 7 and calTim.hour < 18) then k else 0)
        "Number of occupants present"
        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{72,54},{84,66}})));
      Modelica.Blocks.Sources.Constant setHeaOccCnt(k=setHeaOcc)
        "Heating setpoint when occupied"
        annotation (Placement(transformation(extent={{48,-70},{56,-62}})));
      Modelica.Blocks.Sources.Constant setHeaUnoCnt(k=setHeaUno)
        "Heating setpoint when unoccupied"
        annotation (Placement(transformation(extent={{48,-96},{56,-88}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{72,-86},{84,-74}})));
      Modelica.Blocks.Sources.Constant setCooOccCnt(k=setCooOcc)
        "Cooling setpoint when occupied"
        annotation (Placement(transformation(extent={{46,68},{54,76}})));
      Modelica.Blocks.Sources.Constant setCooUnoCnt(k=setCooUno)
        "Cooling setpoint when unoccupied"
        annotation (Placement(transformation(extent={{46,44},{54,52}})));
      Modelica.Blocks.Interfaces.RealOutput setHea(
        final quantity="ThermodynamicTemperature",
        final unit="K",
        displayUnit="degC") "Heating setpoint"
        annotation (Placement(transformation(extent={{100,-100},{140,-60}}),
            iconTransformation(extent={{100,-80},{140,-40}})));
      Modelica.Blocks.Interfaces.RealOutput setCoo(
        final quantity="ThermodynamicTemperature",
        final unit="K",
        displayUnit="degC") "Cooling setpoint"
        annotation (Placement(transformation(extent={{100,40},{140,80}}),
            iconTransformation(extent={{100,40},{140,80}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
        annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
    equation
      connect(occ.y, nOcc)
        annotation (Line(points={{1,0},{120,0}}, color={0,0,127}));
      connect(setCooOccCnt.y, switch1.u1) annotation (Line(points={{54.4,72},{62,72},
              {62,64.8},{70.8,64.8}}, color={0,0,127}));
      connect(setCooUnoCnt.y, switch1.u3) annotation (Line(points={{54.4,48},{62,48},
              {62,55.2},{70.8,55.2}}, color={0,0,127}));
      connect(setHeaUnoCnt.y, switch2.u3) annotation (Line(points={{56.4,-92},{64,-92},
              {64,-84.8},{70.8,-84.8}}, color={0,0,127}));
      connect(setHeaOccCnt.y, switch2.u1) annotation (Line(points={{56.4,-66},{64,-66},
              {64,-75.2},{70.8,-75.2}}, color={0,0,127}));
      connect(occ.y, greaterThreshold.u) annotation (Line(points={{1,0},{20,0},
              {20,-20},{-80,-20},{-80,-80},{-62,-80}}, color={0,0,127}));
      connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{-39,-80},
              {28,-80},{28,60},{70.8,60}}, color={255,0,255}));
      connect(greaterThreshold.y, switch2.u2)
        annotation (Line(points={{-39,-80},{70.8,-80}}, color={255,0,255}));
      connect(switch1.y,setCoo)
        annotation (Line(points={{84.6,60},{120,60}}, color={0,0,127}));
      connect(switch2.y,setHea)
        annotation (Line(points={{84.6,-80},{120,-80}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-94,34},{-26,40}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-30,34},{-24,90}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-30,84},{32,90}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{32,34},{38,90}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{32,34},{76,40}},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-94,-34},{-24,-28}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{-30,-34},{-24,22}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{-30,16},{32,22}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{32,-34},{38,22}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Rectangle(
              extent={{34,-34},{76,-28}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0})}),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));
    end Occupancy;

    partial model envBoiPumRad "Envelope boiler pump and radiators"
      extends Exercises.Exe1BuildingEnvelope(occ(
          setHeaOcc=21 + 273.15,
          setHeaUno=21 + 273.15,
          setCooOcc=23 + 273.15,
          setCooUno=23 + 273.15));
      package MediumWater = IDEAS.Media.Water "Water Medium";
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radNor(
        redeclare package Medium = MediumWater,
        Q_flow_nominal=1000,
        T_a_nominal=333.15,
        T_b_nominal=323.15,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
        "Radiator for north zone" annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={50,-10})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radSou(
        redeclare package Medium = MediumWater,
        Q_flow_nominal=1000,
        T_a_nominal=333.15,
        T_b_nominal=323.15,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
        "Radiator for south zone" annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,-10})));
      IDEAS.Fluid.Movers.FlowControlled_dp pum(
        dp_nominal=20000,
        inputType=IDEAS.Fluid.Types.InputType.Constant,
        m_flow_nominal=radNor.m_flow_nominal + radSou.m_flow_nominal,
        redeclare package Medium = MediumWater,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
        "Circulation pump at secondary side"
        annotation (Placement(transformation(extent={{140,50},{120,70}})));
      IDEAS.Fluid.Sensors.TemperatureTwoPort senTemSup(redeclare package Medium =
            MediumWater, m_flow_nominal=pum.m_flow_nominal)
        "Supply water temperature sensor"
        annotation (Placement(transformation(extent={{168,70},{148,50}})));
      IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
            MediumWater) "Expansion vessel" annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={110,82})));
      IDEAS.Fluid.HeatExchangers.Heater_T boi(
        redeclare package Medium = MediumWater,
        m_flow_nominal=pum.m_flow_nominal,
        dp_nominal=10000) "Ideal boiler with prescribed supply temperature"
        annotation (Placement(transformation(extent={{220,10},{200,30}})));
      Modelica.Blocks.Continuous.Integrator Ene(k=1/3600000)
        "Electrical energy meter with conversion to kWh"
        annotation (Placement(transformation(extent={{220,72},{240,92}})));
      IDEAS.Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = MediumWater,
        m_flow_nominal={radNor.m_flow_nominal,-radNor.m_flow_nominal - radSou.m_flow_nominal,
            -radSou.m_flow_nominal},
        portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
        portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
        portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
        dp_nominal={500,0,500}) "Junction"
        annotation (Placement(transformation(extent={{80,-40},{100,-60}})));
      IDEAS.Fluid.FixedResistances.Junction jun(
        redeclare package Medium = MediumWater,
        m_flow_nominal={radNor.m_flow_nominal + radSou.m_flow_nominal,-radNor.m_flow_nominal,
            -radSou.m_flow_nominal},
        portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
        portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
        portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
        dp_nominal={1000,0,0}) "Junction"
        annotation (Placement(transformation(extent={{100,50},{80,70}})));
    equation
      connect(radNor.heatPortCon, rectangularZoneTemplate.gainCon) annotation (
          Line(points={{42.8,-8},{20,-8},{20,27},{10,27}}, color={191,0,0}));
      connect(radNor.heatPortRad, rectangularZoneTemplate.gainRad) annotation (
          Line(points={{42.8,-12},{16,-12},{16,24},{10,24}}, color={191,0,0}));
      connect(radSou.heatPortCon, rectangularZoneTemplate1.gainCon) annotation (
         Line(points={{82.8,-8},{66,-8},{66,-33},{10,-33}}, color={191,0,0}));
      connect(radSou.heatPortRad, rectangularZoneTemplate1.gainRad) annotation (
         Line(points={{82.8,-12},{70,-12},{70,-36},{10,-36}}, color={191,0,0}));
      connect(bou.ports[1], pum.port_b) annotation (Line(points={{110,72},{110,
              60},{120,60}}, color={0,127,255}));
      connect(senTemSup.port_b, pum.port_a)
        annotation (Line(points={{148,60},{140,60}}, color={0,127,255}));
      connect(boi.port_b, senTemSup.port_a) annotation (Line(points={{200,20},{
              180,20},{180,60},{168,60}}, color={0,127,255}));
      connect(boi.Q_flow, Ene.u) annotation (Line(points={{199,28},{192,28},{
              192,82},{218,82}}, color={0,0,127}));
      connect(radNor.port_b, jun1.port_1) annotation (Line(points={{50,-20},{50,
              -50},{80,-50}}, color={0,127,255}));
      connect(radSou.port_b, jun1.port_3)
        annotation (Line(points={{90,-20},{90,-40}}, color={0,127,255}));
      connect(jun1.port_2, boi.port_a) annotation (Line(points={{100,-50},{220,
              -50},{220,20}}, color={0,127,255}));
      connect(pum.port_b, jun.port_1)
        annotation (Line(points={{120,60},{100,60}}, color={0,127,255}));
      annotation (Diagram(coordinateSystem(extent={{-100,-100},{260,100}})),
                                                        Icon(coordinateSystem(
              extent={{-100,-100},{260,100}})),
        experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false));
    end envBoiPumRad;
  end BaseClases;

  package Solutions "Package with cotrollers implemented"

    model Sol2OnOffThermostat
      "Solution of exercise 2 for building control with on-off thermostat for the pump"
      extends Exercises.Exe2OnOffThermostat(pum(inputType=IDEAS.Fluid.Types.InputType.Stages));
      Modelica.Blocks.Math.BooleanToInteger booToInt
        "Convert boolean signal into integer "
        annotation (Placement(transformation(extent={{42,70},{62,90}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{-42,70},{-22,90}})));
      Modelica.Blocks.Sources.Constant OffSet(k=1)
        "Offset from heating set point"
        annotation (Placement(transformation(extent={{-74,92},{-54,112}})));
    protected
      Modelica.Blocks.Logical.OnOffController onOffCon(bandwidth=1)
        "On off controller for switching on and off the pump of the emission system according to zone temperature readings"
        annotation (Placement(transformation(extent={{0,70},{20,90}})));
    equation
      connect(booToInt.y, pum.stage) annotation (Line(points={{63,80},{80,80},{
              80,98},{130,98},{130,72}}, color={255,127,0}));
      connect(onOffCon.y, booToInt.u)
        annotation (Line(points={{21,80},{40,80}}, color={255,0,255}));
      connect(rectangularZoneTemplate1.TSensor, onOffCon.u) annotation (Line(
            points={{11,-28},{14,-28},{14,-6},{-20,-6},{-20,74},{-2,74}}, color=
             {0,0,127}));
      connect(add.y, onOffCon.reference) annotation (Line(points={{-21,80},{-12,
              80},{-12,86},{-2,86}}, color={0,0,127}));
      connect(occ.setHea, add.u2) annotation (Line(points={{-58,44},{-52,44},{
              -52,74},{-44,74}}, color={0,0,127}));
      connect(add.u1, OffSet.y) annotation (Line(points={{-44,86},{-48,86},{-48,
              102},{-53,102}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(extent={{-100,-100},{260,120}})),
          Icon(coordinateSystem(extent={{-100,-100},{260,120}})));
    end Sol2OnOffThermostat;

    model Sol3ThermostaticValves
      "Solution of exercise 3 for building control with thermostatic valves"
      extends Exercises.Exe3ThermostaticValves(valNor(P=0.2), valSou(P=0.2));
    end Sol3ThermostaticValves;

    model Sol4HeatingCurveDerivation
      "Solution of the exercise on the derivation of the building heating curve"
      extends Exercises.Exe4HeatingCurveDerivation(conPID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=100,
          Ti=600,
          yMax=273.15 + 60,
          yMin=273.15 + 20,
          initType=Modelica.Blocks.Types.InitPID.InitialState));
      Modelica.Blocks.Continuous.Filter lowPasFilTe(
        analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
        filterType=Modelica.Blocks.Types.FilterType.LowPass,
        f_cut=1/(24*3600)) "Low pass filter for the outdoor temperature"
        annotation (Placement(transformation(extent={{0,60},{20,80}})));
      Modelica.Blocks.Continuous.Filter lowPasFilSup(
        analogFilter=Modelica.Blocks.Types.AnalogFilter.Butterworth,
        filterType=Modelica.Blocks.Types.FilterType.LowPass,
        f_cut=1/(24*3600)) "Low pass filter for the supply temperature"
        annotation (Placement(transformation(extent={{150,-10},{170,10}})));
    protected
      IDEAS.BoundaryConditions.WeatherData.Bus weaDatBus
        "Weather data bus connectable to weaBus connector from Buildings Library"
        annotation (Placement(transformation(extent={{-62,72},{-42,92}})));
    equation
      connect(sim.weaDatBus, weaDatBus) annotation (Line(
          points={{-80.1,90},{-68,90},{-68,82},{-52,82}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(weaDatBus.TDryBul, lowPasFilTe.u) annotation (Line(
          points={{-52,82},{-38,82},{-38,70},{-2,70}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(senTemSup.T, lowPasFilSup.u) annotation (Line(points={{158,49},{
              158,28},{134,28},{134,0},{148,0}}, color={0,0,127}));
      annotation (
        experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),

          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false));
    end Sol4HeatingCurveDerivation;
  end Solutions;

  package Exercises "Package with all exercises"
    model Exe1BuildingEnvelope
      "Building envelope model with two zones and office occupancy"
      extends IDEAS.Examples.Tutorial.Example5(rectangularZoneTemplate(
          redeclare BaseClases.Comfort comfort(setCoo=occ.setCoo, setHea=occ.setHea),
          redeclare BaseClases.Occupancy occNum(k=occ.k),
          l=sqrt(occ.A),
          w=sqrt(occ.A),
          AZone=occ.A), rectangularZoneTemplate1(
          redeclare BaseClases.Comfort comfort(setCoo=occ.setCoo, setHea=occ.setHea),
          redeclare BaseClases.Occupancy occNum(k=occ.k),
          l=sqrt(occ.A),
          w=sqrt(occ.A),
          AZone=occ.A)) annotation (
        experiment(
          StartTime=10000000,
          StopTime=11000000,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false));

      BaseClases.Occupancy occ(
        linearise=false,
        A=50,
        k=5)
        "Occupancy schedule and setpoints for each of the zones in the building"
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

      annotation (
        experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false),
        Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
        Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
    end Exe1BuildingEnvelope;

    model Exe2OnOffThermostat
      "Building control by switching emission system on and off"
      extends BaseClases.envBoiPumRad;
      Modelica.Blocks.Sources.Constant const(k=60 + 273.15)
        annotation (Placement(transformation(extent={{220,40},{240,60}})));
    equation
      connect(jun.port_3, radSou.port_a)
        annotation (Line(points={{90,50},{90,0}}, color={0,127,255}));
      connect(jun.port_2, radNor.port_a)
        annotation (Line(points={{80,60},{50,60},{50,0}}, color={0,127,255}));
      connect(const.y, boi.TSet) annotation (Line(points={{241,50},{256,50},{
              256,28},{222,28}}, color={0,0,127}));
      annotation (
        experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false));
    end Exe2OnOffThermostat;

    model Exe3ThermostaticValves "Building control through thermostatic valves"
      extends BaseClases.envBoiPumRad;
      IDEAS.Fluid.Actuators.Valves.TwoWayTRV valNor(
        m_flow_nominal=radNor.m_flow_nominal,
        dpValve_nominal=20000,
        redeclare package Medium = MediumWater)
        "Thermostatic valve for north zone" annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={50,30})));
      IDEAS.Fluid.Actuators.Valves.TwoWayTRV valSou(
        dpValve_nominal=20000,
        m_flow_nominal=radSou.m_flow_nominal,
        redeclare package Medium = MediumWater)
        "Thermostatic valve for south zone" annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,30})));
      Modelica.Blocks.Sources.Constant const(k=60 + 273.15)
        annotation (Placement(transformation(extent={{220,40},{240,60}})));
    equation
      connect(valNor.port_b, radNor.port_a)
        annotation (Line(points={{50,20},{50,0}}, color={0,127,255}));
      connect(valSou.port_b, radSou.port_a)
        annotation (Line(points={{90,20},{90,0}}, color={0,127,255}));
      connect(rectangularZoneTemplate.TSensor, valNor.T) annotation (Line(
            points={{11,32},{26,32},{26,30},{39.4,30}}, color={0,0,127}));
      connect(rectangularZoneTemplate1.TSensor, valSou.T) annotation (Line(
            points={{11,-28},{32,-28},{32,12},{79.4,12},{79.4,30}}, color={0,0,
              127}));
      connect(jun.port_3, valSou.port_a)
        annotation (Line(points={{90,50},{90,40}}, color={0,127,255}));
      connect(jun.port_2, valNor.port_a)
        annotation (Line(points={{80,60},{50,60},{50,40}}, color={0,127,255}));
      connect(const.y, boi.TSet) annotation (Line(points={{241,50},{256,50},{
              256,28},{222,28}}, color={0,0,127}));
    end Exe3ThermostaticValves;

    model Exe4HeatingCurveDerivation "Derivation of the building heating curve"
      extends BaseClases.envBoiPumRad;
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

    model Exe5HeatingCurveImplementation
      "Implementation of the heating curve derived in the previous exercise"
      extends BaseClases.envBoiPumRad;
      IDEAS.Fluid.Actuators.Valves.TwoWayTRV valNor(
        m_flow_nominal=radNor.m_flow_nominal,
        dpValve_nominal=20000,
        redeclare package Medium = MediumWater)
        "Thermostatic valve for north zone" annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={50,30})));
      IDEAS.Fluid.Actuators.Valves.TwoWayTRV valSou(
        dpValve_nominal=20000,
        m_flow_nominal=radSou.m_flow_nominal,
        redeclare package Medium = MediumWater)
        "Thermostatic valve for south zone" annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,30})));
    equation
      connect(valNor.port_b, radNor.port_a)
        annotation (Line(points={{50,20},{50,0}}, color={0,127,255}));
      connect(valSou.port_b, radSou.port_a)
        annotation (Line(points={{90,20},{90,0}}, color={0,127,255}));
      connect(rectangularZoneTemplate.TSensor,valNor. T) annotation (Line(
            points={{11,32},{26,32},{26,30},{39.4,30}}, color={0,0,127}));
      connect(rectangularZoneTemplate1.TSensor,valSou. T) annotation (Line(
            points={{11,-28},{32,-28},{32,12},{79.4,12},{79.4,30}}, color={0,0,
              127}));
      connect(jun.port_3,valSou. port_a)
        annotation (Line(points={{90,50},{90,40}}, color={0,127,255}));
      connect(jun.port_2,valNor. port_a)
        annotation (Line(points={{80,60},{50,60},{50,40}}, color={0,127,255}));
    end Exe5HeatingCurveImplementation;
  end Exercises;
  annotation (uses(IDEAS(version="2.0.0"), Modelica(version="3.2.2")));
end TheSysConExe;
