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
    nitrogen = load_spec.load_spec('nitrogen')

    alpha = 15
    g = 9.81
    lam = (1+math.cos(alpha)/2)
    gamma = float(nitrogen['gamma']) # Specific heat
    Rsp = float(nitrogen['R'])
    Tc = 300
    P_exit = 1
    P_chamber = 1
    Isp = 1 / g * math.sqrt(2 * gamma / (gamma - 1) * Rsp * Tc * (1 - (P_exit / P_chamber) ** ((gamma - 1) / gamma)))
    m_dot = 1
    Fth = lam*m_dot*Isp*g
    return Fth

    # %% Thermodynamic equations
    # % Ideal gas law with compressibility
    # % P = Z*density*Rsp*T;
    #
    #

if __name__ == '__main__':
    print(ColdGasThruster())