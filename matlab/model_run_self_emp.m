clear

%CALIBRATION
%tau_ncsb, lambda_l, z_ub
beta_f   = 0.480;
beta_i   = 0.525;
tau_l    = 0.603; % Anton uses 0.603
tau_pi   = 1/3;
tau_ncsb = 0.9; % Anton uses 0.016
lambda_l = 0.260;
sigma_l  = 1.500;
S        = 0.500; %Leal : 4.25
gamma    = 2/3; %Anton uses 0.33 for capital share
z_lb     = 1.000; %Leal: 1
z_ub     = 5.640; %Leal: 13
kai      = 0.4;
all_vec = [0,0,0,0,0,0];
for i = 7.000:0.050:7.200
    for j = 0.450:0.010:0.550
        for k = 1.150:0.010:1.250
            for l = 0.500:0.010:0.600
            tau_ncsb = i;                
            lambda_l = j;
            z_ub     = k;
            S        = l;
            x0 = [1,    1,  1,  1,  1,  1,  1,  1, .5];
            lb = [0,    0,z_lb,  0,  0,z_lb,  0,  0,0];
            ub = [100,100,z_ub,100,100,z_ub,100,100,1];
            [x,resnorm,residual,exitflag,output] = lsqnonlin(@(x)labor_model_self_emp(x,beta_f,beta_i,tau_l,tau_pi,tau_ncsb,lambda_l,sigma_l,S,gamma,z_lb,z_ub,kai),x0,lb,ub)
            %results
% where: x : x(1)  formal wage
%            x(2)  informal wage
%            x(3)  z1
%            x(4)  formal employment at z2
%            x(5)  informal employment at z2
%            x(6)  z2
%            x(7)  self-employment at z1
%            x(8) self-employment at z2
%            x(9) share of formal employees
            w_f_w_l = x(1)/x(2)
            shr_inf_emp = (1-x(9))*100 
            %results of interest
            all_vec = [all_vec;tau_ncsb,lambda_l,z_ub,S,shr_inf_emp,w_f_w_l];
            end
        end
    end
end 

%model without tax reform
%------------------------
%parameters
beta_f   = 0.480;
beta_i   = 0.525;
tau_l    = 0.603; % Anton uses 0.603
tau_pi   = 1/3;
tau_ncsb = 7.000; % Anton uses 0.016
lambda_l = 0.500;
sigma_l  = 1.500;
S        = 0.510; %Leal : 4.25
gamma    = 2/3; %Anton uses 0.33 for capital share
z_lb     = 1.000; %Leal: 1
z_ub     = 1.2; %Leal: 13
kai      = 0.4;
%simulation
x0 = [1,    1,   1,  1,  1,   1,  1,  1,.5];
lb = [0,    0,z_lb,  0,  0,z_lb,  0,  0, 0];
ub = [100,100,z_ub,100,100,z_ub,100,100, 1];
[x,resnorm,residual,exitflag,output] = lsqnonlin(@(x)labor_model_self_emp(x,beta_f,beta_i,tau_l,tau_pi,tau_ncsb,lambda_l,sigma_l,S,gamma,z_lb,z_ub,kai),x0,lb,ub)
%results
w_f_w_l = x(1)/x(2)
shr_inf_emp = (1-x(9))*100 

%model with tax reform
%---------------------
%parameters
beta_f    = 0.480;
beta_i    = 0.525;
tau_l     = 0.468; % Anton uses 0.603
tau_pi_0  = 1/4;
tau_pi_tr = 0.09;
tau_ncsb = 7.00; % Anton uses 0.016
lambda_l = 0.500;
sigma_l  = 1.500;
S        = 0.51; %Leal : 4.25
gamma    = 2/3; %Anton uses 0.33 for capital share
z_lb     = 1.000; %Leal: 1
z_ub     = 1.2; %Leal: 13
kai      = 0.4;
%simulation
x0 = [2,    1,   2,  1,  1,   3,  1,  1,.5,  1];
lb = [0,    0,z_lb,  0,  0,z_lb,  0,  0, 0,  0];
ub = [100,100,z_ub,100,100,z_ub,100,100, 1,100];
[x,resnorm,residual,exitflag,output] = lsqnonlin(@(x)labor_model_self_emp_tr(x,beta_f,beta_i,tau_l,tau_pi_0,tau_pi_tr,tau_ncsb,lambda_l,sigma_l,S,gamma,z_lb,z_ub,kai),x0,lb,ub)
%results
w_f_w_l = x(1)/x(2)
shr_inf_emp_tr = (1-x(9))*100 

%effect tax reform on informality
change_shr_inf_emp     =  shr_inf_emp_tr-shr_inf_emp 
change_shr_inf_emp_per =((shr_inf_emp_tr-shr_inf_emp)/shr_inf_emp)*100
