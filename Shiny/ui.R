#setwd("D:/Escritorio/Shiny del sabado/Shiny")



dashboardPage(skin = "black",
              ################################################################################
              dashboardHeader(title = "Superweek LEC",
                              dropdownMenu(
                                type = "messages",
                                messageItem(
                                  from="Juanjo MZ",
                                  message = ":)",
                                  icon = shiny::icon("twitter"),
                                  href = "https://twitter.com/mz_juanjo"
                                )
                              )),
              dashboardSidebar(collapsed = T,
                sidebarMenu(
                   menuItem("Classification", tabName = "clasificarse", icon = icon("th")),
                   menuItem("Matchday 16", tabName = "j16", icon = icon("calendar"))
                )
              ),
              
              dashboardBody(
                tags$head(
                  # Note the wrapping of the string in HTML()
                  tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
      body {
        background-color: black;
        color: white;
      }
      .content-wrapper {
        background-color: black;
      }
      h2 {
        font-family: 'Yusei Magic', sans-serif;
      }
      h4 {
        font-family: 'Yusei Magic', sans-serif;
      }
      h3 {
        font-family: 'Yusei Magic', sans-serif;
      }
      .well{background-color: black;}
      .shiny-input-container {
        color: #474747;
      }"))
                ),
      tabItems(
                tabItem(tabName = "clasificarse",
                        fluidPage(
                          column(2, style = "height = 550;",
                          br(""),
                          br(""),
                          br(""),
                                 wellPanel(
                                   h5("Choose the winner of each match:"),
                                   # box(title = "Domingo",solidHeader = TRUE,collapsible = TRUE,collapsed=T,
                                   #     pickerInput("w1", label = h3("M1"),
                                   #                 choices = m1, 
                                   #                 select = m1,
                                   #                 options = list(`actions-box` = TRUE), multiple = T),
                                   #     pickerInput("w2", label = h3("M2"),
                                   #                 choices = m2, 
                                   #                 selected = m2,
                                   #                 options = list(`actions-box` = TRUE), multiple = T),
                                   #     pickerInput("w3", label = h3("M3"),
                                   #                 choices = m3, 
                                   #                 selected = m3,
                                   #                 options = list(`actions-box` = TRUE), multiple = T),
                                   #     pickerInput("w4", label = h3("M4"),
                                   #                 choices = m4, 
                                   #                 selected = m4,
                                   #                 options = list(`actions-box` = TRUE), multiple = T),
                                   #     pickerInput("w5", label = h3("M5"),
                                   #                 choices = m5, 
                                   #                 selected = m5,
                                   #                 options = list(`actions-box` = TRUE), multiple = T),
                                   #     width="100%"),
                          box(title = "Saturday",solidHeader = TRUE,collapsible = TRUE,collapsed=T,
                          pickerInput("w6", label = h3("M6"),
                                       #choices = m6, 
                                      choices = "BDS",
                                       select = m6,
                                       options = list(`actions-box` = TRUE), multiple = T),
                          pickerInput("w7", label = h3("M7"),
                                       #choices = m7,
                                      choices = "XL",
                                       selected = m7,
                                      options = list(`actions-box` = TRUE), multiple = T),
                          pickerInput("w8", label = h3("M8"),
                                       #choices = m8, 
                                      choices = "MAD",
                                       selected = m8,
                                      options = list(`actions-box` = TRUE), multiple = T),
                          pickerInput("w9", label = h3("M9"),
                                       choices = m9, 
                                       selected = m9,
                                      options = list(`actions-box` = TRUE), multiple = T),
                          pickerInput("w10", label = h3("M10"),
                                       choices = m10, 
                                       selected = m10,
                                      options = list(`actions-box` = TRUE), multiple = T),
                          width="100%"),
                          box(title = "Sunday",solidHeader = TRUE,collapsible = TRUE,collapsed=T,
                          pickerInput("w11", label = h3("M11"),
                                       choices = m11, 
                                       selected = m11,
                                      options = list(`actions-box` = TRUE), multiple = T),
                          pickerInput("w12", label = h3("M12"),
                                       choices = m12, 
                                       selected = m12,
                                      options = list(`actions-box` = TRUE), multiple = T),
                          pickerInput("w13", label = h3("M13"),
                                       choices = m13, 
                                       selected = m13,
                                      options = list(`actions-box` = TRUE), multiple = T),
                          pickerInput("w14", label = h3("M14"),
                                       choices = m14, 
                                       selected = m14,
                                      options = list(`actions-box` = TRUE), multiple = T),
                          pickerInput("w15", label = h3("M15"),
                                       choices = m15, 
                                       selected = m15,
                                      options = list(`actions-box` = TRUE), multiple = T),
                          width="100%"),
                          h5("Remaining scenarios*:"),
                          infoBoxOutput("box_1", width="100%"),
                          h6("*Scenarios from matchday 16 and subsequent matches where a winner was selected")
                                 ),
                          h6("Note: The odds are calculated without separating the tiebreakers")
                          ),
                          column(10,
                          h3("Odds of occupying a certain position in the 2022 LEC regular season in the summer at the end of J18", align = "center"),
                          br(""),
                          h3("Odds of making the Playoffs at the end of J18", align = "center"),
                          #echarts4rOutput("plot_1"),
                          echarts4rOutput("plot_2"),
                          h6("Click on the graph to show more details", align = "right"),
                          reactableOutput("tbl1"),
                          br(""),
                          h3("Odds of making the Playoffs at the end of J18", align = "center"),
                          reactableOutput("tbl2"),
                          br(""),
                          )
                        )
                ),
      tabItem(tabName = "j16",
              fluidPage(
                h2("Situation of the league at the end of Matchday 16", align = "center"),
                HTML('<center><img src="Tabla de posiciones j16.png" height = "500" width="400"></center>'),
                br(""),
                HTML('<center><img src="enfrentamientos j16.png" height = "500" width="1000"></center>')
              ),
              h4("For additional information, please refer to the following links:"),
              br(""),
              tags$a(href="https://lol.fandom.com/wiki/LEC/2022_Season/Summer_Season", "LEC 2022 Summer, Fuente: Leaguepedia | League of Legends Esports Wiki - Fandom"),
              br(""),
              tags$a(href="https://lolesports.com/article/lec-and-regional-leagues---ruleset/blt810b4a120ec4ecda", "Reglas para determinar clasificaciones y desempates")
              )
              
)
)
)
#
