#Example1:
#Using default parameters (i.e., latest annual HS total trade data flows, in json format),
# specifying only reporting and partner areas
setwd("C:/Data_Scientist/Cours/Developing Data Products/UN_COMTRADE")
source(getcomtrade.r)
library("rjson")

s10 <- get.Comtrade(r="842", cc="AG2", ps="2012", p="All", fmt="csv")
s11 <- get.Comtrade(r="842", cc="AG2", ps="2013", p="All", fmt="csv")
s12 <- get.Comtrade(r="842", cc="AG2", ps="2012", p="All", fmt="csv")
s13 <- get.Comtrade(r="842", cc="AG2", ps="2013", p="All", fmt="csv")
s14 <- get.Comtrade(r="842", cc="AG2", ps="2014", p="All", fmt="csv")
s15 <- get.Comtrade(r="842", cc="AG2", ps="2015", p="All", fmt="csv")

s16 <- get.Comtrade(r="842", cc="AG2", ps="2016", p="All", fmt="csv")
s17 <- get.Comtrade(r="842", cc="AG2", ps="2017", p="All", fmt="csv")
s18 <- get.Comtrade(r="842", cc="AG2", ps="2018", p="All", fmt="csv")
s19 <- get.Comtrade(r="842", cc="AG2", ps="2019", p="All", fmt="csv")

US2010<-as.data.frame(s12$data)
US2011<-as.data.frame(s13$data)
US2012<-as.data.frame(s12$data)
US2013<-as.data.frame(s13$data)
US2014<-as.data.frame(s14$data)
US2015<-as.data.frame(s15$data)
US2016<-as.data.frame(s16$data)
US2017<-as.data.frame(s17$data)
US2018<-as.data.frame(s18$data)
US2019<-as.data.frame(s19$data)

US_Trade<-rbind(US2010,US2011,US2012,US2013,US2014,US2015,US206,US2017,US2018,US2019)
save(df1,file="US_Trade.RData")
