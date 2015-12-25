function vec_TruncLogNormalRVs = TruncLogNRnd( nVar, mu, sigma, LB, UB )
%TruncLogNRnd returns a vector of random variables sampled from a truncated
%lognormal distribution.  This function requires the user to specify the
%number of random values, parameters mu and sigma for a lognormal
%distribution as defined in Matlab, and lower and upper bounds, LB and
%UB, respectively.
%  

vec_TruncLogNormalRVs = zeros(nVar, 1);
nReplacementCount = 0;     % counts the number of resampled values

for i = 1:nVar
    vec_TruncLogNormalRVs(i) = lognrnd(mu, sigma);
    while vec_TruncLogNormalRVs(i) < LB || vec_TruncLogNormalRVs(i) > UB
        % replace current value with another value from lognrnd
        nReplacementCount = nReplacementCount+1;
        vec_TruncLogNormalRVs(i) = lognrnd(mu, sigma);
    end    % end while
end    % end for
        
%fprintf('in TruncLogNRnd - mu = %-6.2f, sigma = %-4.3f, nReplacementCount = %3i\n',...
%    mu, sigma, nReplacementCount);

end

