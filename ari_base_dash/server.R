library(shiny)
library(leaflet)
library(ggplot2)
library(htmltools)
library(DT)

shinyServer(function(input, output) {
    #create map
    output$map <- renderLeaflet({
        leaflet(data = df) %>%
            addTiles(
                urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
                attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
            ) %>%
            setView(lng = -93.85, lat = 37.45, zoom = 4)
    })

    # graph_df <- reactive({
    #   if(input$color=="less_than_high_school"||input$color=="high_school_grad"||input$color=="some_bachelors_or_associate"||input$color=="bachelors_degree_or_higher"){
    #   d <- graph[which(graph$Variable==input$color),]
    #   d
    #   }else{
    #     d <- 1
    #     1
    #   }
    # })

    dat_surrounding_county <- reactive({
        if(input$color=="less_than_high_school"||input$color=="high_school_grad"||input$color=="some_bachelors_or_associate"||input$color=="bachelors_degree_or_higher"){
            cols <- c("less_than_high_school","high_school_grad","some_bachelors_or_associate","bachelors_degree_or_higher")
        }else if(input$color=="with_children_under_18"||input$color=="without_children_under_18"){
            cols <- c("with_children_under_18", "without_children_under_18")
        }else if(input$color=="income_below_poverty"||input$color=="income_above_poverty"){
            cols <- c("income_below_poverty", "income_above_poverty")
        }else if(input$color=="drove_alone"||input$color=="carpooled"||input$color=="public_transportation"||input$color=="walked"||input$color=="taxi_motorcycle_bike_other"||input$color=="worked_from_home"){
            cols <- c("drove_alone", "carpooled","public_transportation","walked","taxi_motorcycle_bike_other","worked_from_home")
        }else if(input$color=="never_married"||input$color=="now_married"||input$color=="separated"||input$color=="widowed"||input$color=="divorced"){
            cols <- c("never_married", "now_married","separated","walked","widowed","divorced")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="hispanic_or_latino"){
            cols <- c("hispanic_or_latino","not_hispanic_or_latino")
        }else if(input$color=="living_with_supplementary_security_income_cash_public_assistance_income_foodstamps"||input$color=="living_without_supplementary_security_income_cash_public_assistance_income_foodstamps"){
            cols <- c("living_with_supplementary_security_income_cash_public_assistance_income_foodstamps","living_without_supplementary_security_income_cash_public_assistance_income_foodstamps")
        }else if(input$color=="veteran"){
            cols <- c("veteran","non_veteran")
        }else if(input$color=="male"|input$color=="female"){
            cols <- c("female","male")
        }else if(input$color=="unemployment_rate"){
            cols <- c("unemployment_rate")
        }else if(input$color=="armed_forces"){
            cols <- c("armed_forces")
        }

        base = df[which(df$base==input$location),]
        data = cbind("base average", base[,cols]) # base[, cols]
        colnames(data) <- c("location",cols)
        data_df <- as.data.frame(data)
        data.new <- tidyr::gather(data_df, group, y, -location)
        county_av= county[which(county$base==input$location),]
        data2 = cbind("county average", county_av[,cols])
        colnames(data2) <- c("location",cols)
        data_df2 <- as.data.frame(data2)
        data.new2 <- tidyr::gather(data_df2, group, y, -location)
        combine=rbind(data.new2, data.new)
        combine
    })

    dat_selected_large_bases <- reactive({
        if(input$color=="less_than_high_school"||input$color=="high_school_grad"||input$color=="some_bachelors_or_associate"||input$color=="bachelors_degree_or_higher"){
            cols <- c("less_than_high_school","high_school_grad","some_bachelors_or_associate","bachelors_degree_or_higher")
        }else if(input$color=="with_children_under_18"||input$color=="without_children_under_18"){
            cols <- c("with_children_under_18", "without_children_under_18")
        }else if(input$color=="income_below_poverty"||input$color=="income_above_poverty"){
            cols <- c("income_below_poverty", "income_above_poverty")
        }else if(input$color=="drove_alone"||input$color=="carpooled"||input$color=="public_transportation"||input$color=="walked"||input$color=="taxi_motorcycle_bike_other"||input$color=="worked_from_home"){
            cols <- c("drove_alone", "carpooled","public_transportation","walked","taxi_motorcycle_bike_other","worked_from_home")
        }else if(input$color=="never_married"||input$color=="now_married"||input$color=="separated"||input$color=="widowed"||input$color=="divorced"){
            cols <- c("never_married", "now_married","separated","walked","widowed","divorced")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="hispanic_or_latino"){
            cols <- c("hispanic_or_latino","not_hispanic_or_latino")
        }else if(input$color=="living_with_supplementary_security_income_cash_public_assistance_income_foodstamps"||input$color=="living_without_supplementary_security_income_cash_public_assistance_income_foodstamps"){
            cols <- c("living_with_supplementary_security_income_cash_public_assistance_income_foodstamps","living_without_supplementary_security_income_cash_public_assistance_income_foodstamps")
        }else if(input$color=="veteran"){
            cols <- c("veteran","non_veteran")
        }else if(input$color=="male"|input$color=="female"){
            cols <- c("female","male")
        }else if(input$color=="unemployment_status"){
            cols <- c("unemployment_status")
        }else if(input$color=="unemployment_rate"){
            cols <- c("unemployment_rate")
        }else if(input$color=="armed_forces"){
            cols <- c("armed_forces")
        }


        if(input$location=="Fort Lewis"){
            base_data = df[which(df$base==input$location|df$base=="Fort Knox"|df$base=="Tripler AMC"|df$base=="Helemano Military Reservation"|df$base=="Fort Hood"),]
        }else if(input$location=="Fort Knox"){
            base_data = df[which(df$base==input$location|df$base=="Fort Lewis"|df$base=="Tripler AMC"|df$base=="Helemano Military Reservation"|df$base=="Fort Hood"),]
        }else if(input$location=="Tripler AMC"){
            base_data = df[which(df$base==input$location|df$base=="Fort Lewis"|df$base=="Fort Knox"|df$base=="Helemano Military Reservation"|df$base=="Fort Hood"),]
        }else if(input$location=="Helemano Military Reservatioin"){
            base_data = df[which(df$base==input$location|df$base=="Fort Lewis"|df$base=="Fort Knox"|df$base=="Tripler AMC"|df$base=="Fort Hood"),]
        }else if(input$location=="Fort Hood"){
            base_data = df[which(df$base==input$location|df$base=="Fort Lewis"|df$base=="Fort Knox"|df$base=="Tripler AMC"|df$base=="Helemano Military Reservation"),]
        }
        else{base_data = df[which(df$base==input$location|df$base=="Fort Lewis"|df$base=="Fort Knox"|df$base=="Tripler AMC"|df$base=="Helemano Military Reservation"|df$base=="Fort Hood"),]
        }
        data=cbind(base_data$base, base_data[,cols])
        colnames(data) <- c("location",cols)
        data_df <- as.data.frame(data)
        if(input$location=="Fort Lewis"){
            data_df$location <- factor(data_df$location,levels=c(input$location, "Fort Knox", "Tripler AMC", "Helemano Military Reservation", "Fort Hood"))
        }else if(input$location=="Fort Knox"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Fort Lewis", "Tripler AMC", "Helemano Military Reservation", "Fort Hood"))
        }else if(input$location=="Tripler AMC"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Fort Lewis", "Fort Knox", "Helemano Military Reservation", "Fort Hood"))
        }else if(input$location=="Helemano Military Reservatioin"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Fort Lewis", "Fort Knox", "Tripler AMC","Fort Hood"))
        }else if(input$location=="Fort Hood"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Fort Lewis", "Fort Knox", "Tripler AMC", "Helemano Military Reservation"))
        }
        else{data_df$location <- factor(data_df$location,levels=c(input$location,"Fort Lewis", "Fort Knox", "Tripler AMC", "Helemano Military Reservation", "Fort Hood"))
        }
        data.new <- tidyr::gather(data_df, group, y, -location)
        data.new
    })

    dat3 <- reactive({
        if(input$color=="less_than_high_school"||input$color=="high_school_grad"||input$color=="some_bachelors_or_associate"||input$color=="bachelors_degree_or_higher"){
            cols <- c("less_than_high_school","high_school_grad","some_bachelors_or_associate","bachelors_degree_or_higher")
        }else if(input$color=="with_children_under_18"||input$color=="without_children_under_18"){
            cols <- c("with_children_under_18", "without_children_under_18")
        }else if(input$color=="income_below_poverty"||input$color=="income_above_poverty"){
            cols <- c("income_below_poverty", "income_above_poverty")
        }else if(input$color=="drove_alone"||input$color=="carpooled"||input$color=="public_transportation"||input$color=="walked"||input$color=="taxi_motorcycle_bike_other"||input$color=="worked_from_home"){
            cols <- c("drove_alone", "carpooled","public_transportation","walked","taxi_motorcycle_bike_other","worked_from_home")
        }else if(input$color=="never_married"||input$color=="now_married"||input$color=="separated"||input$color=="widowed"||input$color=="divorced"){
            cols <- c("never_married", "now_married","separated","walked","widowed","divorced")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="hispanic_or_latino"){
            cols <- c("hispanic_or_latino","not_hispanic_or_latino")
        }else if(input$color=="living_with_supplementary_security_income_cash_public_assistance_income_foodstamps"||input$color=="living_without_supplementary_security_income_cash_public_assistance_income_foodstamps"){
            cols <- c("living_with_supplementary_security_income_cash_public_assistance_income_foodstamps","living_without_supplementary_security_income_cash_public_assistance_income_foodstamps")
        }else if(input$color=="veteran"){
            cols <- c("veteran","non_veteran")
        }else if(input$color=="male"|input$color=="female"){
            cols <- c("female","male")
        }else if(input$color=="unemployment_status"){
            cols <- c("unemployment_status")
        }else if(input$color=="unemployment_rate"){
            cols <- c("unemployment_rate")
        }else if(input$color=="armed_forces"){
            cols <- c("armed_forces")
        }


        if(input$location=="Tooele Army Depot"){
            base_data = df[which(df$base==input$location|df$base=="Rock Island Arsenal"|df$base=="Fort Myer"|df$base=="Letterkenny Army Depot"|df$base=="Fort Lee"),]
        }else if(input$location=="Rock Island Arsenal"){
            base_data = df[which(df$base==input$location|df$base=="Tooele Army Depot"|df$base=="Fort Myer"|df$base=="Letterkenny Army Depot"|df$base=="Fort Lee"),]
        }else if(input$location=="Fort Myer"){
            base_data = df[which(df$base==input$location|df$base=="Tooele Army Depot"|df$base=="Rock Island Arsenal"|df$base=="Letterkenny Army Depot"|df$base=="Fort Lee"),]
        }else if(input$location=="Letterkenny Army Depot"){
            base_data = df[which(df$base==input$location|df$base=="Tooele Army Depot"|df$base=="Rock Island Arsenal"|df$base=="Fort Myer"|df$base=="Fort Lee"),]
        }else if(input$location=="Fort Lee"){
            base_data = df[which(df$base==input$location|df$base=="Tooele Army Depot"|df$base=="Rock Island Arsenal"|df$base=="Fort Myer"|df$base=="Letterkenny Army Depot"),]
        }
        else{base_data = df[which(df$base==input$location|df$base=="Tooele Army Depot"|df$base=="Rock Island Arsenal"|df$base=="Fort Myer"|df$base=="Letterkenny Army Depot"|df$base=="Fort Lee"),]
        }
        data=cbind(base_data$base, base_data[,cols])
        colnames(data) <- c("location",cols)
        data_df <- as.data.frame(data)
        if(input$location=="Tooele Army Depot"){
            data_df$location <- factor(data_df$location,levels=c(input$location, "Rock Island Arsenal", "Fort Myer", "Letterkenny Army Depot", "Fort Lee"))
        }else if(input$location=="Rock Island Arsenal"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Tooele Army Depot", "Fort Myer", "Letterkenny Army Depot", "Fort Lee"))
        }else if(input$location=="Fort Myer"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Tooele Army Depot", "Rock Island Arsenal", "Letterkenny Army Depot", "Fort Lee"))
        }else if(input$location=="Letterkenny Army Depot"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Tooele Army Depot", "Rock Island Arsenal", "Fort Myer", "Fort Lee"))
        }else if(input$location=="Fort Lee"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Tooele Army Depot", "Rock Island Arsenal", "Fort Myer", "Letterkenny Army Depot"))
        }
        else{data_df$location <- factor(data_df$location,levels=c(input$location,"Tooele Army Depot", "Rock Island Arsenal", "Fort Myer", "Letterkenny Army Depot", "Fort Lee"))
        }
        data.new <- tidyr::gather(data_df, group, y, -location)
        data.new

    })

    dat4 <- reactive({
        if(input$color=="less_than_high_school"||input$color=="high_school_grad"||input$color=="some_bachelors_or_associate"||input$color=="bachelors_degree_or_higher"){
            cols <- c("less_than_high_school","high_school_grad","some_bachelors_or_associate","bachelors_degree_or_higher")
        }else if(input$color=="with_children_under_18"||input$color=="without_children_under_18"){
            cols <- c("with_children_under_18", "without_children_under_18")
        }else if(input$color=="income_below_poverty"||input$color=="income_above_poverty"){
            cols <- c("income_below_poverty", "income_above_poverty")
        }else if(input$color=="drove_alone"||input$color=="carpooled"||input$color=="public_transportation"||input$color=="walked"||input$color=="taxi_motorcycle_bike_other"||input$color=="worked_from_home"){
            cols <- c("drove_alone", "carpooled","public_transportation","walked","taxi_motorcycle_bike_other","worked_from_home")
        }else if(input$color=="never_married"||input$color=="now_married"||input$color=="separated"||input$color=="widowed"||input$color=="divorced"){
            cols <- c("never_married", "now_married","separated","walked","widowed","divorced")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="hispanic_or_latino"){
            cols <- c("hispanic_or_latino","not_hispanic_or_latino")
        }else if(input$color=="living_with_supplementary_security_income_cash_public_assistance_income_foodstamps"||input$color=="living_without_supplementary_security_income_cash_public_assistance_income_foodstamps"){
            cols <- c("living_with_supplementary_security_income_cash_public_assistance_income_foodstamps","living_without_supplementary_security_income_cash_public_assistance_income_foodstamps")
        }else if(input$color=="veteran"){
            cols <- c("veteran","non_veteran")
        }else if(input$color=="male"|input$color=="female"){
            cols <- c("female","male")
        }else if(input$color=="unemployment_status"){
            cols <- c("unemployment_status")
        }else if(input$color=="unemployment_rate"){
            cols <- c("unemployment_rate")
        }else if(input$color=="armed_forces"){
            cols <- c("armed_forces")
        }


        if(input$location=="Detroit Arsenal"){
            base_data = df[which(df$base==input$location|df$base=="Presidio Of Monterey"|df$base=="Umatilla Chem Depot"|df$base=="Carlisle Barracks"|df$base=="Stewart Annex"),]
        }else if(input$location=="Presidio Of Monterey"){
            base_data = df[which(df$base==input$location|df$base=="Detroit Arsenal"|df$base=="Umatilla Chem Depot"|df$base=="Carlisle Barracks"|df$base=="Stewart Annex"),]
        }else if(input$location=="Umatilla Chem Depot"){
            base_data = df[which(df$base==input$location|df$base=="Detroit Arsenal"|df$base=="Presidio Of Monterey"|df$base=="Carlisle Barracks"|df$base=="Stewart Annex"),]
        }else if(input$location=="Carlisle Barracks"){
            base_data = df[which(df$base==input$location|df$base=="Detroit Arsenal"|df$base=="Presidio Of Monterey"|df$base=="Umatilla Chem Depot"|df$base=="Stewart Annex"),]
        }else if(input$location=="Stewart Annex"){
            base_data = df[which(df$base==input$location|df$base=="Detroit Arsenal"|df$base=="Presidio Of Monterey"|df$base=="Umatilla Chem Depot"|df$base=="Carlisle Barracks"),]
        }
        else{base_data = df[which(df$base==input$location|df$base=="Detroit Arsenal"|df$base=="Presidio Of Monterey"|df$base=="Umatilla Chem Depot"|df$base=="Carlisle Barracks"|df$base=="Stewart Annex"),]
        }
        data=cbind(base_data$base, base_data[,cols])
        colnames(data) <- c("location",cols)
        data_df <- as.data.frame(data)
        if(input$location=="Detroit Arsenal"){
            data_df$location <- factor(data_df$location,levels=c(input$location, "Presidio Of Monterey", "Umatilla Chem Depot", "Carlisle Barracks", "Stewart Annex"))
        }else if(input$location=="Presidio Of Monterey"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Detroit Arsenal", "Umatilla Chem Depot", "Carlisle Barracks", "Stewart Annex"))
        }else if(input$location=="Umatilla Chem Depot"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Detroit Arsenal", "Presidio Of Monterey", "Carlisle Barracks", "Stewart Annex"))
        }else if(input$location=="Carlisle Barracks"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Detroit Arsenal", "Presidio Of Monterey", "Umatilla Chem Depot", "Stewart Annex"))
        }else if(input$location=="Stewart Annex"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Detroit Arsenal", "Presidio Of Monterey", "Umatilla Chem Depot", "Carlisle Barracks"))
        }
        else{data_df$location <- factor(data_df$location,levels=c(input$location,"Detroit Arsenal", "Presidio Of Monterey", "Umatilla Chem Depot", "Carlisle Barracks","Stewart Annex"))
        }
        data.new <- tidyr::gather(data_df, group, y, -location)
        data.new

    })
    dat5 <- reactive({
        if(input$color=="less_than_high_school"||input$color=="high_school_grad"||input$color=="some_bachelors_or_associate"||input$color=="bachelors_degree_or_higher"){
            cols <- c("less_than_high_school","high_school_grad","some_bachelors_or_associate","bachelors_degree_or_higher")
        }else if(input$color=="with_children_under_18"||input$color=="without_children_under_18"){
            cols <- c("with_children_under_18", "without_children_under_18")
        }else if(input$color=="income_below_poverty"||input$color=="income_above_poverty"){
            cols <- c("income_below_poverty", "income_above_poverty")
        }else if(input$color=="drove_alone"||input$color=="carpooled"||input$color=="public_transportation"||input$color=="walked"||input$color=="taxi_motorcycle_bike_other"||input$color=="worked_from_home"){
            cols <- c("drove_alone", "carpooled","public_transportation","walked","taxi_motorcycle_bike_other","worked_from_home")
        }else if(input$color=="never_married"||input$color=="now_married"||input$color=="separated"||input$color=="widowed"||input$color=="divorced"){
            cols <- c("never_married", "now_married","separated","walked","widowed","divorced")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="white_alone"||input$color=="black_or_african_american_alone"||input$color=="asian_alone"||input$color=="native_hawaiian_and_other_pacific_islander_alone"||input$color=="some_other_race_alone"||input$color=="two_or_more_races"){
            cols <- c("white_alone","black_or_african_american_alone","asian_alone","native_hawaiian_and_other_pacific_islander_alone","some_other_race_alone","two_or_more_races")
        }else if(input$color=="hispanic_or_latino"){
            cols <- c("hispanic_or_latino","not_hispanic_or_latino")
        }else if(input$color=="living_with_supplementary_security_income_cash_public_assistance_income_foodstamps"||input$color=="living_without_supplementary_security_income_cash_public_assistance_income_foodstamps"){
            cols <- c("living_with_supplementary_security_income_cash_public_assistance_income_foodstamps","living_without_supplementary_security_income_cash_public_assistance_income_foodstamps")
        }else if(input$color=="veteran"){
            cols <- c("veteran","non_veteran")
        }else if(input$color=="male"|input$color=="female"){
            cols <- c("female","male")
        }else if(input$color=="unemployment_status"){
            cols <- c("unemployment_status")
        }else if(input$color=="unemployment_rate"){
            cols <- c("unemployment_rate")
        }else if(input$color=="armed_forces"){
            cols <- c("armed_forces")
        }

        if(input$location=="Brown Stagefield"){
            base_data = df[which(df$base==input$location|df$base=="Toth Stagefield"|df$base=="Cairns Basefield"|df$base=="Kawaihae Military Reserve"|df$base=="Skelly Stagefield"),]
        }else if(input$location=="Toth Stagefield"){
            base_data = df[which(df$base==input$location|df$base=="Brown Stagefield"|df$base=="Cairns Basefield"|df$base=="Kawaihae Military Reserve"|df$base=="Skelly Stagefield"),]
        }else if(input$location=="Cairns Basefield"){
            base_data = df[which(df$base==input$location|df$base=="Brown Stagefield"|df$base=="Toth Stagefield"|df$base=="Kawaihae Military Reserve"|df$base=="Skelly Stagefield"),]
        }else if(input$location=="Kawaihae Military Reserve"){
            base_data = df[which(df$base==input$location|df$base=="Brown Stagefield"|df$base=="Toth Stagefield"|df$base=="Cairns Basefield"|df$base=="Skelly Stagefield"),]
        }else if(input$location=="Skelly Stagefield"){
            base_data = df[which(df$base==input$location|df$base=="Brown Stagefield"|df$base=="Toth Stagefield"|df$base=="Cairns Basefield"|df$base=="Kawaihae Military Reserve"),]
        }
        else{base_data = df[which(df$base==input$location|df$base=="Brown Stagefield"|df$base=="Toth Stagefield"|df$base=="Cairns Basefield"|df$base=="Kawaihae Military Reserve"|df$base=="Skelly Stagefield"),]
        }
        data=cbind(base_data$base, base_data[,cols])
        colnames(data) <- c("location",cols)
        data_df <- as.data.frame(data)
        if(input$location=="Brown Stagefield"){
            data_df$location <- factor(data_df$location,levels=c(input$location, "Toth Stagefield", "Cairns Basefield", "Kawaihae Military Reserve", "Skelly Stagefield"))
        }else if(input$location=="Toth Stagefield"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Brown Stagefield", "Cairns Basefield", "Kawaihae Military Reserve", "Skelly Stagefield"))
        }else if(input$location=="Cairns Basefield"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Brown Stagefield", "Toth Stagefield", "Kawaihae Military Reserve", "Skelly Stagefield"))
        }else if(input$location=="Kawaihae Military Reserve"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Brown Stagefield", "Toth Stagefield", "Cairns Basefield", "Skelly Stagefield"))
        }else if(input$location=="Skelly Stagefield"){
            data_df$location <- factor(data_df$location,levels=c(input$location,"Brown Stagefield", "Toth Stagefield", "Cairns Basefield", "Kawaihae Military Reserve"))
        }
        else{data_df$location <- factor(data_df$location,levels=c(input$location,"Brown Stagefield", "Toth Stagefield", "Cairns Basefield", "Kawaihae Military Reserve", "Skelly Stagefield"))
        }
        data.new <- tidyr::gather(data_df, group, y, -location)
        data.new

    })

    output$plot <-renderPlot({
        colors <-c("#ff1884","#138b99","#4f9913","#154c99","#991489","#ef8b09","#ffae19")
        if(input$plots=="Surrounding County"){
            #call reactive dataset
            d <- dat_surrounding_county()
            group.colors=colors[1:(nrow(d)/2)]
            ggplot(d, aes(x=location, y=as.numeric(as.character(y))))+
                geom_bar(aes(fill=group), alpha=.8,stat="identity")+
                labs(title="County Average to Army Installation Average")+
                scale_fill_manual(values= group.colors)+
                theme(legend.position="bottom", legend.direction="vertical")+
                theme(axis.text.x = element_text(angle=45, hjust=1, size=10))+
                theme(panel.background = element_rect(fill = NA),panel.grid.major = element_line(colour = "gainsboro"))+
                ylab("Percent Of Population")+xlab("Location")+
                theme(plot.title=element_text(size=11, face="bold"), axis.title=element_text(size=10))+coord_cartesian(ylim=c(0,1))
        }else if(input$plots=="Selected Large Bases (population > 50,000)"){
            d <- dat_selected_large_bases()
            group.colors=colors[1:(nrow(d)/2)]
            ggplot(d, aes(x=location, y=as.numeric(as.character(y))))+
                geom_rect(xmin=1-.45, xmax=1+.45,ymin=-.1,ymax=1.1, fill=rgb(145, 154, 158,maxColorValue = 255))+
                geom_bar(aes(fill=group), alpha=.8,stat="identity")+
                labs(title="County Average to Army Installation Average")+
                scale_fill_manual(values= group.colors)+
                theme(legend.position="bottom", legend.direction="vertical")+
                theme(axis.text.x = element_text(angle=45, hjust=1, size=10))+
                theme(panel.background = element_rect(fill = NA),panel.grid.major = element_line(colour = "gainsboro"))+
                ylab("Percent Of Population")+xlab("Location")+
                theme(plot.title=element_text(size=11, face="bold"), axis.title=element_text(size=10))+coord_cartesian(ylim=c(0,1))
        }
        else if(input$plots=="Selected Medium-Large Bases (population 25,000- 50,000)"){
            d <- dat3()
            group.colors=colors[1:(nrow(d)/2)]
            ggplot(d, aes(x=location, y=as.numeric(as.character(y))))+
                geom_rect(xmin=1-.45, xmax=1+.45,ymin=-.1,ymax=1.1, fill=rgb(145, 154, 158,maxColorValue = 255))+
                geom_bar(aes(fill=group), alpha=.8,stat="identity")+
                labs(title="County Average to Army Installation Average")+
                scale_fill_manual(values= group.colors)+
                theme(legend.position="bottom", legend.direction="vertical")+
                theme(axis.text.x = element_text(angle=45, hjust=1, size=10))+
                theme(panel.background = element_rect(fill = NA),panel.grid.major = element_line(colour = "gainsboro"))+
                ylab("Percent Of Population")+xlab("Location")+
                theme(plot.title=element_text(size=11, face="bold"), axis.title=element_text(size=10))+coord_cartesian(ylim=c(0,1))
        }
        else if(input$plots=="Selected Medium-Small Bases (population 10,000-25,000)"){
            d <- dat4()
            group.colors=colors[1:(nrow(d)/2)]
            ggplot(d, aes(x=location, y=as.numeric(as.character(y))))+
                geom_rect(xmin=1-.45, xmax=1+.45,ymin=-.1,ymax=1.1, fill=rgb(145, 154, 158,maxColorValue = 255))+
                geom_bar(aes(fill=group), alpha=.8,stat="identity")+
                labs(title="County Average to Army Installation Average")+
                scale_fill_manual(values= group.colors)+
                theme(legend.position="bottom", legend.direction="vertical")+
                theme(axis.text.x = element_text(angle=45, hjust=1, size=10))+
                theme(panel.background = element_rect(fill = NA),panel.grid.major = element_line(colour = "gainsboro"))+
                ylab("Percent Of Population")+xlab("Location")+
                theme(plot.title=element_text(size=11, face="bold"), axis.title=element_text(size=10))+coord_cartesian(ylim=c(0,1))
        }else if(input$plots=="Selected Small Bases (population < 10,000)"){
            d <- dat5()
            group.colors=colors[1:(nrow(d)/2)]
            ggplot(d, aes(x=location, y=as.numeric(as.character(y))))+
                geom_rect(xmin=1-.45, xmax=1+.45,ymin=-.1,ymax=1.1, fill=rgb(145, 154, 158,maxColorValue = 255))+
                geom_bar(aes(fill=group), alpha=.8,stat="identity")+
                labs(title="County Average to Army Installation Average")+
                scale_fill_manual(values= group.colors)+
                theme(legend.position="bottom", legend.direction="vertical")+
                theme(axis.text.x = element_text(angle=45, hjust=1, size=10))+
                theme(panel.background = element_rect(fill = NA),panel.grid.major = element_line(colour = "gainsboro"))+
                ylab("Percent Of Population")+xlab("Location")+
                theme(plot.title=element_text(size=11, face="bold"), axis.title=element_text(size=10))+coord_cartesian(ylim=c(0,1))
        }
    })


    observe({
        colorBy <- input$color

        colorData <- df[[colorBy]]
        colorRange <- c( floor( min(colorData)/.1)*.1, ceiling(max(colorData/.1))*.1 )
        colorSeq <- round( seq(colorRange[1],colorRange[2],length=9), 2 )
        cbbPalette <- c("#ffbfd0","#ff93b0","#ef6e90","#e23865","#dd1349","#db003a","#ce0238","#9e0029","#72001d","#4f0014")
        pal <- colorBin(cbbPalette, colorData, colorSeq, pretty = TRUE)

        leafletProxy("map", data = df) %>%
            clearShapes() %>%
            addCircleMarkers(~long, ~lat, radius=df$population^(1/4), layerId=~base,popup=~htmlEscape(df$base),
                             stroke=FALSE, fillOpacity=0.6, fillColor=pal(colorData)) %>%
            addLegend("bottomleft", pal=pal, values=colorData, title=colorBy,
                      layerId="colorLegend")

    })

    output$tbl = DT::renderDataTable(
        df, options = list(lengthChange = FALSE))


})


