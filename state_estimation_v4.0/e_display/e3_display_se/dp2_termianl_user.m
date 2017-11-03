 function dp2_termianl_user(ana, pmu, out)

  
 b = out.b;
 
 disp(' ') 
 disp('   _______________________________________________________________________________________') 
 disp('  |                                 Legacy Measurement Devices                            |')
 disp('  |                                                                                       |')
 disp('  |  No.  Type      Unit          Measure     Estimate    Residual M-E         STD        |')
 disp('  |---------------------------------------------------------------------------------------|')
 for i = 1:ana.Nana
 fprintf('  |%4.f   %-10s%-9s %11.4f %12.4f %12.4f %18.4e \t  |\n',...
          i,  out.name{i}, out.unit{i}, out.z(i) * b(i), out.f(i) * b(i), (out.z(i) - out.f(i)) * b(i),  out.s(i) * b(i))
 end
 disp('  |_______________________________________________________________________________________|') 
 
 
 disp('   _______________________________________________________________________________________') 
 disp('  |                                  PMU Measurement Devices                              |')
 disp('  |                                                                                       |')
 disp('  |  No.  Type      Unit          Measure     Estimate    Residual M-E         STD        |')
 disp('  |---------------------------------------------------------------------------------------|')
 for i = (ana.Nana + 1) : (ana.Nana + pmu.Npmu)
 fprintf('  |%4.f   %-10s%-9s %11.4f %12.4f %12.4f %18.4e \t  |\n',...
          i - ana.Nana, out.name{i}, out.unit{i}, out.z(i) * b(i), out.f(i) * b(i),  ...
         (out.z(i) - out.f(i)) * b(i), out.s(i))
 end
 disp('  |_______________________________________________________________________________________|') 
 
%--------------------------------------------------------------------------

