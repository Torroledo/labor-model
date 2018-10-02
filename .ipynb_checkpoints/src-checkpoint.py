import numpy as np

beta_f   = 0.480
beta_i   = 0.525
tau_l    = 0.603 # Anton uses 0.603
tau_pi   = 1/3
sigma_l  = 1.500
gamma    = 2/3   # Anton uses 0.33 for capital share
z_lb     = 1.000 # Leal: 1
kai      = 0.4


def labor_model_self_emp(x):
    F = np.zeros(10)

    #household eq. for eta
    F[0]  = x[0]*(1+beta_f*tau_l)-x[1]-beta_i*tau_ncsb
    #self-employment at z1
    F[1]  = x[6]-((gamma/x[1])**(1/(1-gamma))*x[2])
    #equilibrium for z1
    F[2]  = (x[1]*(1+x[6]-kai))-(x[2]**(1-gamma)*(x[6]**gamma))
    #total labor demand from employer
    F[3]  = x[3]+((1+tau_l)*(x[0]/x[1])-1)/(2*lambda_l*sigma_l*tau_l*x[5])-((gamma/((1+tau_l)*x[0]))**(1/(1-gamma))*x[5])
    #self-employment at z2
    F[4]  = x[7]-(gamma/x[1])**(1/(1-gamma))*x[5]
    #labor market equilibrium
    F[5]  = ((S/(1-S))*z_lb**S*(kai*(gamma/x[1])**(1/(1-gamma))*(x[5]**(1-S)-x[2]**(1-S))+(gamma/(1+tau_l)*x[0])**(1/(1-gamma))*(z_ub**(1-S)-x[5]**(1-S))))-1+kai*(z_lb/x[5])**S+(1-kai)*(z_lb/x[2])**S
    #goods market equilibrium
    F[6]  = tau_ncsb*((1-(z_lb/z_ub)**S)/z_lb)+x[1]*(z_lb**(-S)+kai*x[5]**(-S))-(1-kai)*x[1]*(x[2]**(-S))-(S/(1+S))*((((1+tau_l)*x[0])**2)-x[1]**2)/(2*lambda_l*sigma_l*tau_l*x[1])*(z_ub**(-S-1)-x[1]**(-S-1))*gamma**(1/(1-gamma))-(S/(1-S))*((1/x[1])**(gamma/(1-gamma))*(x[5]**(1-S)-x[2]**(1-S))+((1/(1+tau_l)*x[0])**(gamma/(1-gamma)))*(z_ub**(1-S)-x[5]**(1-S)))
    #equilibrium for z2
    F[7]  = x[2]**(1-gamma)*x[7]**gamma+x[1]*(kai-x[2])-(1-tau_pi)*(x[5]**(1-gamma)*x[7]**gamma-(1+tau_l)*x[1]*x[3]-(1+lambda_l*x[7]*x[5]*sigma_l*tau_l)*x[7])
    #government budget before reform
    F[8]  = ((gamma**(gamma/(1-gamma)))-(gamma**(1/(1-gamma))))*(1/((1+tau_l)*x[0]))**(gamma/(1-gamma))*((z_ub**(1-S)-x[5]**(1-S))/(1-S))-(((1+tau_l)**2*x[0]**2/x[1]-2*(1+tau_l)+x[1])/4*lambda_l*sigma_l*tau_l)*((z_ub**(-S-1)-x[5]**(-S-1))/(1+S))+(tau_ncsb/(tau_pi*S))*((1-x[8])*(x[2]**(-S)-z_lb**(-S))+kai*(x[5]**(-S)-x[2]**(-S))+z_ub**(-S)-x[5]**(-S))
    #share of formality
    F[9] = x[8] - ((S/(1+S))*(z_lb**S*(x[5]**(-S-1)-z_ub**(-S-1))/(1-(z_lb/z_ub)**S)*((1+tau_l)*(x[0]/x[1])-1)/(2*lambda_l*sigma_l*tau_l))) / ((S/(1-S))*(gamma/(1+tau_l)*x[0]**(1/(1-gamma))*z_lb*(z_ub**(1-S)-x[5]**(1-S))/(1-(z_lb/z_ub)**S)))

    return F

def labor_model_self_emp_tr(x):
    #------------------------------------------------
    # MODEL  
    #------------------------------------------------
    #parameters
    #beta_f   = 0.480
    #beta_i   = 0.525
    #tau_l    = 0.603 # Anton uses 0.603
    #tau_pi    = tau_pi_0 + tau_pi_tr
    #tau_pi_0  = 1/4
    #tau_pi_tr = .09
    #tau_ncsb = 6.8 # Anton uses 0.016
    #lambda_l = 0.24
    #sigma_l  = 1.500
    #S        = 6.3 #Leal : 4.25
    #gamma    = 2/3 #Anton uses 0.33 for capital share
    #z_lb     = 1.000 #Leal: 
    #z_ub     = 26 #Leal: 13
    #kai      = 0.4

    F = np.zeros(11)

    #household eq. for eta
    F[0]  = x[0]+beta_f*x[9]-x[1]-beta_i*tau_ncsb
    #contributory social benefits
    F[1]  = x[9]-tau_l*x[0]+((tau_pi_tr*S)/(x[8]*(x[2]**(-S)-z_lb**(-S))))*(gamma**(gamma/(1-gamma))-gamma**(1/(1-gamma)))*((1/((1+tau_l)*x[0]))**(gamma/(1-gamma)))*((z_ub**(1-S)-x[5]**(1-S))/(1-S))-((((1+tau_l)**2)*((x[0]**2)/x[1])-2*(1+tau_l)*x[0]+x[1])/(4*lambda_l*sigma_l*tau_l))*((z_ub**(-S-1)-x[5]**(-S-1))/(1+S))
    #self-employment at z1
    F[2]  = x[6]-((gamma/x[1])**(1/(1-gamma))*x[2])
    #equilibrium for z1
    F[3]  = (x[1]*(1+x[6]-kai))-(x[2]**(1-gamma)*(x[6]**gamma))
    #total labor demand from employer
    F[4]  = x[3]+((1+tau_l)*(x[0]/x[1])-1)/(2*lambda_l*sigma_l*tau_l*x[5])-((gamma/((1+tau_l)*x[0]))**(1/(1-gamma))*x[5])
    #self-employment at z2
    F[5]  = x[7]-(gamma/x[1])**(1/(1-gamma))*x[5]
    #labor market equilibrium
    F[6]  = ((S/(1-S))*z_lb**S*(kai*(gamma/x[1])**(1/(1-gamma))*(x[5]**(1-S)-x[2]**(1-S))+(gamma/(1+tau_l)*x[0])**(1/(1-gamma))*(z_ub**(1-S)-x[5]**(1-S))))-1+kai*(z_lb/x[5])**S+(1-kai)*(z_lb/x[2])**S
    #goods market equilibrium
    F[7]  = tau_ncsb*((1-(z_lb/z_ub)**S)/z_lb)+x[1]*(z_lb**(-S)+kai*x[5]**(-S))-(1-kai)*x[1]*(x[2]**(-S))-(S/(1+S))*((((1+tau_l)*x[0])**2)-x[1]**2)/(2*lambda_l*sigma_l*tau_l*x[1])*(z_ub**(-S-1)-x[1]**(-S-1))*gamma**(1/(1-gamma))-(S/(1-S))*((1/x[1])**(gamma/(1-gamma))*(x[5]**(1-S)-x[2]**(1-S))+((1/(1+tau_l)*x[0])**(gamma/(1-gamma)))*(z_ub**(1-S)-x[5]**(1-S)))
    #equilibrium for z2
    F[8]  = x[2]**(1-gamma)*x[7]**gamma+x[1]*(kai-x[2])-(1-tau_pi_0-tau_pi_tr)*(x[5]**(1-gamma)*x[7]**gamma-(1+tau_l)*x[1]*x[3]-(1+lambda_l*x[7]*x[5]*sigma_l*tau_l)*x[7])
    #government budget before reform
    F[9]  = ((gamma**(gamma/(1-gamma)))-(gamma**(1/(1-gamma))))*(1/((1+tau_l)*x[0]))**(gamma/(1-gamma))*((z_ub**(1-S)-x[5]**(1-S))/(1-S))-(((1+tau_l)**2*x[0]**2/x[1]-2*(1+tau_l)+x[1])/4*lambda_l*sigma_l*tau_l)*((z_ub**(-S-1)-x[5]**(-S-1))/(1+S))+(tau_ncsb/((tau_pi_0+tau_pi_tr)*S))*((1-x[8])*(x[2]**(-S)-z_lb**(-S))+kai*(x[5]**(-S)-x[2]**(-S))+z_ub**(-S)-x[5]**(-S))
    #share of formality
    F[10] = x[8] - ((S/(1+S))*(z_lb**S*(x[5]**(-S-1)-z_ub**(-S-1))/(1-(z_lb/z_ub)**S)*((1+tau_l)*(x[0]/x[1])-1)/(2*lambda_l*sigma_l*tau_l))) / ((S/(1-S))*(gamma/(1+tau_l)*x[0]**(1/(1-gamma))*z_lb*(z_ub**(1-S)-x[5]**(1-S))/(1-(z_lb/z_ub)**S)))

    return F