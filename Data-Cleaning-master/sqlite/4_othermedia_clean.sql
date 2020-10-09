UPDATE market SET OtherMedia ="" WHERE FMID IN (SELECT FMID FROM market WHERE OtherMedia = Website AND Othermedia != "");
UPDATE market SET OtherMedia ="" WHERE FMID IN (SELECT FMID FROM market WHERE OtherMedia = Facebook AND Othermedia != "");
UPDATE market SET OtherMedia ="" WHERE FMID IN (SELECT FMID FROM market WHERE OtherMedia = Twitter AND Othermedia != "");
UPDATE market SET OtherMedia ="" WHERE FMID IN (SELECT FMID FROM market WHERE OtherMedia = Youtube AND Othermedia != "");