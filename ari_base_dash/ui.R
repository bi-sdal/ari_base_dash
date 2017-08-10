library(leaflet)

# Choices for drop-downs
# format in list:  "Name to Appear on Dashboard" = "variable_name_in_dataset",
vars <- c(
    "Percent With Less Than High School Diploma" = "less_than_high_school",
    "Percent With Only High School Diplomas" = "high_school_grad",
    "Percent With Some Bachelors or Associates" = "some_bachelors_or_associate",
    "Percent With Bachelors Degree or Higher" = "bachelors_degree_or_higher",
    "Percent With Bachelors Degree or Higher" = "bachelors_degree_or_higher",
    "Percent With Children Under 18" = "with_children_under_18",
    "Percent Without Children Under 18" = "without_children_under_18",
    "Percent With Income Below Poverty Line" = "income_below_poverty",
    "Percent With Income Above Poverty Line" = "income_above_poverty",
    "Percent Who Drive Alone to Work" = "drove_alone",
    "Percent Who Carpooled to Work" = "carpooled",
    "Percent Who Use Public Transportation to Work" = "public_transportation",
    "Percent Who Walked to Work" = "walked",
    "Percent Whow Used Other Transportation to Work" = "taxi_motorcycle_bike_other",
    "Percent Who Worked From Home" = "worked_from_home",
    "Percent Never Married" = "never_married",
    "Percent Now Married" = "now_married",
    "Percent Widowed" = "widowed",
    "Percent Divorced" = "divorced",
    "Percent Female" = "female",
    "Percent Male" = "male",
    "Percent White" = "white_alone",
    "Percent Black/African American" = "black_or_african_american_alone",
    "Percent Asian" = "asian_alone",
    "Percent Native Hawaiian or Pacifica Islander" = "native_hawaiian_and_other_pacific_islander_alone",
    "Percent American Indian"="american_indian_and_alaskan_native_alone",
    "Percent Other Race" = "some_other_race_alone",
    "Percent Two or More Races" = "two_or_more_races",
    "Percent Hispanic or Latino" = "hispanic_or_latino",
    "Percent With Government Assistance" = "living_with_supplementary_security_income_cash_public_assistance_income_foodstamps",
    "Percent Without Government Assistance" = "living_without_supplementary_security_income_cash_public_assistance_income_foodstamps",
    "Percent Veterans" = "veteran",
    "Percent Unemployed" = "unemployment_rate",
    "Percent in Armed Forces" = "armed_forces"

)

vars2 <- c(
    "Aberdeen Proving Ground" = "Aberdeen Proving Ground",
    "Aliamanu Military Reservation" = "Aliamanu Military Reservation",
    "Allen Stagefield"="Allen Stagefield",
    "Anniston Army Depot"="Anniston Army Depot",
    "Arlington National Cemetery"="Arlington National Cemetery",
    "Blossom Point Research Facility"="Blossom Point Research Facility",
    "Blue Grass Army Depot"="Blue Grass Army Depot",
    "Brown Stagefield"="Brown Stagefield",
    "Cairns Basefield" = "Cairns Basefield",
    "Carlisle Barracks" = "Carlisle Barracks",
    "Defense Distrib Depot Susq" = "Defense Distrib Depot Susq",
    "Defense Distribution Region West Sharpe Site"="Defense Distribution Region West Sharpe Site",
    "Defense Distribution Region West Tracy"="Defense Distribution Region West Tracy",
    "Defense General Supply Center"="Defense General Supply Center",
    "Defense Supply Center Columbus"="Defense Supply Center Columbus",
    "Deseret Chemical Depot"="Deseret Chemical Depot",
    "Detroit Arsenal"="Detroit Arsenal",
    "Dugway Proving Ground"="Dugway Proving Ground",
    "Fort A P Hill"="Fort A P Hill",
    "Fort Belvoir"="Fort Belvoir",
    "Fort Benning"="Fort Benning",
    "Fort Benning GA"="Fort Benning GA",
    "Fort Bliss"="Fort Bliss",
    "Fort Bragg"="Fort Bragg",
    "Fort Campbell"="Fort Campbell",
    "Fort Carson"="Fort Carson",
    "Fort De Russy"="Fort De Russy",
    "Fort Detrick"="Fort Detrick",
    "Fort Detrick Forest Glen Annex"="Fort Detrick Forest Glen Annex",
    "Fort Drum"="Fort Drum",
    "Fort George G Meade"="Fort George G Meade",
    "Fort Gordon"="Fort Gordon",
    "Fort Greely"="Fort Greely",
    "Fort Hamilton"="Fort Hamilton",
    "Fort Hood"="Fort Hood",
    "Fort Huachuca"="Fort Huachuca",
    "Fort Jackson"="Fort Jackson",
    "Fort Knox"="Fort Knox",
    "Fort Leavenworth"="Fort Leavenworth",
    "Fort Lee"="Fort Lee",
    "Fort Leonard Wood"="Fort Leonard Wood",
    "Fort Lesley J McNair"="Fort Lesley J McNair",
    "Fort Lewis"="Fort Lewis",
    "Fort Monroe"="Fort Monroe",
    "Fort Myer"="Fort Myer",
    "Fort Polk"="Fort Polk",
    "Fort Riley"="Fort Riley",
    "Fort Rucker"="Fort Rucker",
    "Fort Shafter"="Fort Shafter",
    "Fort Sill"="Fort Sill",
    "Fort Stewart"="Fort Stewart",
    "Fort Wainwright"="Fort Wainwright",
    "Goldberg Stagefield"="Goldberg Stagefield",
    "Green River Test Complex"="Green River Test Complex",
    "Hawthorne Army Depot"="Hawthorne Army Depot",
    "Helemano Military Reservation"="Helemano Military Reservation",
    "Highbluff Stagefield"="Highbluff Stagefield",
    "Holston AAP"="Holston AAP",
    "Hunt Stagefield"="Hunt Stagefield",
    "Iowa AAP"="Iowa AAP",
    "Kahuku Training Area"="Kahuku Training Area",
    "Kawaihae Military Reserve"="Kawaihae Military Reserve",
    "Kilauea Military Reserve"="Kilauea Military Reserve",
    "Lake City AAP"="Lake City AAP",
    "Letterkenny Army Depot"="Letterkenny Army Depot",
    "Makua Military Reserve"="Makua Military Reserve",
    "McAlester AAP"="McAlester AAP",
    "Milan AAP"="Milan AAP",
    "Military Ocean Terminal Concord"="Military Ocean Terminal Concord",
    "Military Ocean Tml Sunny Point"="Military Ocean Tml Sunny Point",
    "NTC and Fort Irwin"="NTC and Fort Irwin",
    "Picatinny Arsenal"="Picatinny Arsenal",
    "Pine Bluff Arsenal"="Pine Bluff Arsenal",
    "Pohakuloa Training Area"="Pohakuloa Training Area",
    "Presidio Of Monterey"="Presidio Of Monterey",
    "Pueblo Chemical Depot"="Pueblo Chemical Depot",
    "Pupukea Paalaa Uka Mil Road"="Pupukea Paalaa Uka Mil Road",
    "Radford AAP"="Radford AAP",
    "Red River Army Depot"="Red River Army Depot",
    "Redstone Arsenal"="Redstone Arsenal",
    "Rock Island Arsenal"="Rock Island Arsenal",
    "Schofield Bks Military Reservation"="Schofield Bks Military Reservation",
    "Scranton AAP"="Scranton AAP",
    "Shell Basefield"="Shell Basefield",
    "Sierra Army Depot"="Sierra Army Depot",
    "Skelly Stagefield"="Skelly Stagefield",
    "Stewart Annex"="Stewart Annex",
    "Stinson Stagefield"="Stinson Stagefield",
    "Tobyhanna Army Depot"="Tobyhanna Army Depot",
    "Tooele Army Depot"="Tooele Army Depot",
    "Toth Stagefield"="Toth Stagefield",
    "Tripler AMC"="Tripler AMC",
    "Umatilla Chem Depot"="Umatilla Chem Depot",
    "US Army Joint Sys Mfg Ctr Lima"="US Army Joint Sys Mfg Ctr Lima",
    "US Army Soldier Systems Center Natick"="US Army Soldier Systems Center Natick",
    "USA Adelphi Laboratory Ctr"="USA Adelphi Laboratory Ctr",
    "USA Field Station Kunia"="USA Field Station Kunia",
    "Waianae-Kai Military Reservation"="Waianae-Kai Military Reservation",
    "Walter Reed AMC Main Post"="Walter Reed AMC Main Post",
    "Watervliet Arsenal"="Watervliet Arsenal",
    "West Point Mil Reservation"="West Point Mil Reservation",
    "Wheeler Army Airfield"="Wheeler Army Airfield",
    "White Sands Missile Range"="White Sands Missile Range",
    "Yakima Training Center"="Yakima Training Center",
    "Yuma Proving Ground"="Yuma Proving Ground"
)

navbarPage(
    "Base", id = "nav",
    tabPanel(
        "Interactive map",
        div(class = "outer",
            tags$head(
                # Include our custom CSS
                includeCSS("styles.css"),
                includeScript("gomap.js")
            ),

            leafletOutput("map", width = "100%", height = "100%"),
            #creates panel
            absolutePanel(
                id = "controls",class = "panel panel-default", fixed = TRUE,
                draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                width = 400, height = 1000,

                #title dropdown
                h2("Army Installation Explorer"),

                #create dropdown menus
                selectInput("color", "Color", vars),

                selectInput("location", "Location", vars2),
                #create radio buttons
                radioButtons(
                    "plots", "Compare To:",
                    c("Surrounding County",
                      "Selected Large Bases (population > 50,000)",
                      "Selected Medium-Large Bases (population 25,000- 50,000)",
                      "Selected Medium-Small Bases (population 10,000-25,000)",
                      "Selected Small Bases (population < 10,000)")),

                conditionalPanel(
                    "input.color == 'base'",
                    # Only prompt for threshold when coloring or sizing by superzip
                    numericInput("threshold", "SuperZIP threshold (top n percentile)", 5)
                ),

                plotOutput("plot", height = c(400))
                #plotOutput("scatterCollegeIncome", height = 250)
            ), # this is the end to the absolutePanel
            #create text citation
            tags$div(
                id = "cite",
                '------------------------------------Data Source:',
                tags$em('American Community Survey, 2015'),
                ' U.S. Census Bureau.'
            )
        )
    ),
    tabPanel("Data explorer",
             fluidRow(DT::dataTableOutput('tbl')))
)
