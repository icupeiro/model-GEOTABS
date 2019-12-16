within ;
package TheSysConExe "Thermal systems control exercise"

  package BaseClases "Base clases for thermal systems exercise"
    model SimpleBuilding
      "Single zone residential hydronic simple building with calculation of KPIs"
      package Medium = IDEAS.Media.Water;
      IDEAS.Buildings.Validation.Cases.Case900Template case900Template
        "Case 900 BESTEST model"
        annotation (Placement(transformation(extent={{102,18},{78,42}})));
      inner IDEAS.BoundaryConditions.SimInfoManager sim
        "Simulation information manager for climate data"
        annotation (Placement(transformation(extent={{-120,100},{-100,120}})));

      Modelica.Blocks.Interfaces.RealOutput Tzon "Zone operative temperature"
        annotation (Placement(transformation(extent={{120,70},{140,90}})));
      Setpoints setpoints
        annotation (Placement(transformation(extent={{-80,100},{-62,118}})));
      ComputeDiscomfort computeDiscomfort
        annotation (Placement(transformation(extent={{72,100.909},{90,118}})));
      Modelica.Blocks.Interfaces.RealOutput discomfort "Thermal discomfort"
        annotation (Placement(transformation(extent={{120,90},{140,110}})));
      Modelica.Blocks.Interfaces.RealOutput energy "Total energy usage"
        annotation (Placement(transformation(extent={{120,-90},{140,-70}})));
      Modelica.Blocks.Math.MultiSum multiSum
        annotation (Placement(transformation(extent={{86,-90},{106,-70}})));
    equation
      connect(case900Template.TSensor,Tzon);
      connect(case900Template.TSensor,Tzon)  annotation (Line(points={{76.8,32.4},{65,
              32.4},{65,80},{130,80}}, color={0,0,127}));
      connect(case900Template.TSensor, computeDiscomfort.TZon) annotation (Line(
            points={{76.8,32.4},{41.6,32.4},{41.6,108.678},{72,108.678}}, color={0,0,
              127}));
      connect(computeDiscomfort.totDis, discomfort) annotation (Line(points={{91.62,
              108.678},{106,108.678},{106,100},{130,100}},       color={0,0,127}));
      connect(setpoints.CooSet, computeDiscomfort.cooSet) annotation (Line(points={{-61.1,
              114.236},{11.55,114.236},{11.55,114.116},{72,114.116}},     color={0,0,
              127}));
      connect(setpoints.HeaSet, computeDiscomfort.heaSet) annotation (Line(points={{-61.1,
              103.273},{11.55,103.273},{11.55,103.24},{72,103.24}},         color={0,
              0,127}));
      connect(multiSum.y, energy)
        annotation (Line(points={{107.7,-80},{130,-80}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},
                {120,120}}), graphics={
            Rectangle(
              extent={{-120,120},{120,-120}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={191,0,0}),
            Polygon(
              points={{60,8},{56,4},{0,50},{-52,8},{-52,-52},{60,-52},{60,-60},{-60,
                  -60},{-60,10},{0,60},{60,8}},
              lineColor={95,95,95},
              smooth=Smooth.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid)}),                      Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,120}})),
        experiment(
          StopTime=2419200,
          __Dymola_NumberOfIntervals=5000,
          __Dymola_Algorithm="Lsodar"),
        Documentation(info="<html>
<p>
This is a single zone hydronic system model 
for WP 1.2 of IBPSA project 1.
</p>
</html>",     revisions="<html>
<ul>
<li>
January 22nd, 2019 by Filip Jorissen:<br/>
Revised implementation by adding external inputs.
</li>
<li>
May 2, 2018 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"));
    end SimpleBuilding;

    model Setpoints
      "Occupancy schedules for a dweling. Defines lower and upper temperature comfort bounds."

    parameter Modelica.SIunits.Temperature setHeaOcc=20+273.15
        "Heating setpoint when occupied";
    parameter Modelica.SIunits.Temperature setHeaUno=16+273.15
        "Heating setpoint when unoccupied";

    parameter Modelica.SIunits.Temperature setCooOcc=26+273.15
        "Cooling setpoint when occupied";
    parameter Modelica.SIunits.Temperature setCooUno=30+273.15
        "Cooling setpoint when unoccupied";


      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{24,54},{36,66}})));
      Modelica.Blocks.Sources.Constant SetHeaOcc(k=setHeaOcc)
        "Heating setpoint when occupied"
        annotation (Placement(transformation(extent={{0,-50},{8,-42}})));
      Modelica.Blocks.Sources.Constant SetHeaUno(k=setHeaUno)
        "Heating setpoint when unoccupied"
        annotation (Placement(transformation(extent={{0,-80},{8,-72}})));
      Modelica.Blocks.Logical.Switch switch2
        annotation (Placement(transformation(extent={{24,-66},{36,-54}})));
      Modelica.Blocks.Sources.Constant SetCooOcc(k=setCooOcc)
        "Cooling setpoint when occupied"
        annotation (Placement(transformation(extent={{-2,68},{6,76}})));
      Modelica.Blocks.Sources.Constant SetCooUno(k=setCooUno)
        "Cooling setpoint when unoccupied"
        annotation (Placement(transformation(extent={{-4,44},{4,52}})));
      Modelica.Blocks.Interfaces.RealOutput HeaSet(unit="K") "Heating setpoint"
        annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
            iconTransformation(extent={{100,-70},{120,-50}})));
      Modelica.Blocks.Interfaces.RealOutput CooSet(unit="K") "Cooling setpoint"
        annotation (Placement(transformation(extent={{100,50},{120,70}}),
            iconTransformation(extent={{100,64},{120,84}})));
      Buildings.Controls.SetPoints.OccupancySchedule OccupWeeklySchedule(
        period=604800,
        occupancy=3600*{10,18,34,42,58,62,82,90,106,114},
        firstEntryOccupied=false) "Day schedule"
        annotation (Placement(transformation(extent={{-85,5},{-75,15}})));
    equation

      connect(OccupWeeklySchedule.occupied, switch1.u2) annotation (Line(points={{-74.5,7},
              {-42.65,7},{-42.65,60},{22.8,60}},                color={255,0,255}));
      connect(OccupWeeklySchedule.occupied, switch2.u2) annotation (Line(points={{-74.5,7},
              {-43.65,7},{-43.65,-60},{22.8,-60}},
                                              color={255,0,255}));
      connect(switch1.y, CooSet)
        annotation (Line(points={{36.6,60},{110,60}}, color={0,0,127}));
      connect(switch2.y, HeaSet)
        annotation (Line(points={{36.6,-60},{110,-60}}, color={0,0,127}));
      connect(SetCooOcc.y, switch1.u1) annotation (Line(points={{6.4,72},{14,72},{14,
              64.8},{22.8,64.8}}, color={0,0,127}));
      connect(SetCooUno.y, switch1.u3) annotation (Line(points={{4.4,48},{14,48},{14,
              55.2},{22.8,55.2}}, color={0,0,127}));
      connect(SetHeaUno.y, switch2.u3) annotation (Line(points={{8.4,-76},{16,-76},{
              16,-64.8},{22.8,-64.8}}, color={0,0,127}));
      connect(SetHeaOcc.y, switch2.u1) annotation (Line(points={{8.4,-46},{16,-46},{
              16,-55.2},{22.8,-55.2}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,120}})),           Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,120}}), graphics={
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
              extent={{34,-34},{76,-28}},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0})}),
        Documentation(info="<html>
<ul>
<li></li>
</ul>
</html>"));
    end Setpoints;

    model ComputeDiscomfort
      "Computes the discomfort given comfort setpoints and zone temperature"

      Modelica.Blocks.Logical.Switch switch
        annotation (Placement(transformation(extent={{8,40},{28,60}})));
      Modelica.Blocks.Interfaces.RealInput heaSet "heating setpoint"
        annotation (Placement(transformation(extent={{-120,-90},{-80,-50}})));
      Modelica.Blocks.Interfaces.RealInput cooSet "Cooling setpoint"
        annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
      Modelica.Blocks.Interfaces.RealInput TZon "Zone temperature"
        annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
      Modelica.Blocks.Continuous.Integrator integrator(k=1/3600)
        "Returns the upper discomfort in K-h"
        annotation (Placement(transformation(extent={{40,40},{60,60}})));
      Modelica.Blocks.Math.MultiSum cooDif(k={-1,1}, nu=2)
        "Difference from cooling setpoint"
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
        annotation (Placement(transformation(extent={{-24,40},{-4,60}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-30,8},{-10,28}})));
      Modelica.Blocks.Interfaces.RealOutput uppDis "Upper discomfort"
        annotation (Placement(transformation(extent={{100,32},{136,68}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{8,-60},{28,-40}})));
      Modelica.Blocks.Continuous.Integrator integrator1(k=1/3600)
        "Returns the lower discomfort in K-h"
        annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
      Modelica.Blocks.Math.MultiSum heaDif(k={-1,1}, nu=2)
        "Difference from heating setpoint"
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=0)
        annotation (Placement(transformation(extent={{-24,-60},{-4,-40}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-32,-90},{-12,-70}})));
      Modelica.Blocks.Interfaces.RealOutput lowDis "Lower discomfort"
        annotation (Placement(transformation(extent={{100,-68},{136,-32}})));
      Modelica.Blocks.Math.MultiSum sumDis(k={1,1}, nu=2)
        "Sum of lower and upper discomfort"
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      Modelica.Blocks.Interfaces.RealOutput totDis "Total discomfort"
        annotation (Placement(transformation(extent={{100,-18},{136,18}})));
    equation

      connect(cooSet, cooDif.u[1]) annotation (Line(points={{-100,70},{-74,70},{-74,
              53.5},{-60,53.5}}, color={0,0,127}));
      connect(TZon, cooDif.u[2]) annotation (Line(points={{-100,0},{-74,0},{-74,46},
              {-60,46},{-60,46.5}}, color={0,0,127}));
      connect(cooDif.y, greaterThreshold.u)
        annotation (Line(points={{-38.3,50},{-26,50}}, color={0,0,127}));
      connect(switch.u2, greaterThreshold.y)
        annotation (Line(points={{6,50},{-3,50}}, color={255,0,255}));
      connect(integrator.u, switch.y)
        annotation (Line(points={{38,50},{29,50}}, color={0,0,127}));
      connect(integrator.y, uppDis)
        annotation (Line(points={{61,50},{118,50}}, color={0,0,127}));
      connect(heaDif.y, greaterThreshold1.u)
        annotation (Line(points={{-38.3,-50},{-26,-50}}, color={0,0,127}));
      connect(switch1.u2, greaterThreshold1.y)
        annotation (Line(points={{6,-50},{-3,-50}}, color={255,0,255}));
      connect(integrator1.u, switch1.y)
        annotation (Line(points={{38,-50},{29,-50}}, color={0,0,127}));
      connect(integrator1.y, lowDis)
        annotation (Line(points={{61,-50},{118,-50}}, color={0,0,127}));
      connect(TZon, heaDif.u[1]) annotation (Line(points={{-100,0},{-74,0},{-74,-46.5},
              {-60,-46.5}}, color={0,0,127}));
      connect(heaSet, heaDif.u[2]) annotation (Line(points={{-100,-70},{-74,-70},{-74,
              -53.5},{-60,-53.5}}, color={0,0,127}));
      connect(sumDis.y, totDis)
        annotation (Line(points={{91.7,0},{118,0}}, color={0,0,127}));
      connect(integrator.y, sumDis.u[1]) annotation (Line(points={{61,50},{64,50},{64,
              3.5},{70,3.5}}, color={0,0,127}));
      connect(integrator1.y, sumDis.u[2]) annotation (Line(points={{61,-50},{64,-50},
              {64,-3.5},{70,-3.5}}, color={0,0,127}));
      connect(heaDif.y, switch1.u1) annotation (Line(points={{-38.3,-50},{-32,
              -50},{-32,-28},{0,-28},{0,-42},{6,-42}}, color={0,0,127}));
      connect(const1.y, switch1.u3) annotation (Line(points={{-11,-80},{0,-80},
              {0,-58},{6,-58}}, color={0,0,127}));
      connect(const.y, switch.u3) annotation (Line(points={{-9,18},{0,18},{0,42},
              {6,42}}, color={0,0,127}));
      connect(cooDif.y, switch.u1) annotation (Line(points={{-38.3,50},{-32,50},
              {-32,70},{0,70},{0,58},{6,58}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,120}})),           Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,120}}), graphics={
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
    end ComputeDiscomfort;

    model Bui1IdealHeating
      "First version of building with an ideal heating source as HVAC system"
      extends TheSysConExe.BaseClases.SimpleBuilding(multiSum(nu=1));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
        "Prescribed heat flow to the building"
        annotation (Placement(transformation(extent={{-1,-11},{21,11}})));
      Modelica.Blocks.Continuous.Integrator intHea(k=1/3600000)
        annotation (Placement(transformation(extent={{56,-90},{76,-70}})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloSen
        "Heat flow sensor"
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    equation
      connect(intHea.y, multiSum.u[1])
        annotation (Line(points={{77,-80},{86,-80}}, color={0,0,127}));
      connect(preHea.port, heaFloSen.port_a)
        annotation (Line(points={{21,0},{30,0}}, color={191,0,0}));
      connect(heaFloSen.port_b, case900Template.gainCon) annotation (Line(
            points={{50,0},{68,0},{68,26.4},{78,26.4}}, color={191,0,0}));
      connect(heaFloSen.Q_flow, intHea.u) annotation (Line(points={{40,-10},{40,
              -80},{54,-80}}, color={0,0,127}));
    end Bui1IdealHeating;

    model Bui2ThermostaticValve
      "Building to be controlled using a thermostatic valve"
      extends SimpleBuilding(multiSum(nu=2));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2
                                                     rad(
        redeclare package Medium = Medium,
        T_a_nominal=273.15 + 70,
        T_b_nominal=273.15 + 50,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        Q_flow_nominal=2000) "Radiator"
                                 annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-42,-50})));
      IDEAS.Fluid.HeatExchangers.Heater_T hea(
        redeclare package Medium = Medium,
        m_flow_nominal=pump.m_flow_nominal,
        dp_nominal=0) "Ideal heater"
        annotation (Placement(transformation(extent={{-2,-30},{-22,-10}})));
      IDEAS.Fluid.Movers.FlowControlled_dp pump(
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        use_inputFilter=false,
        dp_nominal=50000,
        redeclare package Medium = Medium,
        m_flow_nominal=rad.m_flow_nominal,
        inputType=IDEAS.Fluid.Types.InputType.Continuous) "Hydronic pump"
        annotation (Placement(transformation(extent={{-12,-80},{8,-60}})));
      IDEAS.Fluid.Sources.Boundary_pT
                                bou(nPorts=1, redeclare package Medium = Medium)
                                           "Absolute pressure boundary"
        annotation (Placement(transformation(extent={{-52,-100},{-32,-80}})));
      Modelica.Blocks.Sources.Constant Tsup(k=273.15 + 70)
        "Supply water temperature set point"
        annotation (Placement(transformation(extent={{-22,18},{-6,34}})));
      IDEAS.Fluid.Actuators.Valves.TwoWayLinear val(
        redeclare package Medium = Medium,
        m_flow_nominal=rad.m_flow_nominal,
        Kv=0.5,
        allowFlowReversal=false,
        show_T=false,
        from_dp=false,
        homotopyInitialization=true,
        linearized=false,
        deltaM=0.02,
        rhoStd=Medium.density_pTX(
                101325,
                273.15 + 4,
                Medium.X_default),
        use_inputFilter=true,
        riseTime=1200,
        init=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=1,
        dpFixed_nominal=0,
        l=0.0001,
        CvData=IDEAS.Fluid.Types.CvTypes.Kv)      "Linear valve"
        annotation (Placement(transformation(extent={{6,-6},{-6,6}},
            rotation=90,
            origin={-42,-30})));
      Modelica.Blocks.Continuous.Integrator intPow(k=1/3600000)
        "Integrator for electricity usage of pump"
        annotation (Placement(transformation(extent={{56,-68},{76,-48}})));
      Modelica.Blocks.Continuous.Integrator intHea(k=1/3600000)
        "Integrator for thermal power of the boiler"
        annotation (Placement(transformation(extent={{56,-106},{76,-86}})));
    equation
      connect(pump.port_a, rad.port_b) annotation (Line(points={{-12,-70},{-42,
              -70},{-42,-60}}, color={0,127,255}));
      connect(pump.port_b, hea.port_a) annotation (Line(points={{8,-70},{19,-70},
              {19,-20},{-2,-20}}, color={0,127,255}));
      connect(bou.ports[1], pump.port_a) annotation (Line(points={{-32,-90},{
              -12,-90},{-12,-70}}, color={0,127,255}));
      connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points=
             {{-34.8,-48},{28,-48},{28,26.4},{78,26.4}}, color={191,0,0}));
      connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points=
             {{-34.8,-52},{30,-52},{30,22.8},{78,22.8}}, color={191,0,0}));
      connect(Tsup.y, hea.TSet) annotation (Line(points={{-5.2,26},{20,26},{20,
              -12},{0,-12}}, color={0,0,127}));
      connect(val.port_a, hea.port_b) annotation (Line(points={{-42,-24},{-42,
              -20},{-22,-20}}, color={0,127,255}));
      connect(rad.port_a, val.port_b)
        annotation (Line(points={{-42,-40},{-42,-36}}, color={0,127,255}));
      connect(pump.P, intPow.u) annotation (Line(points={{9,-61},{30.5,-61},{
              30.5,-58},{54,-58}}, color={0,0,127}));
      connect(hea.Q_flow, intHea.u) annotation (Line(points={{-23,-12},{-76,-12},
              {-76,-112},{30,-112},{30,-96},{54,-96}}, color={0,0,127}));
      connect(intPow.y, multiSum.u[1]) annotation (Line(points={{77,-58},{80,
              -58},{80,-80},{86,-80}}, color={0,0,127}));
      connect(intHea.y, multiSum.u[2]) annotation (Line(points={{77,-96},{80,
              -96},{80,-80},{86,-80}}, color={0,0,127}));
    end Bui2ThermostaticValve;

    model Bui3Tsupply
      "Implementation of a controller using setpoint for boiler supply temperature"
      extends TheSysConExe.BaseClases.SimpleBuilding(multiSum(nu=2));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2
                                                     rad(
        redeclare package Medium = Medium,
        T_a_nominal=273.15 + 70,
        T_b_nominal=273.15 + 50,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        Q_flow_nominal=2000) "Radiator"
                                 annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-42,-50})));
      IDEAS.Fluid.HeatExchangers.Heater_T
                                    hea(
        redeclare package Medium = Medium,
        m_flow_nominal=pump.m_flow_nominal,
        dp_nominal=0) "Ideal heater"
        annotation (Placement(transformation(extent={{-2,-30},{-22,-10}})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow
                                         pump(
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        use_inputFilter=false,
        massFlowRates={0,0.05},
        redeclare package Medium = Medium,
        m_flow_nominal=rad.m_flow_nominal,
        inputType=IDEAS.Fluid.Types.InputType.Constant,
        constantMassFlowRate=0.05) "Hydronic pump"
        annotation (Placement(transformation(extent={{-12,-80},{8,-60}})));
      IDEAS.Fluid.Sources.Boundary_pT
                                bou(nPorts=1, redeclare package Medium = Medium)
                                           "Absolute pressure boundary"
        annotation (Placement(transformation(extent={{-52,-100},{-32,-80}})));
      Modelica.Blocks.Continuous.Integrator intPow(k=1/3600000)
        "Integrator for electricity usage of pump"
        annotation (Placement(transformation(extent={{56,-68},{76,-48}})));
      Modelica.Blocks.Continuous.Integrator intHea(k=1/3600000)
        "Integrator for thermal power of the boiler"
        annotation (Placement(transformation(extent={{56,-106},{76,-86}})));
    equation
      connect(hea.port_b,rad. port_a)
        annotation (Line(points={{-22,-20},{-42,-20},{-42,-40}},
                                                            color={0,127,255}));
      connect(pump.port_a,rad. port_b)
        annotation (Line(points={{-12,-70},{-42,-70},{-42,-60}},
                                                             color={0,127,255}));
      connect(pump.port_b,hea. port_a) annotation (Line(points={{8,-70},{19,-70},
              {19,-20},{-2,-20}},
                            color={0,127,255}));
      connect(bou.ports[1],pump. port_a)
        annotation (Line(points={{-32,-90},{-12,-90},{-12,-70}},
                                                             color={0,127,255}));
      connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points=
             {{-34.8,-48},{28,-48},{28,26.4},{78,26.4}}, color={191,0,0}));
      connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points=
             {{-34.8,-52},{30,-52},{30,22.8},{78,22.8}}, color={191,0,0}));
      connect(pump.P, intPow.u) annotation (Line(points={{9,-61},{30.5,-61},{
              30.5,-58},{54,-58}}, color={0,0,127}));
      connect(intPow.y, multiSum.u[1]) annotation (Line(points={{77,-58},{80,
              -58},{80,-80},{86,-80}}, color={0,0,127}));
      connect(intHea.y, multiSum.u[2]) annotation (Line(points={{77,-96},{80,
              -96},{80,-80},{86,-80}}, color={0,0,127}));
      connect(hea.Q_flow, intHea.u) annotation (Line(points={{-23,-12},{-60,-12},
              {-60,-108},{46,-108},{46,-96},{54,-96}}, color={0,0,127}));
    end Bui3Tsupply;

    model Bui4TsupplyHeatingCurve
      "Implementation of a controller using a heating curve to determine the setpoint for boiler supply temperature"
      extends TheSysConExe.BaseClases.SimpleBuilding(multiSum(nu=2));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2
                                                     rad(
        redeclare package Medium = Medium,
        T_a_nominal=273.15 + 70,
        T_b_nominal=273.15 + 50,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        Q_flow_nominal=2000) "Radiator"
                                 annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-42,-50})));
      IDEAS.Fluid.HeatExchangers.Heater_T
                                    hea(
        redeclare package Medium = Medium,
        m_flow_nominal=pump.m_flow_nominal,
        dp_nominal=0) "Ideal heater"
        annotation (Placement(transformation(extent={{-2,-30},{-22,-10}})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow
                                         pump(
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        use_inputFilter=false,
        massFlowRates={0,0.05},
        redeclare package Medium = Medium,
        m_flow_nominal=rad.m_flow_nominal,
        inputType=IDEAS.Fluid.Types.InputType.Constant,
        constantMassFlowRate=0.05) "Hydronic pump"
        annotation (Placement(transformation(extent={{-12,-80},{8,-60}})));
      IDEAS.Fluid.Sources.Boundary_pT
                                bou(nPorts=1, redeclare package Medium = Medium)
                                           "Absolute pressure boundary"
        annotation (Placement(transformation(extent={{-52,-100},{-32,-80}})));
      Modelica.Blocks.Continuous.Integrator intPow(k=1/3600000)
        "Integrator for electricity usage of pump"
        annotation (Placement(transformation(extent={{56,-68},{76,-48}})));
      Modelica.Blocks.Continuous.Integrator intHea(k=1/3600000)
        "Integrator for thermal power of the boiler"
        annotation (Placement(transformation(extent={{56,-106},{76,-86}})));
    equation
      connect(hea.port_b,rad. port_a)
        annotation (Line(points={{-22,-20},{-42,-20},{-42,-40}},
                                                            color={0,127,255}));
      connect(pump.port_a,rad. port_b)
        annotation (Line(points={{-12,-70},{-42,-70},{-42,-60}},
                                                             color={0,127,255}));
      connect(pump.port_b,hea. port_a) annotation (Line(points={{8,-70},{19,-70},
              {19,-20},{-2,-20}},
                            color={0,127,255}));
      connect(bou.ports[1],pump. port_a)
        annotation (Line(points={{-32,-90},{-12,-90},{-12,-70}},
                                                             color={0,127,255}));
      connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points=
             {{-34.8,-48},{28,-48},{28,26.4},{78,26.4}}, color={191,0,0}));
      connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points=
             {{-34.8,-52},{30,-52},{30,22.8},{78,22.8}}, color={191,0,0}));
      connect(pump.P, intPow.u) annotation (Line(points={{9,-61},{30.5,-61},{
              30.5,-58},{54,-58}}, color={0,0,127}));
      connect(intPow.y, multiSum.u[1]) annotation (Line(points={{77,-58},{80,
              -58},{80,-80},{86,-80}}, color={0,0,127}));
      connect(intHea.y, multiSum.u[2]) annotation (Line(points={{77,-96},{80,
              -96},{80,-80},{86,-80}}, color={0,0,127}));
      connect(hea.Q_flow, intHea.u) annotation (Line(points={{-23,-12},{-60,-12},
              {-60,-108},{46,-108},{46,-96},{54,-96}}, color={0,0,127}));
    end Bui4TsupplyHeatingCurve;
  end BaseClases;

  package Solutions "Package with cotrollers implemented"

    model Sol1IdealHeating
      "Solution for building that controls an ideal heating source"
      extends BaseClases.Bui1IdealHeating;
      Modelica.Blocks.Continuous.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.8,
        yMax=3000,
        yMin=0)
        annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
    equation
      connect(PID.y, preHea.Q_flow)
        annotation (Line(points={{-21,0},{-1,0}}, color={0,0,127}));
      connect(setpoints.HeaSet, PID.u_s) annotation (Line(points={{-61.1,
              103.273},{-38,103.273},{-38,60},{-76,60},{-76,0},{-44,0}}, color=
              {0,0,127}));
      connect(case900Template.TSensor, PID.u_m) annotation (Line(points={{76.8,
              32.4},{-10,32.4},{-10,-28},{-32,-28},{-32,-12}}, color={0,0,127}));
      annotation (
        experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false));
    end Sol1IdealHeating;

    model Sol2ThermostaticValve
      "Solution for building controlled with thermostatic valve"
      extends BaseClases.Bui2ThermostaticValve(val(
          m_flow_nominal=rad.m_flow_nominal,
          CvData=IDEAS.Fluid.Types.CvTypes.Kv,
          Kv=0.5,
          deltaM=0.02,
          init=Modelica.Blocks.Types.Init.InitialOutput,
          dpFixed_nominal=0));
      Modelica.Blocks.Continuous.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PID,
        k=0.002,
        Ti=10,
        Td=0.1,
        yMax=1,
        yMin=0)
        annotation (Placement(transformation(extent={{-96,14},{-86,24}})));
      Modelica.Blocks.Math.BooleanToReal booToRea(realTrue=50000, realFalse=0)
        "Conversion block of control signal to pump pressure set point"
        annotation (Placement(transformation(extent={{-92,-44},{-82,-34}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
        annotation (Placement(transformation(extent={{-68,8},{-60,16}})));
    equation
      connect(setpoints.HeaSet, PID.u_s) annotation (Line(points={{-61.1,
              103.273},{-48,103.273},{-48,48},{-108,48},{-108,19},{-97,19}},
            color={0,0,127}));
      connect(case900Template.TSensor, PID.u_m) annotation (Line(points={{76.8,
              32.4},{12,32.4},{12,42},{-34,42},{-34,4},{-91,4},{-91,13}}, color=
             {0,0,127}));
      connect(PID.y, val.y) annotation (Line(points={{-85.5,19},{-54,19},{-54,
              -30},{-49.2,-30}}, color={0,0,127}));
      connect(booToRea.y, pump.dp_in) annotation (Line(points={{-81.5,-39},{-2,
              -39},{-2,-58}}, color={0,0,127}));
      connect(PID.y, greaterThreshold.u) annotation (Line(points={{-85.5,19},{
              -72,19},{-72,12},{-68.8,12}}, color={0,0,127}));
      connect(greaterThreshold.y, booToRea.u) annotation (Line(points={{-59.6,
              12},{-44,12},{-44,-8},{-98,-8},{-98,-39},{-93,-39}}, color={255,0,
              255}));
      annotation (
        experiment(StopTime=2419200, __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        __Dymola_experimentFlags(
          Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),

          Evaluate=false,
          OutputCPUtime=false,
          OutputFlatModelica=false));
    end Sol2ThermostaticValve;

    model Sol3Tsupply
      "Solution for building that controls the boiler supply temperature"
      extends BaseClases.Bui3Tsupply;
      Modelica.Blocks.Continuous.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.1,
        yMax=273.15 + 90,
        yMin=273.15 + 60)
        annotation (Placement(transformation(extent={{-28,36},{-8,56}})));
    equation
      connect(PID.u_s, setpoints.HeaSet) annotation (Line(points={{-30,46},{-46,
              46},{-46,103.273},{-61.1,103.273}}, color={0,0,127}));
      connect(case900Template.TSensor, PID.u_m) annotation (Line(points={{76.8,
              32.4},{4,32.4},{4,14},{-18,14},{-18,34}}, color={0,0,127}));
      connect(PID.y, hea.TSet) annotation (Line(points={{-7,46},{20,46},{20,-12},
              {0,-12}}, color={0,0,127}));
    end Sol3Tsupply;

    model Sol4TSupplyHeatingCurve
      extends BaseClases.Bui4TsupplyHeatingCurve;
      IDEAS.Controls.ControlHeating.HeatingCurves.HeatingCurve heatingCurve(
        m=1,
        TSup_nominal=333.15,
        TSupMin=293.15,
        minSup=true,
        TRet_nominal=303.15,
        TOut_nominal=273.15,
                   use_TRoo_in=true,
        dTOutHeaBal=8,
        timeFilter=3600)
        annotation (Placement(transformation(extent={{-30,24},{-10,44}})));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
            transformation(extent={{-96,58},{-84,70}}),   iconTransformation(extent=
               {{-236,54},{-216,74}})));
    equation
      connect(heatingCurve.TSup, hea.TSet) annotation (Line(points={{-9,40},{20,40},
              {20,-12},{0,-12}}, color={0,0,127}));
      connect(setpoints.HeaSet, heatingCurve.TRoo_in) annotation (Line(points={{-61.1,
              103.273},{-44,103.273},{-44,28},{-31.9,28}}, color={0,0,127}));
      connect(sim.weaDatBus, weaBus) annotation (Line(
          points={{-100.1,110},{-90,110},{-90,64}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(weaBus.TDryBul, heatingCurve.TOut) annotation (Line(
          points={{-90,64},{-90,40},{-32,40}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
    end Sol4TSupplyHeatingCurve;
  end Solutions;
  annotation (uses(IDEAS(version="2.0.0"), Modelica(version="3.2.2"),
      Buildings(version="6.0.0")));
end TheSysConExe;
