function F = labor_model_self_emp(x, beta_f, beta_i, tau_l, tau_pi, tau_ncsb, lambda_l, sigma_l, S, gamma, z_lb, z_ub, kai)
%------------------------------------------------
% PURPOSE: labor market simulation
%------------------------------------------------
% USAGE: li : Demand of informal labor by firm (X)
% where: x : x(1) formal wage
%            x(2) informal wage
%            x(3) z1
%            x(4) formal employment at z2
%            x(5) informal employment at z2
%            x(6) z2
%            x(7) self-employment at z1
%            x(8) self-employment at z2
%            x(9) share of formal employees

%------------------------------------------------
% MODEL  
%------------------------------------------------
%beta_f   = 0.480;
%beta_i   = 0.525;
%tau_l    = 0.603; % Anton uses 0.603
%tau_l    = 0.468; % Anton uses 0.603
%tau_pi   = 1/3;
%tau_ncsb = 0.016; % Anton uses 0.016
%lambda_l = 1.000;
%sigma_l  = 1.500;
%S        = 0.500; %Leal : 4.25
%gamma    = 2/3; %Anton uses 0.33 for capital share
%z_lb     = 1.000;  %Leal: 1
%z_ub     = 2.450; %Leal: 13
%kai      = 0.4 

%household eq. for eta
F(1)  = x(1)*(1+beta_f*tau_l)-x(2)-beta_i*tau_ncsb;
%self-employment at z1
F(2)  = x(7)-((gamma/x(2))^(1/(1-gamma))*x(3));
%equilibrium for z1
F(3)  = (x(2)*(1+x(7)-kai))-(x(3)^(1-gamma)*(x(7)^gamma));
%total labor demand from employer
F(4)  = x(4)+((1+tau_l)*(x(1)/x(2))-1)/(2*lambda_l*sigma_l*tau_l*x(6))-((gamma/((1+tau_l)*x(1)))^(1/(1-gamma))*x(6));
%self-employment at z2
F(5)  = x(8)-(gamma/x(2))^(1/(1-gamma))*x(6);
%labor market equilibrium
F(6)  = ((S/(1-S))*z_lb^S*(kai*(gamma/x(2))^(1/(1-gamma))*(x(6)^(1-S)-x(3)^(1-S))+(gamma/(1+tau_l)*x(1))^(1/(1-gamma))*(z_ub^(1-S)-x(6)^(1-S))))-1+kai*(z_lb/x(6))^S+(1-kai)*(z_lb/x(3))^S;
%goods market equilibrium
F(7)  = tau_ncsb*((1-(z_lb/z_ub)^S)/z_lb)+x(2)*(z_lb^(-S)+kai*x(6)^(-S))-(1-kai)*x(2)*(x(3)^(-S))-(S/(1+S))*((((1+tau_l)*x(1))^2)-x(2)^2)/(2*lambda_l*sigma_l*tau_l*x(2))*(z_ub^(-S-1)-x(2)^(-S-1))*gamma^(1/(1-gamma))-(S/(1-S))*((1/x(2))^(gamma/(1-gamma))*(x(6)^(1-S)-x(3)^(1-S))+((1/(1+tau_l)*x(1))^(gamma/(1-gamma)))*(z_ub^(1-S)-x(6)^(1-S)));
%equilibrium for z2
F(8)  = x(3)^(1-gamma)*x(8)^gamma+x(2)*(kai-x(3))-(1-tau_pi)*(x(6)^(1-gamma)*x(8)^gamma-(1+tau_l)*x(2)*x(4)-(1+lambda_l*x(8)*x(6)*sigma_l*tau_l)*x(8));
%government budget before reform
F(9)  = ((gamma^(gamma/(1-gamma)))-(gamma^(1/(1-gamma))))*(1/((1+tau_l)*x(1)))^(gamma/(1-gamma))*((z_ub^(1-S)-x(6)^(1-S))/(1-S))-(((1+tau_l)^2*x(1)^2/x(2)-2*(1+tau_l)+x(2))/4*lambda_l*sigma_l*tau_l)*((z_ub^(-S-1)-x(6)^(-S-1))/(1+S))+(tau_ncsb/(tau_pi*S))*((1-x(9))*(x(3)^(-S)-z_lb^(-S))+kai*(x(6)^(-S)-x(3)^(-S))+z_ub^(-S)-x(6)^(-S));
%share of formality
F(10) = x(9) - ((S/(1+S))*(z_lb^S*(x(6)^(-S-1)-z_ub^(-S-1))/(1-(z_lb/z_ub)^S)*((1+tau_l)*(x(1)/x(2))-1)/(2*lambda_l*sigma_l*tau_l))) / ((S/(1-S))*(gamma/(1+tau_l)*x(1)^(1/(1-gamma))*z_lb*(z_ub^(1-S)-x(6)^(1-S))/(1-(z_lb/z_ub)^S)));

end


