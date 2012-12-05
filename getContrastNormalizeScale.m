function scale = getContrastNormalizeScale(input)
     meanAbs = abs(mean(input(:)));
     epsilon = 0.0001;
     scale = meanAbs+epsilon;
end