SELECT FMID, Season1StartDate, Season1EndDate FROM market WHERE Season1StartDate> Season1EndDate 
AND Season1EndDate != ""
AND printf("%d", Season1StartDate)!= "0";