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
  end BaseClases;

  package Solutions "Package with cotrollers implemented"

  end Solutions;

  package Exercises "Package with all exercises"
    model Exe1BuildingEnvelope
      "Building envelope model with two zones and office occupancy"
      extends IDEAS.Examples.Tutorial.Example5(
        rectangularZoneTemplate(redeclare BaseClases.Comfort
                                                  comfort(setCoo=occupancy.setCoo,
                                                          setHea=occupancy.setHea),
                                redeclare BaseClases.Occupancy
                                                    occNum(k=occupancy.k),
          l=sqrt(occupancy.A),
          w=sqrt(occupancy.A),
          AZone=occupancy.A),
        rectangularZoneTemplate1(redeclare BaseClases.Comfort
                                                   comfort(setCoo=occupancy.setCoo,
                                                           setHea=occupancy.setHea),
                                 redeclare BaseClases.Occupancy
                                                     occNum(k=occupancy.k),
          AZone=occupancy.A))
      annotation (
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

      BaseClases.Occupancy occupancy(
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
          OutputFlatModelica=false));
    end Exe1BuildingEnvelope;

    model Exe2OnOffThermostat
      "Building control with an on-off thermostat to control the pump"
      extends Exe1BuildingEnvelope;
      package MediumWater = IDEAS.Media.Water "Water Medium";
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2
                                                     rad(
        redeclare package Medium = MediumWater,
        Q_flow_nominal=500,
        T_a_nominal=318.15,
        T_b_nominal=308.15,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                            "Radiator for zone 1" annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={50,-10})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2
                                                     rad1(
        redeclare package Medium = MediumWater,
        Q_flow_nominal=500,
        T_a_nominal=318.15,
        T_b_nominal=308.15,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                            "Radiator for zone 2" annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={90,-10})));
      IDEAS.Fluid.Movers.FlowControlled_dp pumEmi(
        dp_nominal=20000,
        inputType=IDEAS.Fluid.Types.InputType.Constant,
        m_flow_nominal=rad.m_flow_nominal + rad1.m_flow_nominal,
        redeclare package Medium = MediumWater,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
        "Circulation pump for the emission system"
        annotation (Placement(transformation(extent={{120,50},{100,70}})));
      IDEAS.Fluid.Sensors.TemperatureTwoPort senTemSup(redeclare package Medium
          = MediumWater, m_flow_nominal=pumEmi.m_flow_nominal)
        "Supply water temperature sensor"
        annotation (Placement(transformation(extent={{146,70},{126,50}})));
      IDEAS.Fluid.HeatExchangers.Heater_T
                                    boi(
        redeclare package Medium = MediumWater,
        m_flow_nominal=pumEmi.m_flow_nominal,
        dp_nominal=0) "Ideal heating boiler"
        annotation (Placement(transformation(extent={{180,-10},{160,10}})));
      IDEAS.Fluid.Sources.Boundary_pT
                                bou(nPorts=1, redeclare package Medium =
            MediumWater)
        "Absolute pressure boundary"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={110,90})));
    equation
      connect(rad.heatPortCon, rectangularZoneTemplate.gainCon) annotation (Line(
            points={{42.8,-8},{20,-8},{20,27},{10,27}}, color={191,0,0}));
      connect(rad.heatPortRad, rectangularZoneTemplate.gainRad) annotation (Line(
            points={{42.8,-12},{16,-12},{16,24},{10,24}}, color={191,0,0}));
      connect(rad1.heatPortCon, rectangularZoneTemplate1.gainCon) annotation (Line(
            points={{82.8,-8},{66,-8},{66,-33},{10,-33}}, color={191,0,0}));
      connect(rad1.heatPortRad, rectangularZoneTemplate1.gainRad) annotation (Line(
            points={{82.8,-12},{70,-12},{70,-36},{10,-36}}, color={191,0,0}));
      connect(senTemSup.port_b, pumEmi.port_a)
        annotation (Line(points={{126,60},{120,60}}, color={0,127,255}));
      connect(senTemSup.port_a,boi. port_b) annotation (Line(points={{146,60},{
              160,60},{160,0}}, color={0,127,255}));
      connect(boi.port_a,rad1. port_b) annotation (Line(points={{180,0},{180,
              -20},{90,-20}}, color={0,127,255}));
      connect(rad1.port_a, pumEmi.port_b) annotation (Line(points={{90,0},{92,0},{92,
              60},{100,60}}, color={0,127,255}));
      connect(rad.port_a, pumEmi.port_b)
        annotation (Line(points={{50,0},{50,60},{100,60}}, color={0,127,255}));
      connect(boi.port_a, rad.port_b) annotation (Line(points={{180,0},{180,-26},
              {50,-26},{50,-20}}, color={0,127,255}));
      connect(pumEmi.port_a, bou.ports[1]) annotation (Line(points={{120,60},{
              120,76},{110,76},{110,80}}, color={0,127,255}));
      annotation (Diagram(coordinateSystem(extent={{-100,-100},{240,100}}),
            graphics={                     Text(
              extent={{138,98},{224,90}},
              lineColor={28,108,200},
              textString="This sets the absolute pressure only"), Line(points={{126,
                  86},{134,92}}, color={28,108,200})}), Icon(coordinateSystem(
              extent={{-100,-100},{240,100}})));
    end Exe2OnOffThermostat;
  end Exercises;
  annotation (uses(IDEAS(version="2.0.0"), Modelica(version="3.2.2"),
      Buildings(version="6.0.0")));
end TheSysConExe;
