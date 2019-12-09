within ;
package TheSysConExe "Thermal systems control exercise"

  package BaseClases "Base clases for thermal systems exercise"
    model SimpleBuilding
      "Single zone residential hydronic simple building with calculation of KPIs"
      extends Modelica.Icons.Example;
      package Medium = IDEAS.Media.Water;
      IDEAS.Buildings.Validation.Cases.Case900Template case900Template
        "Case 900 BESTEST model"
        annotation (Placement(transformation(extent={{102,18},{78,42}})));
      inner IDEAS.BoundaryConditions.SimInfoManager sim
        "Simulation information manager for climate data"
        annotation (Placement(transformation(extent={{-100,100},{-80,120}})));

      Modelica.Blocks.Interfaces.RealOutput TZon "Zone operative temperature"
        annotation (Placement(transformation(extent={{120,70},{140,90}})));
      Setpoints setpoints
        annotation (Placement(transformation(extent={{-60,100},{-44,116}})));
      ComputeDiscomfort computeDiscomfort
        annotation (Placement(transformation(extent={{62,100.909},{78,116}})));
      Modelica.Blocks.Interfaces.RealOutput dis "Thermal discomfort"
        annotation (Placement(transformation(extent={{120,98},{140,118}})));
    equation
      connect(case900Template.TSensor, TZon);
      connect(case900Template.TSensor, TZon) annotation (Line(points={{76.8,
              32.4},{65,32.4},{65,80},{130,80}},
                                       color={0,0,127}));
      connect(case900Template.TSensor, computeDiscomfort.TZon) annotation (Line(
            points={{76.8,32.4},{41.6,32.4},{41.6,107.769},{62,107.769}}, color
            ={0,0,127}));
      connect(computeDiscomfort.totDis, dis) annotation (Line(points={{79.44,
              107.769},{106,107.769},{106,108},{130,108}}, color={0,0,127}));
      connect(setpoints.CooSet, computeDiscomfort.cooSet) annotation (Line(
            points={{-43.2,112.655},{11.55,112.655},{11.55,112.57},{62,112.57}},
            color={0,0,127}));
      connect(setpoints.HeaSet, computeDiscomfort.heaSet) annotation (Line(
            points={{-43.2,102.909},{11.55,102.909},{11.55,102.967},{62,102.967}},
            color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -120,-120},{120,120}})),                             Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{
                120,120}})),
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
  end BaseClases;

  model Con1IdealHeating
    "Implementation of a controller using an ideal heating source"
    extends TheSysConExe.BaseClases.SimpleBuilding;
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
      "Prescribed heat flow to the building"
      annotation (Placement(transformation(extent={{11,-11},{33,11}})));
    Modelica.Blocks.Interfaces.RealInput conSig(start=2000) "Control signal"
      annotation (Placement(transformation(extent={{-40,-20},{0,20}})));
  equation
    connect(preHea.port, case900Template.gainCon) annotation (Line(points={{33,
            0},{39,0},{39,26.4},{78,26.4}}, color={191,0,0}));
    connect(preHea.Q_flow, conSig)
      annotation (Line(points={{11,0},{-20,0}}, color={0,0,127}));
  end Con1IdealHeating;

  model Con2ThermostaticValve
    "Implementation of a controller using a thermostatic valve"
    extends TheSysConExe.BaseClases.SimpleBuilding;
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
          origin={-30,-50})));
    IDEAS.Fluid.HeatExchangers.Heater_T
                                  hea(
      redeclare package Medium = Medium,
      m_flow_nominal=pump.m_flow_nominal,
      dp_nominal=0) "Ideal heater"
      annotation (Placement(transformation(extent={{10,-30},{-10,-10}})));
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
      annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
    IDEAS.Fluid.Sources.Boundary_pT
                              bou(nPorts=1, redeclare package Medium = Medium)
                                         "Absolute pressure boundary"
      annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
    Modelica.Blocks.Interfaces.RealInput conSig(start=320)
      "Temperature set point of heater" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-8,20})));
  equation
    connect(hea.port_b,rad. port_a)
      annotation (Line(points={{-10,-20},{-30,-20},{-30,-40}},
                                                          color={0,127,255}));
    connect(pump.port_a,rad. port_b)
      annotation (Line(points={{0,-70},{-30,-70},{-30,-60}},
                                                           color={0,127,255}));
    connect(pump.port_b,hea. port_a) annotation (Line(points={{20,-70},{31,-70},
            {31,-20},{10,-20}},
                          color={0,127,255}));
    connect(bou.ports[1],pump. port_a)
      annotation (Line(points={{-20,-90},{0,-90},{0,-70}}, color={0,127,255}));
    connect(rad.heatPortCon, case900Template.gainCon) annotation (Line(points={
            {-22.8,-48},{40,-48},{40,26.4},{58,26.4}}, color={191,0,0}));
    connect(rad.heatPortRad, case900Template.gainRad) annotation (Line(points={
            {-22.8,-52},{42,-52},{42,22.8},{58,22.8}}, color={191,0,0}));
    connect(conSig, hea.TSet) annotation (Line(points={{-8,20},{20,20},{20,-12},
            {12,-12}}, color={0,0,127}));
  end Con2ThermostaticValve;
  annotation (uses(IDEAS(version="2.0.0"), Modelica(version="3.2.2"),
      Buildings(version="6.0.0")));
end TheSysConExe;
