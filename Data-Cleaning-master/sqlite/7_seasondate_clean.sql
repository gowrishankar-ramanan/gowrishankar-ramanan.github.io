UPDATE market SET Season1StartDate = Season1Enddate, Season1EndDate = Season1StartDate
WHERE FMID = (SELECT FMID FROM market WHERE Season1StartDate> Season1EndDate 
AND Season1EndDate != ""
AND printf("%d", Season1StartDate)!= "0");