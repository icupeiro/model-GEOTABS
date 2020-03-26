within TheSysConExe.GEOTABS.BaseClasses.Constructions.Materials;
record Concrete_lowC =
                  IDEAS.Buildings.Data.Interfaces.Material (
    k=1.4,
    c=300,
    rho=150,
    epsLw=0.86,
    epsSw=0.44) "Dense cast concrete, also for finishing" annotation (
    Documentation(info="<html>
<p>
Thermal properties of concrete.
</p>
</html>"));
