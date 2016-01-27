within Annex60.Fluid.Chillers;
model Carnot_y
  "Chiller with performance curve adjusted based on Carnot efficiency"
 extends Annex60.Fluid.Chillers.BaseClasses.PartialCarnot_y(
  final QEva_flow_nominal = -P_nominal * COP_nominal);

  final parameter Modelica.SIunits.HeatFlowRate QCon_flow_nominal(min=0)=
    P_nominal - QEva_flow_nominal "Nominal heating flow rate";

initial equation
  COP_nominal = etaCar * TEva_nominal/(TCon_nominal-TEva_nominal);

equation
  COPCar = TEva / Annex60.Utilities.Math.Functions.smoothMax(x1=1, x2=TCon-TEva, deltaX=0.25);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-56,68},{58,50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-56,-52},{58,-70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-103,64},{98,54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,54},{98,64}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-101,-56},{100,-66}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-66},{0,-56}},
          lineColor={0,0,127},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-42,0},{-52,-12},{-32,-12},{-42,0}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-42,0},{-52,10},{-32,10},{-42,0}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,50},{-40,10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,-12},{-40,-52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{38,50},{42,-52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{18,22},{62,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,22},{22,-10},{58,-10},{40,22}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-144,146},{-88,104}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="y"),
        Text(extent={{64,96},{114,82}},   textString="P",
          lineColor={0,0,127})}),
defaultComponentName="chi",
Documentation(info="<html>
<p>
This is model of a chiller whose coefficient of performance COP changes
with temperatures in the same way as the Carnot efficiency changes.
The input signal is the control signal for the compressor.
</p>
<p>
The COP at the nominal conditions can be specified by a parameter, or
it can be computed by the model based on the Carnot effectiveness, in which
case
</p>
<p align=\"center\" style=\"font-style:italic;\">
  COP<sub>0</sub> = &eta;<sub>car</sub> COP<sub>car</sub>
= &eta;<sub>car</sub> T<sub>eva</sub> &frasl; (T<sub>con</sub>-T<sub>eva</sub>),
</p>
<p>
where <i>T<sub>eva</sub></i> is the evaporator temperature
and <i>T<sub>con</sub></i> is the condenser temperature.
On the <code>Advanced</code> tab, a user can specify the temperature that
will be used as the evaporator (or condenser) temperature. The options
are the temperature of the fluid volume, of <code>port_a</code>, of
<code>port_b</code>, or the average temperature of <code>port_a</code> and
<code>port_b</code>.
</p>
<p>
The chiller COP is computed as the product
</p>
<p align=\"center\" style=\"font-style:italic;\">
  COP = &eta;<sub>car</sub> COP<sub>car</sub> &eta;<sub>PL</sub>,
</p>
<p>
where <i>&eta;<sub>car</sub></i> is the Carnot effectiveness,
<i>COP<sub>car</sub></i> is the Carnot efficiency and
<i>&eta;<sub>PL</sub></i> is a polynomial in the control signal <i>y</i>
that can be used to take into account a change in <i>COP</i> at part load
conditions.
This polynomial has the form
</p>
<p align=\"center\" style=\"font-style:italic;\">
  &eta;<sub>PL</sub> = a<sub>1</sub> + a<sub>2</sub> y + a<sub>3</sub> y<sup>2</sup> + ...
</p>
<p>
where <i>y &isin; [0, 1]</i> is the control input and the coefficients <i>a<sub>i</sub></i>
are declared by the parameter <code>a</code>.
</p>
<p>
On the <code>Dynamics</code> tag, the model can be parametrized to compute a transient
or steady-state response.
The transient response of the model is computed using a first
order differential equation for the evaporator and condenser fluid volumes.
The chiller outlet temperatures are equal to the temperatures of these lumped volumes.
</p>
<p>
For a similar model that can be used as a heat pump, see
<a href=\"modelica://Annex60.Fluid.HeatPumps.Carnot_y\">Annex60.Fluid.HeatPumps.Carnot_y</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
January 26, 2016, by Michael Wetter:<br/>
Refactored model to use the same base class as
<a href=\"modelica://Annex60.Fluid.HeatPumps.Carnot_y\">Annex60.Fluid.HeatPumps.Carnot_y</a>.
</li>
<li>
December 18, 2015, by Michael Wetter:<br/>
Corrected wrong computation of <code>staB1</code> and <code>staB2</code>
which mistakenly used the <code>inStream</code> operator
for the configuration without flow reversal.
This is for
<a href=\"modelica://https://github.com/lbl-srg/modelica-buildings/issues/476\">
issue 476</a>.
</li>
<li>
November 25, 2015 by Michael Wetter:<br/>
Changed sign convention for <code>dTEva_nominal</code> to be consistent with
other models.
The model will still work with the old values for <code>dTEva_nominal</code>,
but it will write a warning so that users can transition their models.
<br/>
Corrected <code>assert</code> statement for the efficiency curve.
This is for
<a href=\"modelica://https://github.com/lbl-srg/modelica-buildings/issues/468\">
issue 468</a>.
</li>
<li>
September 3, 2015 by Michael Wetter:<br/>
Expanded documentation.
</li>
<li>
May 6, 2015 by Michael Wetter:<br/>
Added <code>prescribedHeatFlowRate=true</code> for <code>vol2</code>.
</li>
<li>
October 9, 2013 by Michael Wetter:<br/>
Reimplemented the computation of the port states to avoid using
the conditionally removed variables <code>sta_a1</code>,
<code>sta_a2</code>, <code>sta_b1</code> and <code>sta_b2</code>.
</li>
<li>
May 10, 2013 by Michael Wetter:<br/>
Added electric power <code>P</code> as an output signal.
</li>
<li>
October 11, 2010 by Michael Wetter:<br/>
Fixed bug in energy balance.
</li>
<li>
March 3, 2009 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Carnot_y;
