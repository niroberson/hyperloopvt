import math
from Libraries import load_spec


def ColdGasThruster():
    # % Isp : Specific Impulse
    # % Rsp (J/(kg*K)) : Specific Gas constant
    # % Tc (K) : Chamber Temperature
    # % m_dot (kg/s) : Mass flow
    # % Ue (m/s) : Exhaust velocity
    # % Pe (Pa) : Exit pressure
    # % Pa (Pa) : Ambient pressure
    # % Pc (Pa) : Chamber Pressure
    # % Ae (m) : Exit Area (x-section)
    # % gamma : Ratio of specific heats
    gas = load_spec.load_spec('nitrogen')
    g = 9.81

    alpha = 15
    lam = (1+math.cos(alpha)/2)
    gamma = float(gas['gamma']) # Specific heat
    Rsp = float(gas['R'])
    Tc = 300
    P_exit = 1
    P_chamber = 1
    Isp = 1 / g * math.sqrt(2 * gamma / (gamma - 1) * Rsp * Tc * (1 - (P_exit / P_chamber) ** ((gamma - 1) / gamma)))
    m_dot = 1
    Fth = lam*m_dot*Isp*g

    # %% Thermodynamic equations
    # % Ideal gas law with compressibility
    # % P = Z*density*Rsp*T;
    #
    #

    return Fth


def PressureVessel():
    # Need to calculate the speed, pressure, mass flow out of the tank
    tank = load_spec.load_spec('tank')
    gas = load_spec.load_spec('nitrogen')
    tube = load_spec.load_spec('tube')

    Pa = float(tube['p'])/1000
    Pg = float(tank['p_max'])*6.89476

    m = float(gas['m'])
    R = float(gas['Rsp'])

    M = m*R*T/Pg


    return


if __name__ == '__main__':
    print(ColdGasThruster())
