#source(Data)
#setwd("C:/Data_Scientist/Cours/Developing Data Products/UN_COMTRADE")
#list.files("C:/Data_Scientist/Cours/Developing Data Products/UN_COMTRADE")
library(shiny)
df1<-load("US_Trade.RData")
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


