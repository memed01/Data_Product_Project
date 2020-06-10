source(getcomtrade.r)
library("rjson")

s10 <- get.Comtrade(r="842", cc="AG2", ps="2010", p="All", fmt="csv")
s11 <- get.Comtrade(r="842", cc="AG2", ps="2011", p="All", fmt="csv")
s12 <- get.Comtrade(r="842", cc="AG2", ps="2012", p="All", fmt="csv")
s13 <- get.Comtrade(r="842", cc="AG2", ps="2013", p="All", fmt="csv")
s14 <- get.Comtrade(r="842", cc="AG2", ps="2014", p="All", fmt="csv")
s15 <- get.Comtrade(r="842", cc="AG2", ps="2015", p="All", fmt="csv")

s16 <- get.Comtrade(r="842", cc="AG2", ps="2016", p="All", fmt="csv")
s17 <- get.Comtrade(r="842", cc="AG2", ps="2017", p="All", fmt="csv")
s18 <- get.Comtrade(r="842", cc="AG2", ps="2018", p="All", fmt="csv")
s19 <- get.Comtrade(r="842", cc="AG2", ps="2019", p="All", fmt="csv")

US2010<-as.data.frame(s10$data)
US2011<-as.data.frame(s11$data)
US2012<-as.data.frame(s12$data)
US2013<-as.data.frame(s13$data)
US2014<-as.data.frame(s14$data)
US2015<-as.data.frame(s15$data)
US2016<-as.data.frame(s16$data)
US2017<-as.data.frame(s17$data)
US2018<-as.data.frame(s18$data)
US2019<-as.data.frame(s19$data)

#ps10 = toString(2010:2019)
#s10 <- get_comtrade(r = "156", ps = ps10, p = "All",fmt="csv")

df1<-rbind(US2010,US2011,US2012,US2013,US2014,US2015,US2016,US2017,US2018,US2019)

#setwd("C:/Data_Scientist/Cours/Developing Data Products/UN_COMTRADE")
#list.files("C:/Data_Scientist/Cours/Developing Data Products/UN_COMTRADE")
library(shiny)
#load("US_Trade.RData")
df1<-df1[order(df1$US_Trade.value, decreasing = TRUE),]
Limp<-df1[df1$TradeFlow == "Import",]
Lexp<-df1[df1$TradeFlow == "Export",]

shinyServer(function(input, output) {

data1<- reactive({
                  data1<-  df1[which(df1$Year >= input$range[1]& df1$Year<= input$range[2]
                    & df1$USPartner == input$Country_var
                    & df1$TradeFlow == input$Trade_Flow),]
                    })

output$table<-renderDataTable(
{tabprod<-aggregate(data.frame(data1()$US_Trade.value), by = list(Commodity=data1()$Commodity ),
 FUN = function(x){return(c(round(sum(x),2)))})
 tabprod<-tabprod[order(tabprod[2],decreasing=TRUE),]}, options =list(pageLength = input$obs))

#output$table<-renderDataTable(
#{data1()[,c("Commodity","US_Trade.value")]}, options =list(pageLength = input$obs))

output$downloadBest<- downloadHandler(
filename = 'data.csv',
content = function(file) {
write.csv(tabprod(), file,row.names=FALSE)})

Imp<-reactive({
                    tr1<-Limp[which(Limp$Year >= input$range[1]& Limp$Year<= input$range[2]
                     & Limp$USPartner == input$Country_var),]
                     })
Exp<-reactive({
                    tr1<-Lexp[which(Lexp$Year >= input$range[1]& Lexp$Year<= input$range[2]
                     & Lexp$USPartner == input$Country_var),]
                     })
output$TradeBal <- renderPrint({
if (sum(Exp()[,5])-sum(Imp()[,5])>=0)
       print(paste("Between USA and", input$Country_var, "US Exports cover US Import,",
       "and Trade surplus (Millions $) is:"))
       
    
else { print(paste("Between USA and", input$Country_var, "US Exports don't cover US Import,",
       "and Trade deficit (Millions $) is:"))
     }
                       
})

output$TB<- renderText({
sum(Exp()[,5])-sum(Imp()[,5])
})

})


