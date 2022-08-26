#setwd("D:/Escritorio/Shiny del sabado/Shiny")

function(input, output) {
  
  posiciones_probs <- reactive({
    
    esce_rest <- allcombi2 %>%
      filter(m6%in%input$w6 &
             m7%in%input$w7 &
             m8%in%input$w8 &
             m9%in%input$w9 &
             m10%in%input$w10 &
             m11%in%input$w11 &
             m12%in%input$w12 &
             m13%in%input$w13 &
             m14%in%input$w14 &
             m15%in%input$w15 ) %>%
      select(seq) %>%
      pull()
    
    rank_tofilter <- w8_agr_rank_t[c(esce_rest),]
    
    #####
    
    rkfull_temporal <- rank_tofilter %>%
      group_by(AST) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","AST"))
    
    posiciones <- merge(x = posiciones_v, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    #####
    rkfull_temporal <- rank_tofilter %>%
      group_by(BDS) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","BDS"))
    
    posiciones <- merge(x = posiciones, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    ###
    rkfull_temporal <- rank_tofilter %>%
      group_by(FNC) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","FNC"))
    
    posiciones <- merge(x = posiciones, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    ###
    rkfull_temporal <- rank_tofilter %>%
      group_by(G2) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","G2"))
    
    posiciones <- merge(x = posiciones, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    ###
    rkfull_temporal <- rank_tofilter %>%
      group_by(MAD) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","MAD"))
    
    posiciones <- merge(x = posiciones, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    ###
    rkfull_temporal <- rank_tofilter %>%
      group_by(MSF) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","MSF"))
    
    posiciones <- merge(x = posiciones, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    ###
    rkfull_temporal <- rank_tofilter %>%
      group_by(RGE) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","RGE"))
    
    posiciones <- merge(x = posiciones, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    ###
    rkfull_temporal <- rank_tofilter %>%
      group_by(SK) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","SK"))
    
    posiciones <- merge(x = posiciones, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    ###
    rkfull_temporal <- rank_tofilter %>%
      group_by(VIT) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","VIT"))
    
    posiciones <- merge(x = posiciones, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    ###
    rkfull_temporal <- rank_tofilter %>%
      group_by(XL) %>%
      summarise(n())
    rkfull_temporal <- setNames(rkfull_temporal,c("Posicion","XL"))
    
    posiciones <- merge(x = posiciones, y = rkfull_temporal, by = c("Posicion"), all.x = TRUE)
    #####
    # Operar freq ####
    
    # Malla completa
    posiciones_probs <- round((posiciones/nrow(rank_tofilter)),15)
    posiciones_probs$Posicion <- seq(1:10)
    
    #print(nrow(rank_tofilter))
    # Malla de playoffs
    posiciones_probs$Playoffs <- case_when(
      posiciones_probs$Posicion > 6 ~ "No",
      posiciones_probs$Posicion <= 6 ~ "Si"
    )
    
    posiciones_probs[is.na(posiciones_probs)] <- 0
    
    return(as.data.frame(posiciones_probs))
  })
  
  df_playoffs_filtrados <- reactive({
    df_playoffs <- posiciones_probs() %>% 
          group_by(Playoffs) %>%
          summarise(across(everything(), sum))

        df_playoffs <- df_playoffs[order(df_playoffs$Playoffs, decreasing = TRUE),]
        df_playoffs_filtrados <- df_playoffs[-2]
        return(as.data.frame(df_playoffs_filtrados))
    })
  
  #####
  
  df_sunburst_graph <- reactive ({
  vals_tree <- c(0,
                 posiciones_probs()$AST*100,
                 posiciones_probs()$BDS*100,
                 posiciones_probs()$FNC*100,
                 posiciones_probs()$G2*100,
                 posiciones_probs()$MAD*100,
                 posiciones_probs()$MSF*100,
                 posiciones_probs()$RGE*100,
                 posiciones_probs()$SK*100,
                 posiciones_probs()$VIT*100,
                 posiciones_probs()$XL*100,
                 teams_list_tree_vals)
  df_sunburst <- data.frame(
    parents = posiciones_tree,
    labels = equipos_tree,
    value = vals_tree
  )
  
  df_sunburst_graph <- data.tree::FromDataFrameNetwork(df_sunburst)
  return(df_sunburst_graph)
  })
  
  output$plot_1 <- renderEcharts4r({
    df_sunburst_graph() |>
      e_charts() |>
      e_sunburst() |> 
      e_theme("chalk")  |>
      e_tooltip(trigger = "item") 
    
  })
  
  #####
  df_sunburst_graph2 <- reactive ({
    # vals_tree_2 <- c(0,
    #                  teams_list_tree_vals,
    #                  df_playoffs_filtrados()$AST*100,
    #                  df_playoffs_filtrados()$BDS*100,
    #                  df_playoffs_filtrados()$FNC*100,
    #                  df_playoffs_filtrados()$G2*100,
    #                  df_playoffs_filtrados()$MAD*100,
    #                  df_playoffs_filtrados()$MSF*100,
    #                  df_playoffs_filtrados()$RGE*100,
    #                  df_playoffs_filtrados()$SK*100,
    #                  df_playoffs_filtrados()$VIT*100,
    #                  df_playoffs_filtrados()$XL*100,
    #                posiciones_probs()$AST*100,
    #                posiciones_probs()$BDS*100,
    #                posiciones_probs()$FNC*100,
    #                posiciones_probs()$G2*100,
    #                posiciones_probs()$MAD*100,
    #                posiciones_probs()$MSF*100,
    #                posiciones_probs()$RGE*100,
    #                posiciones_probs()$SK*100,
    #                posiciones_probs()$VIT*100,
    #                posiciones_probs()$XL*100
    #                )
    vals_tree_2 <- c(0,
                     teams_list_tree_vals,
                     #rep(c(60,40),10),
                     df_playoffs_filtrados()$AST*100,
                     df_playoffs_filtrados()$BDS*100,
                     df_playoffs_filtrados()$FNC*100,
                     df_playoffs_filtrados()$G2*100,
                     df_playoffs_filtrados()$MAD*100,
                     df_playoffs_filtrados()$MSF*100,
                     df_playoffs_filtrados()$RGE*100,
                     df_playoffs_filtrados()$SK*100,
                     df_playoffs_filtrados()$VIT*100,
                     df_playoffs_filtrados()$XL*100,                    
                     #rep(10,100)
                     posiciones_probs()$AST*100,
                     posiciones_probs()$BDS*100,
                     posiciones_probs()$FNC*100,
                     posiciones_probs()$G2*100,
                     posiciones_probs()$MAD*100,
                     posiciones_probs()$MSF*100,
                     posiciones_probs()$RGE*100,
                     posiciones_probs()$SK*100,
                     posiciones_probs()$VIT*100,
                     posiciones_probs()$XL*100
                     #rep(10,90)
    )
    df_sunburst <- data.frame(
      parents = posiciones_tree_2,
      labels = equipos_tree_2,
      value = vals_tree_2
    )
    
    df_sunburst_graph <- data.tree::FromDataFrameNetwork(df_sunburst)
    return(df_sunburst_graph)
  })
  #####
  
  #my_colors <- paletteer::paletteer_d("ggthemes::Classic_10")[c(1:10)] 
  my_colors <- c("black","red","#e4007c","orange","white","gold","brown","#0061a9","gray","yellow","green")
  output$plot_2 <- renderEcharts4r({
    df_sunburst_graph2() |>
      e_charts() |>
      e_sunburst() |>   
      e_color(my_colors) |>
      #e_theme("chalk")  |>
      e_tooltip(trigger = "item")
   
  })
  
  options(reactable.theme = reactableTheme(
    color = "hsl(233, 9%, 87%)",
    backgroundColor = "hsl(233, 9%, 19%)",
    borderColor = "hsl(233, 9%, 22%)",
    stripedColor = "hsl(233, 12%, 22%)",
    highlightColor = "hsl(233, 12%, 24%)",
    inputStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
    selectStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
    pageButtonHoverStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
    pageButtonActiveStyle = list(backgroundColor = "hsl(233, 9%, 28%)")
  ))
  
  output$tbl1 <- renderReactable({
    reactable(posiciones_probs()[-12],
              highlight = TRUE, striped = TRUE, outlined = TRUE, borderless = TRUE,
              columns = list(
              Posicion = colDef(name = "Ranking"),
              AST = colDef(format = colFormat(percent = TRUE, digits = 2)),
              BDS = colDef(format = colFormat(percent = TRUE, digits = 2)),
              FNC = colDef(format = colFormat(percent = TRUE, digits = 2)),
              G2 = colDef(format = colFormat(percent = TRUE, digits = 2)),
              MAD = colDef(format = colFormat(percent = TRUE, digits = 2)),
              MSF = colDef(format = colFormat(percent = TRUE, digits = 2)),
              RGE = colDef(format = colFormat(percent = TRUE, digits = 2)),
              SK = colDef(format = colFormat(percent = TRUE, digits = 2)),
              VIT = colDef(format = colFormat(percent = TRUE, digits = 2)),
              XL = colDef(format = colFormat(percent = TRUE, digits = 2))
              ))
  })
  
  output$tbl2 <- renderReactable({
    reactable(df_playoffs_filtrados(),
              highlight = TRUE, striped = TRUE, outlined = TRUE, borderless = TRUE,
              columns = list(
              AST = colDef(format = colFormat(percent = T, digits = 2)),
              BDS = colDef(format = colFormat(percent = TRUE, digits = 2)),
              FNC = colDef(format = colFormat(percent = TRUE, digits = 2)),
              G2 = colDef(format = colFormat(percent = TRUE, digits = 2)),
              MAD = colDef(format = colFormat(percent = TRUE, digits = 2)),
              MSF = colDef(format = colFormat(percent = TRUE, digits = 2)),
              RGE = colDef(format = colFormat(percent = TRUE, digits = 2)),
              SK = colDef(format = colFormat(percent = TRUE, digits = 2)),
              VIT = colDef(format = colFormat(percent = TRUE, digits = 2)),
              XL = colDef(format = colFormat(percent = TRUE, digits = 2)),
              Playoffs = colDef(cell = function(value) {
                # Render as an X mark or check mark
                if (value == "No") "\u274c No" else "\u2714\ufe0f Si"
              })
              ))
  })
  
  esc_restantes <- reactive({
    
    esce_rest <- allcombi2 %>%
      filter(m6%in%input$w6 &
               m7%in%input$w7 &
               m8%in%input$w8 &
               m9%in%input$w9 &
               m10%in%input$w10 &
               m11%in%input$w11 &
               m12%in%input$w12 &
               m13%in%input$w13 &
               m14%in%input$w14 &
               m15%in%input$w15 ) %>%
      select(seq) %>%
      pull()
  })
  
  output$box_1 <- renderInfoBox({
    infoBox(
      paste0(" "), value = length(esc_restantes()), icon = icon("info-sign", lib = "glyphicon"),
      color = "navy", fill = TRUE
    )
    
  })
}