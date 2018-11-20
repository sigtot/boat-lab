function x_est = kalman(y, u, sys_init)
    persistent x_est_ A B C E H Q R P_ init
    
    %% Initialisation
    if isempty(init)
       init    = 1;
        A      = sys_init.A_d;
        B      = sys_init.B_d;
        C      = sys_init.C_d;
        E      = sys_init.E_d;
        H      = sys_init.H_d;
        P_     = sys_init.P_0_;
        x_est_ = sys_init.x_est_0_;
        Q      = sys_init.Q;
        R      = sys_init.R;
        
    end
    
    %% Update y_est_
    
    y_est_ = C*x_est_;
    
    %% Calculate Kalman gain
    
    K = P_*C'*(C*P_*C' + H*R*H')^-1;
    
    %% Find a posteriori x_est
    
    x_est = x_est_ + K*(y - y_est_);
    
    %% Update covariance matrix P_

    P = P_ - K*C*P_ - P_*C'*K' + K*(C*P_*C' + H*R*H')*K';
    
    P_ = A*P*A' + E*Q*E';
    
    %% Update x_est_
    
    x_est_ = A*x_est + B*u;
end