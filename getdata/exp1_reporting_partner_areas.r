#Example1:
#Using default parameters (i.e., latest annual HS total trade data flows, in json format),
# specifying only reporting and partner areas
setwd("C:/Data_Scientist/Cours/Developing Data Products/UN_COMTRADE")
source(getcomtrade.r)
library("rjson")
s7 <- get.Comtrade(r="842", cc="AG2", ps="2007", p="All", fmt="csv")
s8 <- get.Comtrade(r="842", cc="AG2", ps="2008", p="All", fmt="csv")
s9 <- get.Comtrade(r="842", cc="AG2", ps="2009", p="All", fmt="csv")
s10 <- get.Comtrade(r="842", cc="AG2", ps="2010", p="All", fmt="csv")

s1 <- get.Comtrade(r="842", cc="AG2", ps="2013", p="All", fmt="csv")
s0 <- get.Comtrade(r="842", cc="AG2", ps="2011", p="All", fmt="csv")
s2 <- get.Comtrade(r="842", cc="AG2", ps="2012", p="All", fmt="csv")
s3 <- get.Comtrade(r="842", cc="AG2", ps="2014", p="All", fmt="csv")

US2007<-as.data.frame(s7$data)
US2008<-as.data.frame(s8$data)
US2009<-as.data.frame(s9$data)
US2010<-as.data.frame(s10$data)
US2011<-as.data.frame(s0$data)
US2012<-as.data.frame(s2$data)
US2013<-as.data.frame(s1$data)

US_Trade<-rbind(US2007,US2008,US2009,US2010,US2011,US2012,US2013)
save(df1,file="US_Trade.RData")
