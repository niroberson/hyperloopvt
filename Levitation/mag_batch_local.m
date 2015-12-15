%% PRIME_BATCH_LOCAL uses the BATCH command to run the PRIME code locally.
%
%  Discussion:
%
%    The PRIME code is a function, so first we must write a script
%    called PRIME_SCRIPT that runs the function.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    4 September 2013 by Justin Krometis
%
%  Author:
%
%    John Burkardt
%
  clear

  fprintf ( 1, '\n' );
%
%  BATCH defines the job and sends it for execution.
%
  my_job = batch ( 'SweepForce', 'Profile', 'local' , 'Matlabpool', 7);
%
%  WAIT pauses the MATLAB session til the job completes.
%
  wait ( my_job );
%
%  DIARY displays any messages printed during execution.
%
  diary ( my_job );
%
%  LOAD makes the script's workspace available.
%
%  total = total number of primes.
%
  load ( my_job );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Total number of primes = %d\n', total );
%
%  These commands clean up data about the job we no longer need.
%
%  destroy ( my_job ); %Use destroy() for R2011b or earlier
  delete ( my_job ); %Use delete() for R2012a or later

  fprintf ( 1, '\n' );
  fprintf ( 1, 'PRIME_BATCH_LOCAL\n' );
  fprintf ( 1, '  Normal end of execution.\n' );
